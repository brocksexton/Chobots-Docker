package com.kavalok.guitarIdol.data.songs
{
	public class Songs
	{
		
		private function imports() : void
		{
			SoundPunkBass; SoundPunkDrums; SoundPunkGuitar1; SoundPunkGuitar2;
			SoundAltRockBass; SoundAltRockDrums; SoundAltRockGuitar1; SoundAltRockGuitar2; SoundAltRockStrings;
			SoundEmoGuitar1;SoundEmoGuitar2;SoundEmoBass;SoundEmoDrums;SoundEmoKeys;
			SoundClockGuitar1;SoundClockGuitar2;SoundClockBass;SoundClockDrums;
			SoundPopRockGuitar1;SoundPopRockGutar2;SoundPopRockDrums;SoundPopRockBass;SoundPopRockBajan;
		}

		public static const TST : XML = <root bpm="100" sounds="altrockgtr1.mp3">
  <item soundDuration="32"/>
</root>;		
		public static const CLOCK : XML = <root bpm="100" sounds="SoundClockGuitar1,SoundClockGuitar2,SoundClockBass,SoundClockDrums">
  <item soundDuration="32"/>
</root>;		
		public static const POP_ROCK : XML = <root bpm="130" sounds="SoundPopRockGuitar1,SoundPopRockGutar2,SoundPopRockDrums,SoundPopRockBass,SoundPopRockBajan">
  <item soundDuration="32"/>
</root>;		
		public static const EMO : XML = <root bpm="100" sounds="SoundEmoGuitar1,SoundEmoGuitar2,SoundEmoBass,SoundEmoDrums,SoundEmoKeys">
  <item soundDuration="32"/>
</root>;		
		public static const ALT_ROCK : XML = <root bpm="80" sounds="SoundAltRockGuitar1,SoundAltRockBass,SoundAltRockDrums,SoundAltRockGuitar2,SoundAltRockStrings">
  <item soundDuration="32"/>
  <item button="a,d" soundDuration="4" long="true"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,d" soundDuration="4" long="true"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,d" soundDuration="4" long="true"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,d" soundDuration="4" long="true"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="2"/>
  <item button="d" soundDuration="2"/>

</root>;
		public static const ALT_ROCK2 : XML = <root bpm="80" sounds="SoundAltRockGuitar2,SoundAltRockGuitar1,SoundAltRockBass,SoundAltRockDrums,SoundAltRockStrings">
  <item soundDuration="32"/>
  <item button="a,d" soundDuration="3" longNote="true"/>
  <item soundDuration="1"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="a,d" soundDuration="3" longNote="true"/>
  <item soundDuration="1"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="a,d" soundDuration="3" longNote="true"/>
  <item soundDuration="1"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="a,d" soundDuration="3" longNote="true"/>
  <item soundDuration="1"/>
  <item button="f" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="2"/>
  <item button="a" soundDuration="2"/>

  <item button="a,d" soundDuration="3" longNote="true"/>
  <item soundDuration="1"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="a,d" soundDuration="3" longNote="true"/>
  <item soundDuration="1"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="a,d" soundDuration="3" longNote="true"/>
  <item soundDuration="1"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="a,d" soundDuration="3" longNote="true"/>
  <item soundDuration="1"/>
  <item button="f" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>

  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="f" soundDuration="3"/>
  <item button="d" soundDuration="9"/>

  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="d" soundDuration="4"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>

  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="f" soundDuration="3"/>
  <item button="d" soundDuration="9"/>

  <item button="a,s" soundDuration="4"/>
  <item button="f" soundDuration="3"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="d" soundDuration="3"/>

  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="3"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="d" soundDuration="3"/>

  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="3"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="d" soundDuration="3"/>

  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="3"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="d" soundDuration="3"/>

  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="3"/>
  <item button="d" soundDuration="6" longNote="true"/>
  <item soundDuration="3"/>

  <item button="f" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="s" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="s" soundDuration="2"/>

  <item button="s" soundDuration="2" longNote="true"/>
  <item soundDuration="1"/>
  <item button="d" soundDuration="6" longNote="true"/>
  <item soundDuration="1"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="4"/>
  <item button="a" soundDuration="2" longNote="true"/>
  <item soundDuration="1"/>
  <item button="s" soundDuration="6" longNote="true"/>
  <item soundDuration="1"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="2" longNote="true"/>
  <item soundDuration="1"/>
  <item button="d" soundDuration="6" longNote="true"/>
  <item soundDuration="1"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="4"/>
  <item button="a" soundDuration="3" longNote="true"/>
  <item button="s" soundDuration="7" longNote="true"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="3" longNote="true"/>
  <item soundDuration="15"/>

  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="s" soundDuration="7" longNote="true"/>
  <item soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="d" soundDuration="7" longNote="true"/>
  <item soundDuration="2"/>

</root>;
		public static const PUNK2 : XML = <root bpm="200" sounds="SoundPunkGuitar2,SoundPunkGuitar1,SoundPunkBass,SoundPunkDrums">
	<item soundDuration="44"/> 
	<item button="a,s,d" soundDuration="4"/> 
	<item button="a,s,d" soundDuration="4"/> 
	<item button="a,s,d" soundDuration="4"/> 
	<item button="a,s,d" soundDuration="4"/> 
	<item soundDuration="32"/> 
	<item button="a,s,d" soundDuration="32"/> 	
	<item button="a,s,d" soundDuration="2"/> 
	<item button="a,s,d" soundDuration="2"/> 
	<item button="a,s,d" soundDuration="2"/> 
	<item button="a,s,d" soundDuration="26"/> 
	<item button="a,s,d" soundDuration="2"/> 
	<item button="a,s,d" soundDuration="2"/> 
	<item button="a,s,d" soundDuration="2"/> 
	<item button="a,s,d" soundDuration="26"/> 
	<item button="d,f" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="d,f" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="d,f" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 	
	<item button="d,f" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="26"/>
	<item button="s" soundDuration="6"/>
	<item button="s" soundDuration="8"/>
	<item button="d" soundDuration="8"/>
	<item button="s" soundDuration="16"/>
	<item button="s" soundDuration="8"/>
	<item button="d" soundDuration="8"/>
	<item button="s" soundDuration="16"/>
	<item button="s" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="f" soundDuration="8"/>
	
	<item button="f" soundDuration="8"/>
	<item button="f" soundDuration="2"/>
	<item button="f" soundDuration="2"/>
	<item button="d" soundDuration="2"/>
	<item button="d" soundDuration="2"/>
	<item button="s" soundDuration="8"/>
	<item button="d" soundDuration="2"/>
	<item button="d" soundDuration="2"/>
	<item button="s" soundDuration="2"/>
	<item button="s" soundDuration="2"/>
	<item button="a" soundDuration="8"/>
	<item button="d" soundDuration="2"/>
	<item button="d" soundDuration="2"/>
	<item button="s" soundDuration="2"/>
	<item button="s" soundDuration="2"/>
	<item button="a" soundDuration="8"/>
	<item button="d" soundDuration="2"/>
	<item button="s" soundDuration="8"/>
	<item button="s" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="f" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="f" soundDuration="2"/>
	<item button="f" soundDuration="2"/>
	<item button="f" soundDuration="2"/>
	<item button="f" soundDuration="2"/>
	<item button="f" soundDuration="2"/>
	<item button="f" soundDuration="2"/>
	<item button="f" soundDuration="2"/>
	<item button="f" soundDuration="2"/>

	<item button="a" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="d" soundDuration="8"/> 	
	<item button="a" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="d" soundDuration="8"/> 	
	<item button="a" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="d" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="d" soundDuration="8"/> 

	<item button="d,f" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="d,f" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="d,f" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="a" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 	
	<item button="d,f" soundDuration="8"/> 
	<item button="s" soundDuration="8"/> 
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>

	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="f" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="a" soundDuration="4"/>

	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="f" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="a" soundDuration="4"/>

	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="f" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="a" soundDuration="4"/>

	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="a" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="f" soundDuration="4"/>
	<item button="d" soundDuration="4"/>
	<item button="s" soundDuration="4"/>
	<item button="a" soundDuration="4"/>


</root>;
		
		public static const PUNK : XML = <root bpm="200" sounds="SoundPunkGuitar1,SoundPunkBass,SoundPunkDrums,SoundPunkGuitar2">
  <item soundDuration="30"/>
  <item button="a" soundDuration="2"/>
  <item button="a,s,d" soundDuration="4"/>
  <item button="a,s,d" soundDuration="4"/>
  <item button="a,s,d" soundDuration="4"/>
  <item button="a,s,d" soundDuration="4"/>
  <item button="a,s,d" soundDuration="4"/>
  <item button="a,s,d" soundDuration="4"/>
  <item button="a,s,d" soundDuration="4"/>
  <item button="a,s,d" soundDuration="4"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="f" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a,s" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="s,d" soundDuration="8"/>
  <item button="s,d" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="s,d" soundDuration="8"/>
  <item button="s,d" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="f" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="d" soundDuration="2"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,d" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="a,s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="d,f" soundDuration="8"/>
  <item button="s" soundDuration="8"/>

  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="4"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="f" soundDuration="8"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="f" soundDuration="8"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
  <item button="f" soundDuration="8"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="a" soundDuration="2"/>
  <item button="s" soundDuration="4"/>
  <item button="d" soundDuration="4"/>
  <item button="s" soundDuration="4"/>
  <item button="a" soundDuration="8"/>
  <item button="s" soundDuration="8"/>
  <item button="a" soundDuration="8"/>
</root>;
	}
}