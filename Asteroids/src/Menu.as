package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.events.FocusEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.events.KeyboardEvent;
	import flash.system.fscommand;


	/**
	 * ...
	 * @author Ralph Otte
	 */
	
	 public class Menu extends Sprite
	{
		private var _MenuMusic:Sound; 		// MENU MUSIC(muziek nog in de game zetten)
		private var _GM:GameManager;
		
		private var _MenuSelection:int = 0;
		
		private var _WButtonIsDown:Boolean = false;
		private var _SButtonIsDown:Boolean = false;	
		private var _SpaceButton:Boolean = false;
		
		[Embed(source="../Assets/Menu's/menu_astroids.png")]
		private var _MenuBackground:Class;							  
		public var _MenuBack:Bitmap;
		[Embed(source = "../Assets/Menu's/Pointer.png")]
		private var _SelectionPointer:Class;
		public var _Pointer:Bitmap;
		[Embed(source = "../Assets/Menu's/SinglePlayerButton.png")]
		private var _SinglePlayButton:Class;
		public var _SingleButton:Bitmap;
		[Embed(source = "../Assets/Menu's/MultiplayerButton.png")]
		private var _MultiPlayButton:Class;
		public var _MultiButton:Bitmap;
		[Embed(source = "../Assets/Menu's/OptionsButton.png")]
		private var _OptionsButton:Class;
		public var _Options:Bitmap;
		[Embed(source = "../Assets/Menu's/QuitButton.png")]
		private var _ExitButton:Class;
		public var _Exit:Bitmap;
				
		public function Menu() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		public function reSpawn(e):void
		{
			this.init(e);
			_MenuSelection = 0;
		}
		
		private function init(e:Event):void
		{
			 removeEventListener(Event.ADDED_TO_STAGE, init);
			 addEventListener(Event.ENTER_FRAME, loop);
			 stage.addEventListener(KeyboardEvent.KEY_DOWN, checkButtonDown);
			 stage.addEventListener(KeyboardEvent.KEY_UP, checkButtonUp);
			 
			// _MenuMusic = new Sound(new URLRequest("../Assets/Music/MUZIEK")); //Muziek voor menu COMMENT WEGHALEN ALS DE FILE ER WEL IS
			// _MenuMusic.play(0, 999);
			
			_MenuBack = new _MenuBackground;
			addChild(_MenuBack);
			
			_Pointer = new _SelectionPointer;
			addChild(_Pointer);
			_Pointer.x = stage.stageWidth / 2 - 150;
			_Pointer.y = stage.stageHeight / 2 - 100;
			trace("Added Pointer (MENU)");
			
			_SingleButton = new _SinglePlayButton;
			addChild(_SingleButton);
			_SingleButton.x = stage.stageWidth / 2 - 100;
			_SingleButton.y = stage.stageHeight / 2 - 100;
			
			 _MultiButton = new _MultiPlayButton;
			 addChild(_MultiButton);
			 _MultiButton.x = stage.stageWidth / 2 - 100;
			 _MultiButton.y = stage.stageHeight / 2 - 30;
			
			 _Options = new _OptionsButton;
			 addChild(_Options); 
			 _Options.x = stage.stageWidth / 2 - 100;
			 _Options.y = stage.stageHeight / 2 + 40;
			 
			  _Exit = new _ExitButton;
			 addChild(_Exit);
			 _Exit.x = stage.stageWidth / 2 - 40;
			 _Exit.y = stage.stageHeight / 2 + 110;
	
		}
		
		private function checkButtonUp(e:KeyboardEvent):void
		{
			trace("checkbuttonUp");
			if (e.keyCode == 87)
			{
				_WButtonIsDown = false;
			}
			if (e.keyCode == 83)
			{
				_SButtonIsDown = false;
			}
			if (e.keyCode == 32)
			{
				_SpaceButton = false;
			}
		}
		
		public function checkButtonDown(e:KeyboardEvent):void
		{
			trace("checkbuttonDown");
			if (e.keyCode == 87)
			{
				_WButtonIsDown = true;
			}
			if (e.keyCode == 83)
			{
				_SButtonIsDown = true;
			}
			if (e.keyCode == 32)
			{
				_SpaceButton = true;
			}
		}
		
		public function loop(e:Event):void 
		{
			if (!this.contains(_Pointer))
			{
				trace("Does Menu contain _Pointer? (MENU)");
				addChild(_Pointer);
			}
			// DIT IS DE POINTER DIE VERPLAATST
			 if (_MenuSelection == 1)
			 {
				_Pointer.x = stage.stageWidth / 2 - 150;
				_Pointer.y = stage.stageHeight / 2 - 100;
			 }
			 if (_MenuSelection == 2)
			 {
				_Pointer.x = stage.stageWidth / 2 - 150;
				_Pointer.y = stage.stageHeight / 2 - 30;
			 }
			 if (_MenuSelection == 3)
			 {
				_Pointer.x = stage.stageWidth / 2 - 150;
				_Pointer.y = stage.stageHeight / 2 + 40;
			 }
			 if (_MenuSelection == 4)
			 {
				_Pointer.x = stage.stageWidth / 2 - 150;
				_Pointer.y = stage.stageHeight / 2 + 110;
			 }
			 
			if (_WButtonIsDown == true)
			{
				trace("W");
				trace(_MenuSelection);
				if (_MenuSelection <= 4)
					{
						_MenuSelection--;
					}
				if(_MenuSelection <= 0)
				{
					_MenuSelection = 4;
				}
			}
			
			if (_SButtonIsDown == true)
			{
				trace("S");
				trace(_MenuSelection);
				if (_MenuSelection <= 4)
				{
					_MenuSelection++;
				}
				else if (_MenuSelection >= 4)
				{
					_MenuSelection = 1;
				}			 
			}
		
			if(_SpaceButton == true)
			{
				trace("SPACE");
				if (_MenuSelection == 1)
				{
				//	_OnePlayer = true;
					dispatchEvent(new Event("SpawnShipSelect1"));			// Geeft signaal af voor de Main dat hij ShipSelect moet spawnen
					trace("OneplayerChosen (MENU)");
					removeEventListener(Event.ENTER_FRAME, loop);
					removeChild(_Pointer);
					dispatchEvent(new Event("RemoveMenu"));
				}
				if (_MenuSelection == 2)
				{
				//	_TwoPlayer = true;
					dispatchEvent(new Event("SpawnShipSelect2"));			// Geeft signaal af voor de Main dat hij ShipSelect moet spawnen
					trace("Twoplayerchosen (MENU)");
					removeChild(_Pointer);
					removeEventListener(Event.ENTER_FRAME, loop);
					dispatchEvent(new Event("RemoveMenu"));
				}
				if (_MenuSelection == 3)
				{
					dispatchEvent(new Event("SpawnOptions"));			//Geeft signaal af voor de Main dat hij Options moet spawnen
					trace("Optionschosen (MENU)");
					removeChild(_Pointer);
					removeEventListener(Event.ENTER_FRAME, loop);
					dispatchEvent(new Event("RemoveMenu"));
				}
				if (_MenuSelection == 4)
				{
					fscommand("quit");			//Stops Flashplayer
					System.exit(0);				//Stops Flashplayer
					trace("Exitchosen (MENU)");
					removeChild(_Pointer);
					removeEventListener(Event.ENTER_FRAME, loop);
					dispatchEvent(new Event("RemoveMenu"));
				}
			}
		}
	}
}