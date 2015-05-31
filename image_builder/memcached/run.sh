#!/bin/bash

memcached -u root -l 0.0.0.0 -m 64 -c 1024
