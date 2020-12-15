import 'dart:ui';
import 'package:langaw/langaw-game.dart';

class Fly {
  final LangawGame game;
  Rect flyRect;
  Paint flyPaint;
  bool isDead = false;
  bool isOffScreen = false;

  Fly(this.game, double x, double y) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    flyPaint = Paint();
    flyPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    c.drawRect(flyRect, flyPaint);
  }

  void update(double t) {
    // t is the time delta variable which contains the amount of time that passed since the last time update was run. The value is in seconds.

    // Using the formula game.tileSize * 12 * t always gives us movement of 12 game tiles per second.

    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        // detect when the fly has fallen off the screen so that we can remove it from the game
        isOffScreen = true;
      }
    }
  }

  void onTapDown() {
    flyPaint.color = Color(0xffff4757); // turn the fly red when it is tapped
    isDead = true;
    game.spawnFly();
  }
}
