
import json
from cStringIO import StringIO

from fabric.api import task, local as l, execute


TAPJOY_REPORT_URL = 'https://api.tapjoy.com/reporting_data.json?email=possiblewhale%40gmail.com&api_key=31de3e982af6489ba65f4d34f742d699&date=2013-07-16'
TAPJOY_APP_ID = 'b4ca3528-2369-4384-8817-affd498ed62b'
APP_NAME = 'Just Ads'


@task
def tapjoySessions():
    """
    Use the tapjoy API to tell us how many sessions there have been
    """
    data = json.load(StringIO(_rawTapjoyAnalytics()))
    for app in data['Apps']:
        if app['AppKey'] == TAPJOY_APP_ID:
            print 'Sessions for Just Ads:', app['Sessions']
            break


def _rawTapjoyAnalytics():
    """
    Get all tapjoy reporting data in json format
    """
    return l('curl "%s"' % TAPJOY_REPORT_URL, capture=True)
