#!/bin/bash

convert player.xcf player.png
convert player.png -colorspace Gray enemy.png
convert enemy.png -fill "#920000" -opaque "#787878" enemy.png
