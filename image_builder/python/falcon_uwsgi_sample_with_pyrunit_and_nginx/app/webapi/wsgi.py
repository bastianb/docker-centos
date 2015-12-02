#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import argparse

from app.webapi.configuration import configure_application

parser = argparse.ArgumentParser()
parser.add_argument('config')
arguments = parser.parse_args()
application = configure_application(arguments.config)
