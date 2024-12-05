from fastapi import FastAPI, WebSocket, WebSocketDisconnect, APIRouter
from typing import List
from pydantic import BaseModel
import random

router = APIRouter()

class User:
    def __init__(self, user_id: int, websocket: WebSocket):
        self.user_id = user_id
        self.websocket = websocket


user_list = []

# Store connected driver WebSockets
class DriverConnector:
    def __init__(self):
        self.active_connections: List[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def broadcast(self, message: str):
        for connection in self.active_connections:
            await connection.send_text(message)

driverConnector = DriverConnector()

# WebSocket endpoint for drivers
@router.websocket("/driver")
async def driver_endpoint(websocket: WebSocket):
    await driverConnector.connect(websocket)
    # try:
    #     while True:
    #         # Keep the connection alive
    #         await websocket.receive_text()
    # except WebSocketDisconnect:
    #     driverConnector.disconnect(websocket)

# Websocket endpoint for users
@router.websocket("/user")
async def user_endpoint(websocket: WebSocket):
    await websocket.accept()
    user_location = await websocket.receive_text()
    user_id = random.randint(100, 10000)
    user_list.append(User(user_id, websocket))
    await driverConnector.broadcast(f"{user_id},{user_location}")
    print(f"{user_id},{user_location}  :  searching")


class AcceptRideModel(BaseModel):
    user_id: int
    driver_lat: float
    driver_lng: float

# API endpoint to accept ride
@router.post("/ride/accept")
async def accept_ride_route(request: AcceptRideModel):
    user = [x for x in user_list if x.user_id == request.user_id][0]
    user.websocket.send_text(f"{request.driver_lat},{request.driver_lng}")
    print(f"{request.user_id}  :  Accepted")
