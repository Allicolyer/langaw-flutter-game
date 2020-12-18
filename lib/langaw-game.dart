import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:langaw/components/backyard.dart';
import 'package:langaw/components/fly.dart';

class LangawGame extends Game {
  // instance variables
  Size screenSize;
  double tileSize;
  Backyard background;
  List<Fly> flies; // holds an array of fly instances
  Random rnd;

  LangawGame() {
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random(); // initalize the random variable
    resize(await Flame.util
        .initialDimensions()); // get the screen dimensions when the game starts up
    spawnFly();
    background = Backyard(
        this); // must be done after the screen size is determined because the constructor uses the screen size and tile size values.
  }

  void spawnFly() {
    // generate a random double between 0 and 1 and multiply the appropiate screen dimension by it
    // subtract the tileSize so the fly doesn't appear halfway off the screen
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    // create a new fly, pass in the current game instance, and a random location
    flies.add(Fly(this, x, y));
  }

  // the render and update loops are part of the game loop, update is run first, then render.
  void render(Canvas canvas) {
    background.render(canvas); // render the background on the canvas
    flies.forEach((Fly fly) => fly.render(
        canvas)); // run the render method on the fly, pass in the canvas
  }

  void update(double t) {
    flies.forEach((Fly fly) =>
        fly.update(t)); // cycle through each fly, pass in the time delta
    flies.removeWhere((Fly fly) =>
        fly.isOffScreen); // remove off screen flies from the fly array
  }

  void resize(Size size) {
    screenSize = size;
    // 9 tiles should fit across the screen, the screen is locked into portrait mode so we can rely on this.
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown(); // run the onTapDown method on the fly
      }
    });
  }
}
