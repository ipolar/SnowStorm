# SnowStorm AS3

An AS3 class for creating snow storms!

This is using the SnowFlake class from Seb Lee-Delisle "SNOWSTORM IN 15 MINS" blog post (which I can't seem to find the link for as this was a good 3 years ago)


## Usage

Very simple, import the class;

import com.ipolar.xmas.SnowStorm;


Create a new variable, object and add it to the stage;

private var mySnowStorm:SnowStorm;
mySnowStorm = new SnowStorm(targetSprite);
addChild(mySnowStorm);


Then you can start and stop snow by calling the appropriate method;

mySnowStorm.startSnow();
mySnowStorm.stopSnow();