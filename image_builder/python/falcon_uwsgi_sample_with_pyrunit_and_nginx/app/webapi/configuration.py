from configparser import ConfigParser
from logging.config import fileConfig

import falcon

from app.webapi.routes import add_routes


def configure_application(config):
    fileConfig(config)
    settings = ConfigParser().read(config)
    app = falcon.API()
    add_routes(app)
    return app
