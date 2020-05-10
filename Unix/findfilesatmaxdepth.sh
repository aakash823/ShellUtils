#!/bin/bash

awk -F'/+' 'NF>max{max=NF;delete buf} NF==max{buf[$0]} END{for(f in buf) print f}' file