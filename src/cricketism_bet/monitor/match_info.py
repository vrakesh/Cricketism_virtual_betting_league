from tornado.ioloop import PeriodicCallback
from swampdragon.pubsub_providers.data_publisher import publish_data
from bet.models import MatchModel, FixtureModel, ResultModel
from django.utils import timezone


pcb = None

def broadcast_match_info():
    global pcb

    if pcb is None:
        pcb = PeriodicCallback(broadcast_match_info, 500)
        pcb.start()


    matches = MatchModel.objects.all()
    match_status = {}
    for match in matches:
        fixture = FixtureModel.objects.get(id=match.match_id)
        r = ResultModel.objects.get(id=match.match_id)

        dd = fixture.match_day - timezone.now() 
        dd_str = None
        if(timezone.now() > fixture.match_day):
            dd_str = "Locked"
        else: 
            dd_str = "%sd:%sh:%sm:%ss" %(str(dd.days),str((dd.seconds//3600)%24),str((dd.seconds%3600)//60), str((dd.seconds%3600)%60),)
        match_status['time_left'+str(match.match_id)] = dd_str
        if(fixture.match_day > timezone.now()):
            match_status['color'+str(match.match_id)] = 'success'
        else:
            match_status['color'+str(match.match_id)] = 'danger'
        if(r.result != 'None'):
            match_status['color'+str(match.match_id)] = 'info'
        match_status['storedbet'+str(match.id)] = "%s %s" %(match.betting_side, match.betting_points,)
        match_status['odds'+str(match.match_id)] = "%s:%s"  %(fixture.home_odds, fixture.away_odds,)
    publish_data('matchinfo', {
        'match_status': match_status,
    })