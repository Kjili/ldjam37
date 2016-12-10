#!/bin/bash

convert player.xcf player.png
convert player.png -colorspace Gray enemy.png
convert enemy.png -fill "#920000" -opaque "#787878" enemy.png

# create intro png's

cp player.png ../game/scenes/intro/player.png
cp enemy.png ../game/scenes/intro/enemy.png
convert intro.xcf ../game/scenes/intro/intro.png
