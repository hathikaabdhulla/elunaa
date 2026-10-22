from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from sqlalchemy import or_

from app.database import get_db
from app.models.product import Product
from app.models.category import Category
from app.schemas.product_schema import (
    ProductOut,
    ProductCreate,
    ProductUpdate,
    ProductListResponse,
    CategoryOut,
    CategoryCreate,
)

router = APIRouter(prefix="/api/products", tags=["Products"])


@router.get("", response_model=ProductListResponse)
def list_products(
    page: int = Query(1, ge=1),
    page_size: int = Query(20, ge=1, le=100),
    category_id: Optional[int] = None,
    brand: Optional[str] = None,
    min_price: Optional[float] = None,
    max_price: Optional[float] = None,
    sort_by: Optional[str] = Query(None, description="price_asc, price_desc, newest"),
    db: Session = Depends(get_db),
):
    query = db.query(Product).filter(Product.is_active == True)  # noqa: E712

    if category_id:
        query = query.filter(Product.category_id == category_id)
    if brand:
        query = query.filter(Product.brand == brand)
    if min_price is not None:
        query = query.filter(Product.price >= min_price)
    if max_price is not None:
        query = query.filter(Product.price <= max_price)

    if sort_by == "price_asc":
        query = query.order_by(Product.price.asc())
    elif sort_by == "price_desc":
        query = query.order_by(Product.price.desc())
    else:
        query = query.order_by(Product.created_at.desc())

    total = query.count()
    items = query.offset((page - 1) * page_size).limit(page_size).all()

    return ProductListResponse(total=total, page=page, page_size=page_size, items=items)


@router.get("/search", response_model=ProductListResponse)
def search_products(
    q: str = Query(..., min_length=1),
    page: int = Query(1, ge=1),
    page_size: int = Query(20, ge=1, le=100),
    db: Session = Depends(get_db),
):
    query = db.query(Product).filter(
        Product.is_active == True,  # noqa: E712
        or_(Product.name.ilike(f"%{q}%"), Product.brand.ilike(f"%{q}%"), Product.description.ilike(f"%{q}%")),
    )
    total = query.count()
    items = query.offset((page - 1) * page_size).limit(page_size).all()
    return ProductListResponse(total=total, page=page, page_size=page_size, items=items)


@router.get("/categories", response_model=list[CategoryOut])
def list_categories(db: Session = Depends(get_db)):
    return db.query(Category).all()


@router.post("/categories", response_model=CategoryOut, status_code=201)
def create_category(payload: CategoryCreate, db: Session = Depends(get_db)):
    category = Category(**payload.model_dump())
    db.add(category)
    db.commit()
    db.refresh(category)
    return category


@router.get("/brands", response_model=list[str])
def list_brands(db: Session = Depends(get_db)):
    rows = db.query(Product.brand).filter(Product.brand.isnot(None)).distinct().all()
    return [r[0] for r in rows]


@router.get("/{product_id}", response_model=ProductOut)
def get_product(product_id: int, db: Session = Depends(get_db)):
    product = db.query(Product).filter(Product.id == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    return product


@router.post("", response_model=ProductOut, status_code=201)
def create_product(payload: ProductCreate, db: Session = Depends(get_db)):
    product = Product(**payload.model_dump())
    db.add(product)
    db.commit()
    db.refresh(product)
    return product


@router.put("/{product_id}", response_model=ProductOut)
def update_product(product_id: int, payload: ProductUpdate, db: Session = Depends(get_db)):
    product = db.query(Product).filter(Product.id == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")

    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(product, field, value)

    db.commit()
    db.refresh(product)
    return product


@router.delete("/{product_id}", status_code=204)
def delete_product(product_id: int, db: Session = Depends(get_db)):
    product = db.query(Product).filter(Product.id == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    db.delete(product)
    db.commit()
