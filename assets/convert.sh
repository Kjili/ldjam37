#!/bin/bash

convert player.xcf player.png
convert player.png -colorspace Gray enemy.png
convert enemy.png -fill "#920000" -opaque "#787878" enemy.png

# create intro png's

cp player.png ../game/scenes/intro/player.png
cp enemy.png ../game/scenes/intro/enemy.png
convert intro.xcf ../game/scenes/intro/intro.png

# create battleground
convert -layers flatten battleground.xcf ../game/scenes/battleground/battleground.png

# create hero and enemy animations
for f in animation/*
do
	convert $f ../game/scenes/hero/$(basename ${f%.xcf}).png
	convert $f -colorspace Gray ../game/scenes/enemy/$(basename ${f%.xcf}).png
	convert ../game/scenes/enemy/$(basename ${f%.xcf}).png -fill "#920000" -opaque "#787878" ../game/scenes/enemy/$(basename ${f%.xcf}).png
done
