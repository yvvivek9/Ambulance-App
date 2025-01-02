from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List

from utils.response import CustomResponse

router = APIRouter()
rides = []


class Ride(BaseModel):
    ride_id: int
    pickup_lat: float
    pickup_lng: float
    drop_lat: float
    drop_lng: float
    hospital: str


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
