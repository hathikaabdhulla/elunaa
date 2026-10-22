from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.models.cart import CartItem
from app.models.product import Product
from app.schemas.cart_schema import CartItemCreate, CartItemUpdate, CartItemOut, CartResponse

router = APIRouter(prefix="/api/cart", tags=["Cart"])


@router.get("", response_model=CartResponse)
def get_cart(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    items = db.query(CartItem).filter(CartItem.user_id == current_user.id).all()
    subtotal = 0.0
    for item in items:
        price = item.product.discount_price or item.product.price
        subtotal += price * item.quantity

    return CartResponse(items=items, subtotal=subtotal, total_items=len(items))


@router.post("", response_model=CartItemOut, status_code=201)
def add_to_cart(
    payload: CartItemCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    product = db.query(Product).filter(Product.id == payload.product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")

    existing = (
        db.query(CartItem)
        .filter(CartItem.user_id == current_user.id, CartItem.product_id == payload.product_id)
        .first()
    )
    if existing:
        existing.quantity += payload.quantity
        db.commit()
        db.refresh(existing)
        return existing

    cart_item = CartItem(user_id=current_user.id, product_id=payload.product_id, quantity=payload.quantity)
    db.add(cart_item)
    db.commit()
    db.refresh(cart_item)
    return cart_item


@router.put("/{cart_item_id}", response_model=CartItemOut)
def update_cart_item(
    cart_item_id: int,
    payload: CartItemUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    item = (
        db.query(CartItem)
        .filter(CartItem.id == cart_item_id, CartItem.user_id == current_user.id)
        .first()
    )
    if not item:
        raise HTTPException(status_code=404, detail="Cart item not found")

    if payload.quantity <= 0:
        db.delete(item)
        db.commit()
        raise HTTPException(status_code=200, detail="Item removed")

    item.quantity = payload.quantity
    db.commit()
    db.refresh(item)
    return item


@router.delete("/{cart_item_id}", status_code=204)
def remove_from_cart(
    cart_item_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    item = (
        db.query(CartItem)
        .filter(CartItem.id == cart_item_id, CartItem.user_id == current_user.id)
        .first()
    )
    if not item:
        raise HTTPException(status_code=404, detail="Cart item not found")
    db.delete(item)
    db.commit()


@router.delete("", status_code=204)
def clear_cart(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    db.query(CartItem).filter(CartItem.user_id == current_user.id).delete()
    db.commit()
