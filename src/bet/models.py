from django.db import models

class FixtureModel(models.Model):
    home_side = models.CharField(max_length=30)
    away_side = models.CharField(max_length=30)
    match_day = models.DateTimeField()
    home_odds = models.IntegerField(default=0)
    away_odds = models.IntegerField(default=0)
    home_points = models.IntegerField(default=0)
    away_points = models.IntegerField(default=0)

    def __str__(self):
        return str(self.id)

class MatchModel(models.Model):
    betting_side = models.CharField(max_length=30)
    betting_points = models.IntegerField(default=0)
    user_name = models.CharField(max_length=20)
    match_id = models.IntegerField(default=0)
    bet_flag = models.IntegerField(default=0)
    bet_50 = models.IntegerField(default=0)
    def __str__(self):
        return str(self.user_name)

class ScoreModel(models.Model):
    user_name = models.CharField(max_length=20)
    total_score = models.FloatField(default=0.0)

class ResultModel(models.Model):
    match_id = models.IntegerField()
    result = models.CharField(max_length=20)
# Create your models here.
