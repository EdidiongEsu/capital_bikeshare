import io
import pandas as pd
import requests
import zipfile
from io import BytesIO

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    url = 'https://s3.amazonaws.com/capitalbikeshare-data/202101-capitalbikeshare-tripdata.zip'
    
    bike_dtypes = {
    'ride_id': str, 
    'rideable_type': str, 
    'start_station_name': str, 
    'start_station_id': pd.Int64Dtype(), 
    'end_station_name': str,
    'end_station_id': pd.Int64Dtype(), 
    'start_lat': float, 
    'start_lng': float, 
    'end_lat': float, 
    'end_lng': float,
    'member_casual': str
    }

    parse_dates = ['started_at', 'ended_at']

    
    # Name of the file to read from the zip
    file_to_read = '202101-capitalbikeshare-tripdata.csv'

    # Download the zip file from the URL
    response = requests.get(url)

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

            # Check if the file you want to read is present in the filtered list
            if file_to_read in file_list:
                # Read the CSV file into a pandas DataFrame
                with zip_ref.open(file_to_read) as file:
                    df = pd.read_csv(file, dtype = bike_dtypes, parse_dates= parse_dates)
                # Now you can work with the DataFrame (df)
            else:
                print(f"The file {file_to_read} does not exist in the zip archive.")
    else:
        print("Failed to download the zip file.")   

    return df

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
