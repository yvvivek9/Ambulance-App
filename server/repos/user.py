from pydantic import BaseModel, Field
from typing import List, Optional
from bson.objectid import ObjectId

from config.database import get_database

COLLECTION_NAME = "users"

class User(BaseModel):
    id: Optional[str] = Field(None, alias="_id")
    name: str
    mobile: str
    google_id: str

    def __init__(self, **data):
        if '_id' in data and isinstance(data['_id'], ObjectId):
            data['_id'] = str(data['_id'])
        super().__init__(**data)


async def insert_user(user: User):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    value = user.model_dump(by_alias=True)
    value.pop("_id")
    clc.insert_one(value)


async def find_user_by_id(uid: str) -> Optional[User]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    res = clc.find_one(query)
    if res:
        return User(**res)
    return None


async def list_user() -> List[User]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    result = clc.find()
    ret_list = []
    for r in result:
        ret_list.append(User(**r))
    return ret_list


async def update_user(uid: str, user: User):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    value = user.model_dump(by_alias=True)
    value.pop('_id')
    clc.update_one(query, {"$set": value})


async def delete_user_byid(uid: str):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    clc.delete_one(query)