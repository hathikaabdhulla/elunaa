from sqlalchemy import Column, Integer, String, Float, Text, ForeignKey, DateTime, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.database import Base


class Product(Base):
    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(200), nullable=False, index=True)
    description = Column(Text, nullable=True)
    brand = Column(String(100), nullable=True, index=True)
    price = Column(Float, nullable=False)
    discount_price = Column(Float, nullable=True)
    stock = Column(Integer, default=0)
    image_url = Column(String(255), nullable=True)
    images = Column(Text, nullable=True)  # comma-separated URLs or JSON string
    is_active = Column(Boolean, default=True)
    category_id = Column(Integer, ForeignKey("categories.id"), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    category = relationship("Category", back_populates="products")
    cart_items = relationship("CartItem", back_populates="product", cascade="all, delete-orphan")
    wishlist_items = relationship("WishlistItem", back_populates="product", cascade="all, delete-orphan")
    reviews = relationship("Review", back_populates="product", cascade="all, delete-orphan")
    order_items = relationship("OrderItem", back_populates="product")
