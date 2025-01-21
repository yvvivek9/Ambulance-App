from pydantic import BaseModel, Field
from typing import List, Optional
from bson.objectid import ObjectId

from config.database import get_database

COLLECTION_NAME = "rides"

class Ride(BaseModel):
    id: Optional[str] = Field(None, alias="_id")
    driver_id: str
    hospital_id: str | None
    pickup_x: float
    pickup_y: float
    drop_x: float
    drop_y: float
    cost: float
    payment: str
    date_time: str

    def __init__(self, **data):
        if '_id' in data and isinstance(data['_id'], ObjectId):
            data['_id'] = str(data['_id'])
        super().__init__(**data)


async def insert_ride(ride: Ride):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    value = ride.model_dump(by_alias=True)
    value.pop("_id")
    clc.insert_one(value)


async def find_ride_by_id(uid: str) -> Optional[Ride]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    res = clc.find_one(query)
    if res:
        return Ride(**res)
    return None


async def list_ride() -> List[Ride]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    result = clc.find()
    ret_list = []
    for r in result:
        ret_list.append(Ride(**r))
    return ret_list


async def update_ride(uid: str, ride: Ride):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    value = ride.model_dump(by_alias=True)
    value.pop('_id')
    clc.update_one(query, {"$set": value})


async def delete_ride_byid(uid: str):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    clc.delete_one(query)