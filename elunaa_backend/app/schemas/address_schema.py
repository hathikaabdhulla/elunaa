from typing import Optional

from pydantic import BaseModel, ConfigDict


class AddressCreate(BaseModel):
    full_name: str
    phone: str
    address_line1: str
    address_line2: Optional[str] = None
    city: str
    state: str
    pincode: str
    country: str = "India"
    address_type: str = "Home"
    is_default: bool = False


class AddressUpdate(BaseModel):
    full_name: Optional[str] = None
    phone: Optional[str] = None
    address_line1: Optional[str] = None
    address_line2: Optional[str] = None
    city: Optional[str] = None
    state: Optional[str] = None
    pincode: Optional[str] = None
    country: Optional[str] = None
    address_type: Optional[str] = None
    is_default: Optional[bool] = None


class AddressOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    full_name: str
    phone: str
    address_line1: str
    address_line2: Optional[str] = None
    city: str
    state: str
    pincode: str
    country: str
    address_type: str
    is_default: bool
