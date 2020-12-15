import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:langaw/components/fly.dart';

class LangawGame extends Game {
  // instance variables
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;

  LangawGame() {
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random(); // initalize the random variable
    resize(await Flame.util.initialDimensions());

    spawnFly();
  }

  void spawnFly() {
    // generate a random double between 0 and 1 and multiply the appropiate screen dimension by it
    // subtract the tileSize so the fly doesn't appear halfway off the screen
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    // create a new fly, pass in the current game instance, and a random location
    flies.add(Fly(this, x, y));
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);

    flies.forEach((Fly fly) => fly.render(canvas));
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    // 9 tiles should fit across the screen, the screen is locked into portrait mode so we can rely on this.
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown(); // run onTapDown 
      }
    });
  }
}
