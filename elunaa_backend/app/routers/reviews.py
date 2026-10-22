from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.models.review import Review
from app.models.product import Product
from app.schemas.review_schema import ReviewCreate, ReviewUpdate, ReviewOut

router = APIRouter(prefix="/api/reviews", tags=["Reviews"])


@router.get("/product/{product_id}", response_model=list[ReviewOut])
def get_product_reviews(product_id: int, db: Session = Depends(get_db)):
    return db.query(Review).filter(Review.product_id == product_id).order_by(Review.created_at.desc()).all()


@router.post("", response_model=ReviewOut, status_code=201)
def write_review(
    payload: ReviewCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    product = db.query(Product).filter(Product.id == payload.product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")

    existing = (
        db.query(Review)
        .filter(Review.user_id == current_user.id, Review.product_id == payload.product_id)
        .first()
    )
    if existing:
        raise HTTPException(status_code=400, detail="You already reviewed this product")

    review = Review(user_id=current_user.id, **payload.model_dump())
    db.add(review)
    db.commit()
    db.refresh(review)
    return review


@router.put("/{review_id}", response_model=ReviewOut)
def update_review(
    review_id: int,
    payload: ReviewUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    review = (
        db.query(Review)
        .filter(Review.id == review_id, Review.user_id == current_user.id)
        .first()
    )
    if not review:
        raise HTTPException(status_code=404, detail="Review not found")

    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(review, field, value)

    db.commit()
    db.refresh(review)
    return review


@router.delete("/{review_id}", status_code=204)
def delete_review(
    review_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    review = (
        db.query(Review)
        .filter(Review.id == review_id, Review.user_id == current_user.id)
        .first()
    )
    if not review:
        raise HTTPException(status_code=404, detail="Review not found")
    db.delete(review)
    db.commit()
