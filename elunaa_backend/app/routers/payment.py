from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session

from app.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.models.order import Order, PaymentStatus

router = APIRouter(prefix="/api/payment", tags=["Payment"])


class PaymentInitRequest(BaseModel):
    order_id: int
    method: str  # Card, UPI, Wallet, COD


class PaymentInitResponse(BaseModel):
    order_id: int
    payment_session_id: str
    amount: float
    method: str


class PaymentVerifyRequest(BaseModel):
    order_id: int
    payment_reference: str
    success: bool


@router.post("/init", response_model=PaymentInitResponse)
def init_payment(
    payload: PaymentInitRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    order = db.query(Order).filter(Order.id == payload.order_id, Order.user_id == current_user.id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")

    # TODO: integrate a real payment gateway (Razorpay/Stripe/PayU) here and
    # return its actual session/order id instead of this placeholder value.
    session_id = f"PAY-{order.id}-{order.tracking_id}"
    order.payment_method = payload.method
    db.commit()

    return PaymentInitResponse(
        order_id=order.id,
        payment_session_id=session_id,
        amount=order.total_amount,
        method=payload.method,
    )


@router.post("/verify")
def verify_payment(
    payload: PaymentVerifyRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    order = db.query(Order).filter(Order.id == payload.order_id, Order.user_id == current_user.id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")

    # TODO: verify the payment_reference signature against the payment gateway's webhook/response.
    order.payment_status = PaymentStatus.PAID if payload.success else PaymentStatus.FAILED
    db.commit()

    return {"order_id": order.id, "payment_status": order.payment_status}
