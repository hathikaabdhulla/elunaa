from typing import List, Optional

from pydantic import BaseModel, ConfigDict

from app.schemas.product_schema import ProductOut


class CartItemCreate(BaseModel):
    product_id: int
    quantity: int = 1


class CartItemUpdate(BaseModel):
    quantity: int


class CartItemOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    product_id: int
    quantity: int
    product: Optional[ProductOut] = None


class CartResponse(BaseModel):
    items: List[CartItemOut]
    subtotal: float
    total_items: int


class WishlistItemOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    product_id: int
    product: Optional[ProductOut] = None


class WishlistCreate(BaseModel):
    product_id: int
