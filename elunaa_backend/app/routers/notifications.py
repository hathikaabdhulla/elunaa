from datetime import datetime

from fastapi import APIRouter, Depends
from pydantic import BaseModel

from app.dependencies import get_current_user
from app.models.user import User

router = APIRouter(prefix="/api/notifications", tags=["Notifications"])


class NotificationOut(BaseModel):
    id: int
    title: str
    message: str
    is_read: bool
    created_at: datetime


# NOTE: Demo in-memory data. Replace with a Notification DB model + table
# once push/email notification events are wired up.
_DEMO_NOTIFICATIONS: list[NotificationOut] = [
    NotificationOut(
        id=1,
        title="Welcome to Elunaa!",
        message="Thanks for joining. Explore our latest collection.",
        is_read=False,
        created_at=datetime.utcnow(),
    ),
]


@router.get("", response_model=list[NotificationOut])
def list_notifications(current_user: User = Depends(get_current_user)):
    return _DEMO_NOTIFICATIONS


@router.put("/{notification_id}/read", response_model=NotificationOut)
def mark_as_read(notification_id: int, current_user: User = Depends(get_current_user)):
    for n in _DEMO_NOTIFICATIONS:
        if n.id == notification_id:
            n.is_read = True
            return n
    return {"detail": "Notification not found"}
