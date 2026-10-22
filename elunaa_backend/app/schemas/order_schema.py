from datetime import datetime
from typing import List, Optional

from pydantic import BaseModel, ConfigDict

from app.models.order import OrderStatus, PaymentStatus


class OrderItemCreate(BaseModel):
    product_id: int
    quantity: int


class OrderItemOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    product_id: int
    quantity: int
    price: float


class OrderCreate(BaseModel):
    address_id: int
    payment_method: str  # COD, Card, UPI, Wallet
    items: Optional[List[OrderItemCreate]] = None  # None = checkout entire cart


class OrderOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    address_id: int
    total_amount: float
    status: OrderStatus
    payment_status: PaymentStatus
    payment_method: Optional[str] = None
    tracking_id: Optional[str] = None
    created_at: datetime
    items: List[OrderItemOut] = []


class OrderStatusUpdate(BaseModel):
    status: OrderStatus


class BuyNowRequest(BaseModel):
    product_id: int
    quantity: int = 1
    address_id: int
    payment_method: str
