from datetime import datetime
from typing import Optional, List

from pydantic import BaseModel, ConfigDict


class CategoryOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    name: str
    image: Optional[str] = None


class CategoryCreate(BaseModel):
    name: str
    image: Optional[str] = None


class ProductCreate(BaseModel):
    name: str
    description: Optional[str] = None
    brand: Optional[str] = None
    price: float
    discount_price: Optional[float] = None
    stock: int = 0
    image_url: Optional[str] = None
    images: Optional[str] = None
    category_id: Optional[int] = None


class ProductUpdate(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None
    brand: Optional[str] = None
    price: Optional[float] = None
    discount_price: Optional[float] = None
    stock: Optional[int] = None
    image_url: Optional[str] = None
    images: Optional[str] = None
    category_id: Optional[int] = None
    is_active: Optional[bool] = None


class ProductOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
    description: Optional[str] = None
    brand: Optional[str] = None
    price: float
    discount_price: Optional[float] = None
    stock: int
    image_url: Optional[str] = None
    images: Optional[str] = None
    is_active: bool
    category_id: Optional[int] = None
    created_at: datetime


class ProductListResponse(BaseModel):
    total: int
    page: int
    page_size: int
    items: List[ProductOut]
