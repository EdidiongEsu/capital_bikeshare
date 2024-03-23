import io
import pandas as pd
import requests
import zipfile
from io import BytesIO
import pyarrow as pa
import pyarrow.parquet as pq

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

years = [2021, 2022, 2023]

@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    
    bike_fields = [
        ('ride_id', pa.string()), 
        ('rideable_type', pa.string()), 
        ('start_station_name', pa.string()), 
        ('start_station_id', pa.string()), 
        ('end_station_name', pa.string()),
        ('end_station_id', pa.string()), 
        ('start_lat', pa.float64()), 
        ('start_lng', pa.float64()), 
        ('end_lat', pa.float64()), 
        ('end_lng', pa.float64()),
        ('member_casual', pa.string()),
        ('started_at', pa.timestamp('us', tz='America/New_York')),
        ('ended_at', pa.timestamp('us', tz='America/New_York'))
    ]

    bike_schema = pa.schema(bike_fields)

    # Create empty list to store PyArrow tables
    dataframes = []

    for year in years:
        for i in range(12):

            # sets the month part of the file_name string
            month = '0'+str(i+1)
            month = month[-2:]

            init_url = "https://s3.amazonaws.com/capitalbikeshare-data"
            file_prefix = f"{year}{month}-capitalbikeshare-tripdata"

            ## file for bike trip
            file_to_read = f"{file_prefix}.csv"

            # download it using requests via a pandas df
            request_url = f"{init_url}/{file_prefix}.zip"

            # Download the zip file from the URL
            response = requests.get(request_url)

            # Check if the request was successful
            if response.status_code == 200:
                # Read the content of the zip file
                zip_content = BytesIO(response.content)

                # Open the zip file
                with zipfile.ZipFile(zip_content, 'r') as zip_ref:
                    # Get the list of file names in the zip archive
                    file_list = zip_ref.namelist()

                    # Filter out any unwanted files (e.g., macOS metadata)
                    file_list = [file for file in file_list if not file.startswith('__MACOSX/')]


                    if file_to_read not in file_list:
                        # If not found, check for file with "captial" in the name
                        file_to_read = f"{year}{month}-captialbikeshare-tripdata.csv"

                        print(f"The file {file_to_read} has captial in name")

                    if file_to_read in file_list:

                        # Read the CSV file into a DataFrame
                        with zip_ref.open(file_to_read) as file:
                            df = pd.read_csv(file, parse_dates=['started_at', 'ended_at'], dtype={'start_station_id': str, 'end_station_id': str})

                            table = pa.Table.from_pandas(df, schema=bike_schema)
                            dataframes.append(table.to_pandas())

                        print(f"The file {file_to_read} has been downloaded")

                    else:
                        print(f"The file {file_to_read} does not exist in the zip archive.")
                        
            else:
                print("Failed to download the zip file.")

    
    # Concatenate DataFrames
    return pd.concat(dataframes, ignore_index=True)

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
