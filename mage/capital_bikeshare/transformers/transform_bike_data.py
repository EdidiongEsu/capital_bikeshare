if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    data.rename(columns={'rideable_type':'bike_type', 
                        'started_at':'start_datetime',
                        'ended_at':'end_datetime',
                        'member_casual':'membership_type'}, inplace=True)


    return data
