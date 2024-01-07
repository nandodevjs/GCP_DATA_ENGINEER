from fastapi import FastAPI
from pydantic import BaseModel
import requests


class Params(BaseModel):
    url: str
    bucket_name: str
    output_file_prefix: str


app = FastAPI()

@app.get('/')
async def read_root():
    return("Hello World")

def get_dados(remote_url):
    response = requests.get(remote_url)
    
    return response
