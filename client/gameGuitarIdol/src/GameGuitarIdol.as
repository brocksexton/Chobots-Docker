package {
	import com.kavalok.guitarIdol.GameStage;
	import com.kavalok.guitarIdol.SongChooserView;
	import com.kavalok.guitarIdol.data.songs.Songs;
	
	import flash.display.Sprite;

	[SWF(width='640', height='480', backgroundColor='0x006699', framerate='30')]
	public class GameGuitarIdol extends Sprite
	{
		static public const WIDTH:Number = 640;
		static public const HEIGHT:Number = 480;
		private var _gameStage : GameStage;
		private var _songChooser : SongChooserView;
		public function GameGuitarIdol()
		{
			_songChooser = new SongChooserView();
			addChild(_songChooser.content);
			_songChooser.selectEvent.addListener(onSongSelect);
		}
		
		private function onSongSelect(song : String) : void
		{
			removeChild(_songChooser.content);
			var songConfig : XML =  Songs[song];
			
			_gameStage = new GameStage(stage);
			_gameStage.song = songConfig;
			addChild(_gameStage.content);
		}
	}
}
