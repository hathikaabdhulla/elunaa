from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.database import Base, engine
from app import models  # noqa: F401 - ensures all models are registered on Base
from app.routers import (
    auth,
    products,
    cart,
    wishlist,
    orders,
    payment,
    address,
    reviews,
    profile,
    notifications,
)

# Creates tables if they don't exist yet.
# For production, prefer a migration tool such as Alembic instead.
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Elunaa Backend API",
    description="Backend API powering the Elunaa Flutter e-commerce app",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # tighten this in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(products.router)
app.include_router(cart.router)
app.include_router(wishlist.router)
app.include_router(orders.router)
app.include_router(payment.router)
app.include_router(address.router)
app.include_router(reviews.router)
app.include_router(profile.router)
app.include_router(notifications.router)


@app.get("/", tags=["Health"])
def root():
    return {"status": "ok", "message": "Elunaa backend is running"}


@app.get("/health", tags=["Health"])
def health_check():
    return {"status": "healthy"}
