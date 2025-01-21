from fastapi import APIRouter, HTTPException
import asyncio
import random
import threading

from repos.ride import *
from utils.response import CustomResponse

router = APIRouter()


class RideManager:
    def __init__(self):
        self.requested_rides: List[Ride] = []
        self.ongoing_rides: List[Ride] = []

    def add_request(self, ride: Ride):
        ride.id = random.randint(1000, 10000000000)
        self.requested_rides.append(ride)

    def list_requests(self):
        return self.requested_rides

    def accept_requests(self, ride_id: int) -> bool:






@router.post("/add")
async def add_ride_route(request: Ride):
    print(request)
    rides.append(request)
    return CustomResponse(detail="Ride added")


@router.post("/list")
async def list_rides_route() -> List[Ride]:
    return rides

class AcceptRideRequest(BaseModel):
    ride_id: int

@router.post("/accept")
async def accept_ride_route(request: AcceptRideRequest) -> CustomResponse:
    for ride in rides:
        if ride.ride_id == request.ride_id:
            rides.remove(ride)
            return CustomResponse(detail="Accepted")

    raise HTTPException(detail="Not found", status_code=404)


@router.post("/check")
async def check_ride_route(request: AcceptRideRequest) -> CustomResponse:
    for ride in rides:
        if ride.ride_id == request.ride_id:
            return CustomResponse(detail="Pending")

    return CustomResponse(detail="Accepted")
