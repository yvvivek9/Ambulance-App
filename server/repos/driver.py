from pydantic import BaseModel, Field
from typing import List, Optional
from bson.objectid import ObjectId

from config.database import get_database

COLLECTION_NAME = "drivers"

class Driver(BaseModel):
    id: Optional[str] = Field(None, alias="_id")
    name: str
    mobile: str
    google_id: str
    vehicle_id: str
    vehicle_type: str

    def __init__(self, **data):
        if '_id' in data and isinstance(data['_id'], ObjectId):
            data['_id'] = str(data['_id'])
        super().__init__(**data)


async def insert_driver(driver: Driver):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    value = driver.model_dump(by_alias=True)
    value.pop("_id")
    clc.insert_one(value)


async def find_driver_by_id(uid: str) -> Optional[Driver]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    res = clc.find_one(query)
    if res:
        return Driver(**res)
    return None


async def list_driver() -> List[Driver]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    result = clc.find()
    ret_list = []
    for r in result:
        ret_list.append(Driver(**r))
    return ret_list


async def update_driver(uid: str, driver: Driver):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    value = driver.model_dump(by_alias=True)
    value.pop('_id')
    clc.update_one(query, {"$set": value})


async def delete_driver_byid(uid: str):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    clc.delete_one(query)