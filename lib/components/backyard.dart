import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:langaw/langaw-game.dart';

class Backyard {
  final LangawGame game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game) {
    bgSprite = Sprite('bg/backyard.png');
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height -
          (game.tileSize *
              23), //With this calculation, the background image will always be anchored to the bottom of the screen.
      game.tileSize * 9,
      game.tileSize * 23,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(
        c, bgRect); // renderRect method from the Flame Sprite class
  }

  void update(double t) {}
}
