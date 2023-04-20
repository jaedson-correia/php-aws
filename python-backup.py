import boto3
import os
import datetime
from dotenv import load_dotenv

load_dotenv()

DB_HOST = os.getenv('DB_HOST')
DB_NAME = os.getenv('DB_NAME')
DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')
DB_PORT = '5432'

AWS_BUCKET = os.getenv('AWS_BUCKET')
AWS_OBJECT_KEY = os.getenv('AWS_OBJECT_KEY')
AWS_DEFAULT_REGION = os.getenv('AWS_DEFAULT_REGION')

backup_filename = 'postgresql-' + datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S") + '.sql'

os.system(f'pg_dump -h {DB_HOST} -U {DB_USER} -F c {DB_NAME} > {backup_filename}')

# upload do arquivo no s3
s3 = boto3.client('s3', region_name=AWS_DEFAULT_REGION)
s3.upload_file(backup_filename, AWS_BUCKET, AWS_OBJECT_KEY)

os.remove(backup_filename)