from swampdragon import route_handler
from swampdragon.route_handler import BaseRouter
from .match_info import broadcast_match_info


class MatchInfoRouter(BaseRouter):
    route_name = 'match'

    def get_subscription_channels(self, **kwargs):
        broadcast_match_info()
        return ['matchinfo']


route_handler.register(MatchInfoRouter)
