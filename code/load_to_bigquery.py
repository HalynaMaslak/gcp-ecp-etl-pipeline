from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

table_id = "ecp-tech-assessment.ecp_data.orders"

job_config = bigquery.LoadJobConfig(
    schema=[
        bigquery.SchemaField("OrderID", "STRING", "REQUIRED"),
        bigquery.SchemaField("CustomerID", "STRING", "REQUIRED"),
        bigquery.SchemaField("OrderRegion", "STRING", "REQUIRED"),
        bigquery.SchemaField("OrderDate", "DATE", "REQUIRED"),
        bigquery.SchemaField("OrderAmount", "FLOAT", "REQUIRED"),
        bigquery.SchemaField("ProductID", "STRING", "REQUIRED"),
        bigquery.SchemaField("Quantity", "INTEGER", "REQUIRED"),
        bigquery.SchemaField("TotalOrderValue", "FLOAT", "REQUIRED")
    ],
    skip_leading_rows=1,
    time_partitioning=bigquery.TimePartitioning(
        type_=bigquery.TimePartitioningType.DAY,
        field="OrderDate", 
        expiration_ms=7776000000,  # 90 days.
    ),
)
uri = "gs://ecp-tech-assessment-bucket/files/cleaned_orders.csv" 

load_job = client.load_table_from_uri(
    uri, table_id, job_config=job_config
)  # Make an API request.

load_job.result()  # Wait for the job to complete.

table = client.get_table(table_id)
print("Loaded {} rows to table {}".format(table.num_rows, table_id))
