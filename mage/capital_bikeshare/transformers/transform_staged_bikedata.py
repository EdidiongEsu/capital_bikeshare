from datetime import datetime

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data['start_date'] = data['start_datetime'].dt.strftime('%Y-%m-%d')
    data['end_date'] = data['end_datetime'].dt.strftime('%Y-%m-%d')

    # create time columns
    data['start_time'] = data['start_datetime'].dt.time
    data['end_time'] = data['end_datetime'].dt.time

    return data