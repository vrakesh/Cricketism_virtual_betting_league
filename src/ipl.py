from django.utils import timezone
from datetime import datetime, timedelta
from bet.models import FixtureModel
from bet.models import ResultModel
import csv
import sys
f = open('ipl-2016.csv','r')
reader = csv.reader(f)
home_side = ''
away_side = ''
str1 = ''
str2 = ''
datestr = ''
sys.stderr = open('output','w')
for row in reader:
    home_side = row[0].split('Vs')[0].strip()
    away_side = row[0].split('Vs')[1].strip()
    str1 = row[1].strip()
    str2 = row[2].strip()
    datestr = "%s, %s" %(str1, str2)
    datef = datetime.strptime(datestr,"%d/%m/%Y, %H:%M")
    datef = datef - timedelta(minutes=30)
    datef = timezone.make_aware(datef, timezone.get_current_timezone())
    fix = FixtureModel(home_side=home_side, away_side=away_side, match_day=datef)
    fix.save()
for i in range(1,61):
    re = ResultModel(match_id=i, result="None")
    re.save()