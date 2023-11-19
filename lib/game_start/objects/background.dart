import 'package:flame/components.dart';
import 'package:space_road/my_game.dart';
import 'package:space_road/ui/assets.dart';

class Background extends SpriteComponent {
  Background() : super(sprite: Assets.background);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = screenSize;
  }
}
