from app.webapi import resources


def add_routes(app):
    app.add_route('/alert/ping', resources.monitoring.Ping())
