import falcon


class Ping:

    def on_get(self, request, response):
        response.body = 'pong'
        response.status = falcon.HTTP_200
