# GCP ETL Pipeline Project

This project implements an **ETL pipeline** that:

- Cleans and transforms data from a CSV file
- Uploads the cleaned file to a **Google Cloud Storage (GCS)** bucket
- Loads the data into a **BigQuery** table
- Executes analytical queries on the transformed data

Infrastructure is provisioned using **Terraform**.

---

## Repository Structure  
.  
├── **.github/**   
│ └── Terraform workflow (GitHub Actions)  
│
├── **.code/**    
│ ├── csv_cleaning.py / csv_cleaning.ipynb  
│ │   *Python script and notebook to clean and transform the CSV data*   
│ ├── upload_to_gcs.py  
│ │   *Uploads the cleaned CSV file to a GCS bucket*  
│ ├── load_to_bigquery.py  
│ │   *Loads data from the CSV file in GCS into a BigQuery table*  
│ ├── customer_spending_30d_bq.sql  
│ │   *BigQuery subquery for rolling average of customer spending over 30 days*  
│ ├── customer_spending_30d_window.sql  
│ │   *Same as above using a window function*  
│ └── regions_by_avg_spending.sql  
│     *Returns regions sorted by highest average spending*  
│
├── **.documents/**    
│ ├── Architecture_brief.pdf  
│ │   *Solution to Task 1*  
│ └── Task2_ETL.pdf  
│     *Steps for Task 2*  
│
├── **.files/**   
│ ├── CustomerOrders.csv  
│ │   *Original raw data file*  
│ └── cleaned_orders.csv  
│     *Cleaned and transformed data after Python processing*  
│
├── **.terraform/**  
│ └── *Terraform configuration files for infrastructure provisioning*  


---

## Technologies Used

- **Google Cloud Platform** (GCS, BigQuery)
- **Terraform**
- **Python** (`google-cloud-storage`, `google-cloud-bigquery`)
- **SQL** (BigQuery dialect)
- **GitHub Actions**

---

## Tasks Covered

- Data cleaning and transformation using Python
- Cloud storage and retrieval with GCS
- Data warehouse setup and querying with BigQuery
- Infrastructure provisioning with Terraform
- CI/CD automation with GitHub Actions
