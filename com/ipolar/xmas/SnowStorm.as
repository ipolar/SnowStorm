// SnowStorm
// Author : Andy Lyon
// Date : 06/12/2008
//
// This work is licensed under a Creative Commons  2.0 License.
//
// Full details at
// http://creativecommons.org/licenses/by/2.0/uk/

package com.ipolar.xmas
{
	import flash.display.Sprite;
	import com.ipolar.xmas.SnowFlake;
	import flash.geom.Rectangle;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class SnowStorm extends Sprite
	{
		// Timers
		private var deathTimer:Timer;
		private var displayTimer:Timer;
		
		// Snow bits
		private var snowFlakes:Array = new Array();
		private var numFlakes:uint = 100;
		private var screenArea:Rectangle = new Rectangle(0, 0, 365, 256);
		private var snowMask:Sprite;
		private var snowSprite:Sprite;
		private var allowedSnow:Boolean = true;
		private var wind:Number = ((screenArea.width/2) - 100);
		private var test:Boolean = false;
		private var snowflake:SnowFlake;
		
		public function SnowStorm(targetSprite:Sprite)
		{
			// Create container and add to the main 'target' content sprite
			snowSprite = new Sprite();
			snowSprite.x = 9;
			snowSprite.y = 9;
			targetSprite.addChild(snowSprite);
			
			// Set up my "enterframe" timer
			displayTimer = new Timer(10);
			displayTimer.addEventListener(TimerEvent.TIMER, frameLoop);
			
			// Set up my timer to stop the "enterframe" timer. Was having problems stopping once my array was cleared, so resorted to this.
			// Estimate the number of secs its going to take from when the user fires "stopSnow()" and the snow disappears off screen.
			deathTimer = new Timer(16000);
		}
		
		public function startSnow():void
		{
			// Start my snow storm! This starts my timers, and stops the deathTimer if we've already clicked on the "stopSnow" button.
			allowedSnow = true;
			deathTimer.stop();
			displayTimer.start();
		}
		
		public function stopSnow():void
		{
			// Stop my snow storm! This will start the death timer and also keep updating the current snow, as since we've set our
			// "allowedSnow" var to false, no more snow is added. So we need to keep current snow moving. 
			// Hopefully they'll move off the screen before the "deathTimer" fires.
			// As that'll stop my "displayTimer" and if there's snow on screen at this point, it'll just freeze in place!
			allowedSnow = false;
			
			deathTimer.start();
			deathTimer.addEventListener(TimerEvent.TIMER, killTimers);
			
			for(var j:uint = 0; j < snowFlakes.length; j++) {
				snowflake = snowFlakes[j];
				snowflake.update(wind);
			}
		}
		
		private function killTimers(e:TimerEvent):void
		{
			deathTimer.stop();
			displayTimer.stop();
			
			trace("Timers stopped!!");
		}
		
		private function frameLoop(e:TimerEvent):void
		{
			trace("num: "+snowFlakes.length);
			
			if(allowedSnow) {
				if(snowFlakes.length < numFlakes) {
					
					// Then make a new one!
					snowflake = new SnowFlake(screenArea);
					
					// Add it to the array of snowflakes
					snowFlakes.push(snowflake); 
					
					// And add it to the stage
					snowSprite.addChild(snowflake);
					
					trace("added!");
				}
			}
			
			// And divide by 60 to make it smaller
			wind /=60;
			
			// Now loop through every snowflake
			for(var i:uint = 0; i < snowFlakes.length; i++) {
				snowflake = snowFlakes[i];
				test = snowflake.update(wind);
				if(test) {
					snowFlakes.splice(snowFlakes.indexOf(snowflake),1);
				}
			}
		}
	}
}