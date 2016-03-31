from django.http import HttpResponse
from django.template.loader import get_template
from django.template import Context
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from bet.models import FixtureModel
from bet.models import MatchModel
from bet.models import ResultModel
from bet.models import ScoreModel
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.core.context_processors import csrf
import sys
@login_required(login_url='/accounts/login')
def bet(request):
    t = get_template('bet.html')
    matches_list = MatchModel.objects.filter(user_name=request.user)
    if len(matches_list) == 0:
        fix = FixtureModel.objects.all()
        matches = []
        for fixture in fix:
            match = MatchModel(betting_side=fixture.home_side, user_name=request.user,match_id=fixture.id)
            matches.append(match)
        MatchModel.objects.bulk_create(matches)
    scores_list = ScoreModel.objects.filter(user_name=request.user)
    if len(scores_list) == 0:
        score = ScoreModel(user_name=request.user)
        score.save()
    #matches = FixtureModel.objects.all()
    user_specific = MatchModel.objects.filter(user_name=request.user)
    match_info = []
    match = {}
    for u in user_specific:
        matches = FixtureModel.objects.filter(id=u.match_id)
        r = ResultModel.objects.filter(id=u.match_id)
        match['result'] = r[0].result
        match['bet'] = u.betting_side
        match['betp'] = u.betting_points
        match['user'] = u.user_name
        match['id'] = u.match_id
        match['home'] = matches[0].home_side
        match['away'] = matches[0].away_side
        match['day'] = matches[0].match_day
        match['home_odds'] = matches[0].home_odds
        match['away_odds'] = matches[0].away_odds
        if(match['day'] > timezone.now()):
            match['color'] = 'success'
        else:
            match['color'] = 'danger'
        if(match['result'] != 'None'):
            match['color'] = 'info'
        match_info.append(match.copy())
    #print match_info
    cdict = {'user': request.user.username, 'dt' : datetime.now(), 'matches': match_info,}
    cdict.update(csrf(request))
    c = Context(cdict)
    response = t.render(c)
    return HttpResponse(response)

def update(request):
     posted = request.POST
     user_name = request.user
     data = dict(posted.iterlists())
     user_matches = MatchModel.objects.filter(user_name=user_name)
     fixtures = FixtureModel.objects.all()
     fifty_counter = 0
     match_array = []
     fix = []
     for match in user_matches:
         match_array.append(match)
     for fixture in fixtures:
         fix.append(fixture)
     for i in range(1,62):
         if(str(i) in data):
            betting_side = data[str(i)][0].split('-')[0]
            betting_points = int(data[str(i)][0].split('-')[1])
            if(betting_points == 50):
                user_matches[i-1].bet_50=1
            bet_flag = user_matches[i-1].bet_flag
            home_odds = fixtures[i-1].home_odds
            away_odds = fixtures[i-1].away_odds
            home_side = fixtures[i-1].home_side
            away_side = fixtures[i-1].away_side
            old_points = user_matches[i-1].betting_points
            if(bet_flag == 1 and betting_side == away_side):
                home_odds -= user_matches[i-1].betting_points
            if(bet_flag == 2 and betting_side == home_side):
                away_odds -= user_matches[i-1].betting_points
            user_matches[i-1].betting_side = betting_side
            user_matches[i-1].betting_points = betting_points
            if(home_side == betting_side and bet_flag ==1 and old_points != betting_points ):
                home_odds += (betting_points - old_points)
                fixtures[i-1].home_odds = home_odds
                fixtures[i-1].away_odds = away_odds
                user_matches[i-1].bet_flag = 1
            elif(home_side == betting_side and bet_flag != 1):
                home_odds += betting_points
                fixtures[i-1].home_odds = home_odds
                fixtures[i-1].away_odds = away_odds
                user_matches[i-1].bet_flag = 1
            elif(away_side == betting_side and bet_flag == 2 and old_points != betting_points):
                away_odds += (betting_points - old_points)
                fixtures[i-1].away_odds = away_odds
                fixtures[i-1].home_odds = home_odds
                user_matches[i-1].bet_flag = 2
            elif(away_side == betting_side and bet_flag!=2):
                away_odds += betting_points
                fixtures[i-1].away_odds = away_odds
                fixtures[i-1].home_odds = home_odds
                user_matches[i-1].bet_flag = 2
     for matches in user_matches:
         if(matches.bet_50 == 1):
             fifty_counter +=1
     if (fifty_counter > 5):
        return HttpResponse("Error you have bid 50 more than 5 times")
     for matches in user_matches:
        matches.save()
     for fixture in fixtures:
         fixture.save()
     return HttpResponse('Saved')

def score_update(request):
    posted = request.POST
    #user_name = request.user
    data = dict(posted.iterlists())
    details = data['match'][0].split('-')
    name = details[0]
    match_id = int(details[1])
    fixture = FixtureModel.objects.get(id=match_id)
    results = ResultModel.objects.get(id=match_id)
    matches  =   MatchModel.objects.filter(match_id=match_id)
    mc = []
    home_odds = fixture.home_odds
    if(home_odds == 0):
      home_odds += 1
    away_odds = fixture.away_odds
    if(away_odds == 0):
        away_odds +=1
    home_side = fixture.home_side
    away_side = fixture.away_side
    win = 1
    loss =2
    win_odds = home_odds
    loss_odds = away_odds
    if(name == away_side):
        win = 2
        loss = 1
        win_odds = away_odds
        loss_odds = home_odds

    for match in matches:
        mc.append(match)
    for match in matches:
        user_name = match.user_name
        betting_points = match.betting_points
        bet = match.bet_flag
        if(win == bet):
            total_points = float(betting_points) * (float(loss_odds)/float(win_odds))
        elif(loss == bet):
            total_points = float(0-betting_points)
        elif(bet == 0):
            total_points = float(-10)
        score = ScoreModel.objects.get(user_name=user_name)
        cur_points = score.total_score
        cur_points += total_points
        score.total_score = cur_points
        score.save()
        results.result = name
        results.save()

    return HttpResponse("Updated")


# Create your views here.
