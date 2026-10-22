import uuid

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.models.order import Order, OrderItem, OrderStatus, PaymentStatus
from app.models.cart import CartItem
from app.models.product import Product
from app.models.address import Address
from app.schemas.order_schema import OrderCreate, OrderOut, OrderStatusUpdate, BuyNowRequest

router = APIRouter(prefix="/api/orders", tags=["Orders"])


def _validate_address(db: Session, address_id: int, user_id: int) -> Address:
    address = db.query(Address).filter(Address.id == address_id, Address.user_id == user_id).first()
    if not address:
        raise HTTPException(status_code=404, detail="Address not found")
    return address


@router.get("", response_model=list[OrderOut])
def list_orders(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return (
        db.query(Order)
        .filter(Order.user_id == current_user.id)
        .order_by(Order.created_at.desc())
        .all()
    )


@router.post("", response_model=OrderOut, status_code=201)
def create_order(
    payload: OrderCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Checkout: converts the cart (or explicit items) into an Order."""
    _validate_address(db, payload.address_id, current_user.id)

    if payload.items:
        source_items = [(i.product_id, i.quantity) for i in payload.items]
    else:
        cart_items = db.query(CartItem).filter(CartItem.user_id == current_user.id).all()
        if not cart_items:
            raise HTTPException(status_code=400, detail="Cart is empty")
        source_items = [(c.product_id, c.quantity) for c in cart_items]

    order = Order(
        user_id=current_user.id,
        address_id=payload.address_id,
        payment_method=payload.payment_method,
        total_amount=0.0,
        status=OrderStatus.PENDING,
        payment_status=PaymentStatus.PENDING,
        tracking_id=str(uuid.uuid4())[:8].upper(),
    )
    db.add(order)
    db.flush()  # get order.id before commit

    total = 0.0
    for product_id, quantity in source_items:
        product = db.query(Product).filter(Product.id == product_id).first()
        if not product:
            raise HTTPException(status_code=404, detail=f"Product {product_id} not found")
        if product.stock < quantity:
            raise HTTPException(status_code=400, detail=f"Insufficient stock for {product.name}")

        price = product.discount_price or product.price
        total += price * quantity
        product.stock -= quantity

        db.add(OrderItem(order_id=order.id, product_id=product_id, quantity=quantity, price=price))

    order.total_amount = total

    if not payload.items:
        db.query(CartItem).filter(CartItem.user_id == current_user.id).delete()

    db.commit()
    db.refresh(order)
    return order


@router.post("/buy-now", response_model=OrderOut, status_code=201)
def buy_now(
    payload: BuyNowRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Direct purchase of a single product, bypassing the cart."""
    order_payload = OrderCreate(
        address_id=payload.address_id,
        payment_method=payload.payment_method,
        items=[{"product_id": payload.product_id, "quantity": payload.quantity}],
    )
    return create_order(order_payload, db=db, current_user=current_user)


@router.get("/{order_id}", response_model=OrderOut)
def get_order_detail(
    order_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    order = db.query(Order).filter(Order.id == order_id, Order.user_id == current_user.id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    return order


@router.get("/{order_id}/track", response_model=OrderOut)
def track_order(
    order_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    order = db.query(Order).filter(Order.id == order_id, Order.user_id == current_user.id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    return order


@router.put("/{order_id}/status", response_model=OrderOut)
def update_order_status(
    order_id: int,
    payload: OrderStatusUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Admin-style endpoint; add role-based checks in dependencies for production use."""
    order = db.query(Order).filter(Order.id == order_id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    order.status = payload.status
    db.commit()
    db.refresh(order)
    return order


@router.post("/{order_id}/cancel", response_model=OrderOut)
def cancel_order(
    order_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    order = db.query(Order).filter(Order.id == order_id, Order.user_id == current_user.id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    if order.status in (OrderStatus.DELIVERED, OrderStatus.CANCELLED):
        raise HTTPException(status_code=400, detail=f"Cannot cancel an order that is {order.status}")

    order.status = OrderStatus.CANCELLED
    for item in order.items:
        product = db.query(Product).filter(Product.id == item.product_id).first()
        if product:
            product.stock += item.quantity

    db.commit()
    db.refresh(order)
    return order
