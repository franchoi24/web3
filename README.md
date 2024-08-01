# web3

# Web3 Exercises

## Exercise 1: Data Ingestion

### Prerequisites

1. **Microsoft C++ Build Tools**:  
   If you are using Windows, download and install the Microsoft C++ Build Tools from [here](https://visualstudio.microsoft.com/visual-cpp-build-tools/). Follow the [setup instructions](https://stackoverflow.com/questions/64261546/how-to-solve-error-microsoft-visual-c-14-0-or-greater-is-required-when-inst).

2. **Install Dependencies**:  
   Run the following command to install required Python packages:
   ```bash
   pip install -r src/excercise1/requirements.txt

### Configuration in `configs.py`

- **`api_key`**: This is the Infura API key. *(Note: It is not a good practice to store sensitive information like this directly in the code. It should be stored securely in secrets management provided by your cloud provider.)*
- **`start_block`**: The starting block number (inclusive).
- **`end_block`**: The ending block number (inclusive).
- **`address`**: The address being filtered.
- **`value`**: The value being filtered.
- **`folder_path`**: The path to the folder where the output will be saved.
- **`file_name`**: The name of the final output file.
- **`filtering`**: This parameter can take one of the following 4 options:
  - `'address_to'`: Filters transactions to the specified address.
  - `'address_from'`: Filters transactions from the specified address.
  - `'value_gt'`: Filters transactions with values greater than the specified amount.
  - `'value_lt'`: Filters transactions with values less than the specified amount.


### Running the Script

To execute the Python script, use the following command:
    ```bash
    python src/excercise1/data_ingestion.py


## Exercise 2: PostgreSQL Setup

### Pull and Run PostgreSQL Docker Container

1. **Pull PostgreSQL Image**:
   ```bash
   docker pull postgres

### Run PostgreSQL Container

Run the following command to start a PostgreSQL container:
    ```bash
    docker run --name my-postgres -e POSTGRES_PASSWORD=<password> -p 5432:5432 -d postgres

This will set up a PostgreSQL database named postgres with the user postgres and the specified <password>, accessible on localhost at port 5432.

### Load Data into PostgreSQL

You can either open your IDE and execute the `insertion.sql` file directly or follow these steps:

1. **Copy SQL File into Container**:
   ```bash
   docker cp ./src/excercise2/insertion.sql my-postgres:/docker-entrypoint-initdb.d/dump.sql

2. **Execute SQL Script:**:
   ```bash
    docker cp ./src/excercise2/insertion.sql my-postgres:/docker-entrypoint-initdb.d/dump.sql
    docker exec -u postgres my-postgres psql -d postgres -f /docker-entrypoint-initdb.d/dump.sql

Then you can execute the query with the same method or with your IDE




