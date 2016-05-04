package framework.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;

	public class SoundManager
	{
		private var _soundDictionary:Dictionary;
		private var _currentResourceName:String;
		
		public function SoundManager()
		{
			_soundDictionary = new Dictionary();
		}
		
		public function addSound(resourceName:String, sound:Sound):void
		{
			_soundDictionary[resourceName] = sound;
		}
		
		public function removeSound(resourceName:String):void
		{
			if(_soundDictionary[resourceName])
			{
				delete _soundDictionary[resourceName];
			}
			else
			{
				throw new Error("Invalid sound resource name. Check your sound resource name");
			}
		}
		
		public function play(resourceName:String):void
		{
			var sound:Sound = _soundDictionary[resourceName];
			sound.play();
		}
		
		public function playLooped(resourceName:String):void
		{
			var sound:Sound = _soundDictionary[resourceName];
			var channel:SoundChannel = sound.play();
			channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}
		
		public function stopSound(resourceName:String):void
		{
			
		}
		
		private function onComplete(event:Event):void
		{
			(event.target as SoundChannel).removeEventListener(event.type, onComplete);
//			playLooped(_currentResourceName);
		}
	}
}