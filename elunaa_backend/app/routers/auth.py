import random

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database import get_db
from app.models.user import User
from app.schemas.user_schema import (
    UserSignup,
    UserLogin,
    UserOut,
    Token,
    ForgotPasswordRequest,
    ResetPasswordRequest,
)
from app.auth_utils.hashing import hash_password, verify_password
from app.auth_utils.jwt_handler import create_access_token

router = APIRouter(prefix="/api/auth", tags=["Auth"])

# In-memory OTP store for demo purposes.
# Replace with Redis / DB-backed store + real SMS/email sending in production.
_otp_store: dict[str, str] = {}


@router.post("/signup", response_model=Token, status_code=status.HTTP_201_CREATED)
def signup(payload: UserSignup, db: Session = Depends(get_db)):
    existing = db.query(User).filter(User.email == payload.email).first()
    if existing:
        raise HTTPException(status_code=400, detail="Email already registered")

    user = User(
        full_name=payload.full_name,
        email=payload.email,
        phone=payload.phone,
        hashed_password=hash_password(payload.password),
    )
    db.add(user)
    db.commit()
    db.refresh(user)

    token = create_access_token({"user_id": user.id})
    return Token(access_token=token, user=UserOut.model_validate(user))


@router.post("/login", response_model=Token)
def login(payload: UserLogin, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == payload.email).first()
    if not user or not verify_password(payload.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid email or password")
    if not user.is_active:
        raise HTTPException(status_code=400, detail="Account is disabled")

    token = create_access_token({"user_id": user.id})
    return Token(access_token=token, user=UserOut.model_validate(user))


@router.post("/forgot-password")
def forgot_password(payload: ForgotPasswordRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == payload.email).first()
    if not user:
        # Do not reveal whether an email exists.
        return {"message": "If that email exists, an OTP has been sent."}

    otp = f"{random.randint(0, 999999):06d}"
    _otp_store[payload.email] = otp

    # TODO: integrate real email/SMS provider to actually deliver the OTP.
    return {"message": "OTP sent to your email.", "debug_otp": otp}


@router.post("/reset-password")
def reset_password(payload: ResetPasswordRequest, db: Session = Depends(get_db)):
    stored_otp = _otp_store.get(payload.email)
    if not stored_otp or stored_otp != payload.otp:
        raise HTTPException(status_code=400, detail="Invalid or expired OTP")

    user = db.query(User).filter(User.email == payload.email).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.hashed_password = hash_password(payload.new_password)
    db.commit()
    _otp_store.pop(payload.email, None)

    return {"message": "Password reset successful"}
