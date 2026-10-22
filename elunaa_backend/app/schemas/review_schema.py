from datetime import datetime
from typing import Optional

from pydantic import BaseModel, ConfigDict, Field


class ReviewCreate(BaseModel):
    product_id: int
    rating: int = Field(ge=1, le=5)
    title: Optional[str] = None
    comment: Optional[str] = None


class ReviewUpdate(BaseModel):
    rating: Optional[int] = Field(default=None, ge=1, le=5)
    title: Optional[str] = None
    comment: Optional[str] = None


class ReviewOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    user_id: int
    product_id: int
    rating: int
    title: Optional[str] = None
    comment: Optional[str] = None
    created_at: datetime
