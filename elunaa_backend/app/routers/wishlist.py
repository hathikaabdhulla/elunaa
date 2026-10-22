from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.models.wishlist import WishlistItem
from app.models.product import Product
from app.schemas.cart_schema import WishlistCreate, WishlistItemOut

router = APIRouter(prefix="/api/wishlist", tags=["Wishlist"])


@router.get("", response_model=list[WishlistItemOut])
def get_wishlist(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(WishlistItem).filter(WishlistItem.user_id == current_user.id).all()


@router.post("", response_model=WishlistItemOut, status_code=201)
def add_to_wishlist(
    payload: WishlistCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    product = db.query(Product).filter(Product.id == payload.product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")

    existing = (
        db.query(WishlistItem)
        .filter(WishlistItem.user_id == current_user.id, WishlistItem.product_id == payload.product_id)
        .first()
    )
    if existing:
        return existing

    item = WishlistItem(user_id=current_user.id, product_id=payload.product_id)
    db.add(item)
    db.commit()
    db.refresh(item)
    return item


@router.delete("/{item_id}", status_code=204)
def remove_from_wishlist(
    item_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    item = (
        db.query(WishlistItem)
        .filter(WishlistItem.id == item_id, WishlistItem.user_id == current_user.id)
        .first()
    )
    if not item:
        raise HTTPException(status_code=404, detail="Wishlist item not found")
    db.delete(item)
    db.commit()
