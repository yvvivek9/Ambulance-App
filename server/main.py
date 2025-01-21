from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from dotenv import load_dotenv

from sockets import user_driver
from routes import rides


load_dotenv()

fastAPI = FastAPI()
fastAPI.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# fastAPI.include_router(user_driver.router, prefix="/ws", tags=["ws", "user", "driver"])
fastAPI.include_router(rides.router, prefix="/ride", tags=["rides"])

@fastAPI.get("/")
async def index_route():
    return FileResponse("static/index.html")
fastAPI.mount("/", StaticFiles(directory="static"), name="flutter")
