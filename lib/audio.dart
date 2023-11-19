import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame_audio/flame_audio.dart';

class Audio {
  static late final SharedPreferences prefs;

  static double sfxVolume = 1;

  static bool isAudioMuted = false;
  static bool isSoundMuted = false;

  static Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    FlameAudio.bgm.initialize();
    double storedSfx = prefs.getDouble('sfx') ?? 1;

    sfxVolume = storedSfx;
    FlameAudio.bgm.play('bgm.mp3');
  }

  static void muteBG() {
    FlameAudio.bgm.pause();
    isAudioMuted = true;
  }

  static void resume() {
    FlameAudio.bgm.resume();
    isAudioMuted = false;
  }

  static void clickSound() {
    // For shorter reused audio clips, like sound effects
    FlameAudio.play('click.mp3', volume: sfxVolume);
  }

  static void failSound() {
    // For shorter reused audio clips, like sound effects
    FlameAudio.play('fail.mp3', volume: sfxVolume);
  }

  static void muteSfx() {
    sfxVolume = 0;
    prefs.setDouble('sfx', sfxVolume);
    isSoundMuted = true;
  }

  static void unmuteSfx() {
    sfxVolume = 1;
    prefs.setDouble('sfx', sfxVolume);
    isSoundMuted = false;
  }
}
