import json
import os
from google.cloud import storage

def load_variables(json_path='variables.json'):
    with open(json_path, 'r') as f:
        variables = json.load(f)

    json_dir = os.path.dirname(os.path.abspath(json_path))
    source_path = os.path.join(json_dir, variables["source_file_path"])
    variables["source_file_path"] = os.path.abspath(source_path)

    return variables

def upload_to_gcs(bucket_name, source_file_path, destination_blob_name):
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_filename(source_file_path)
    print(f"Uploaded {source_file_path} to gs://{bucket_name}/{destination_blob_name}")

if __name__ == "__main__":
    vars = load_variables()

    upload_to_gcs(
        bucket_name=vars["bucket_name"],
        source_file_path=vars["source_file_path"],
        destination_blob_name=vars["destination_blob_name"]
    )
