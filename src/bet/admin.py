from django.contrib import admin
from bet.models import FixtureModel
from bet.models import ScoreModel
from bet.models import MatchModel
from bet.models import ResultModel

admin.site.register(FixtureModel)
admin.site.register(ScoreModel)
admin.site.register(MatchModel)
admin.site.register(ResultModel)