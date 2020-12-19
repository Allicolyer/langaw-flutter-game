import 'dart:ui';
import 'package:langaw/langaw-game.dart';
import 'package:flame/sprite.dart';

class Fly {
  final LangawGame game;
  Rect flyRect;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex =
      0; // This variable is a double because we will increment it using values from the time delta
  bool isDead = false;
  bool isOffScreen = false;

  Fly(this.game);

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(
          c,
          flyRect.inflate(
              2)); // the inflate method creates a copy of the rectangle it was called on but inflated by 2from the center.
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
    }
  }

  void update(double t) {
    // t is the time delta variable which contains the amount of time that passed since the last time update was run. The value is in seconds.

    // Using the formula game.tileSize * 12 * t always gives us movement of 12 game tiles per second.

    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        // detect when the fly has fallen off the screen so that we can remove it from the game.
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
    }
  }

  void onTapDown() {
    isDead = true;
    game.spawnFly();
  }
}
