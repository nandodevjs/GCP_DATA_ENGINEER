from google.cloud import storage
from fastapi import FastAPI, HTTPException
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

app.post("/download_combustivel")
async def download_combustivel(params: Params):
    try:

        data = get_dados(params.url)
        return {"Status": "OK", "Bucket_name": params.bucket_name, "url": params.url}

    except Exception as ex:
        raise HTTPException(status_code=ex.code, detail=f"{ex}")