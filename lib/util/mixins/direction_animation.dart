import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/util/direction.dart';
import 'package:bonfire/util/direction_animations/simple_animation_enum.dart';
import 'package:bonfire/util/direction_animations/simple_direction_animation.dart';
import 'package:bonfire/util/mixins/movement.dart';

/// Mixin responsible for adding animations to movements
mixin DirectionAnimation on Movement {
  SimpleDirectionAnimation? animation;

  @override
  void render(Canvas canvas) {
    if (isVisibleInCamera()) {
      animation?.render(canvas);
    }
    super.render(canvas);
  }

  @override
  void update(double dt) {
    if (isVisibleInCamera()) {
      animation?.opacity = opacity;
      animation?.update(dt, position);
    }
    super.update(dt);
  }

  @override
  void moveUp(double speed, {VoidCallback? onCollision}) {
    if (animation?.runUp != null) {
      animation?.play(SimpleAnimationEnum.runUp);
    } else {
      if (lastDirectionHorizontal == Direction.left) {
        animation?.play(SimpleAnimationEnum.runLeft);
      } else {
        animation?.play(SimpleAnimationEnum.runRight);
      }
    }
    super.moveUp(speed, onCollision: onCollision);
  }

  @override
  void moveRight(double speed, {VoidCallback? onCollision}) {
    animation?.play(SimpleAnimationEnum.runRight);
    super.moveRight(speed, onCollision: onCollision);
  }

  @override
  void moveDown(double speed, {VoidCallback? onCollision}) {
    if (animation?.runDown != null) {
      animation?.play(SimpleAnimationEnum.runDown);
    } else {
      if (lastDirectionHorizontal == Direction.left) {
        animation?.play(SimpleAnimationEnum.runLeft);
      } else {
        animation?.play(SimpleAnimationEnum.runRight);
      }
    }

    super.moveDown(speed, onCollision: onCollision);
  }

  @override
  void moveLeft(double speed, {VoidCallback? onCollision}) {
    animation?.play(SimpleAnimationEnum.runLeft);
    super.moveLeft(speed, onCollision: onCollision);
  }

  @override
  void moveUpLeft(double speedX, double speedY, {VoidCallback? onCollision}) {
    if (animation?.runUpLeft != null) {
      animation?.play(SimpleAnimationEnum.runUpLeft);
    } else {
      animation?.play(SimpleAnimationEnum.runLeft);
    }
    super.moveUpLeft(speedX, speedY, onCollision: onCollision);
  }

  @override
  void moveUpRight(double speedX, double speedY, {VoidCallback? onCollision}) {
    if (animation?.runUpRight != null) {
      animation?.play(SimpleAnimationEnum.runUpRight);
    } else {
      animation?.play(SimpleAnimationEnum.runRight);
    }
    super.moveUpRight(speedX, speedY, onCollision: onCollision);
  }

  @override
  void moveDownRight(double speedX, double speedY,
      {VoidCallback? onCollision}) {
    if (animation?.runDownRight != null) {
      animation?.play(SimpleAnimationEnum.runDownRight);
    } else {
      animation?.play(SimpleAnimationEnum.runRight);
    }
    super.moveDownRight(speedX, speedY, onCollision: onCollision);
  }

  @override
  void moveDownLeft(double speedX, double speedY, {VoidCallback? onCollision}) {
    if (animation?.runDownLeft != null) {
      animation?.play(SimpleAnimationEnum.runDownLeft);
    } else {
      animation?.play(SimpleAnimationEnum.runLeft);
    }
    super.moveDownLeft(speedX, speedY, onCollision: onCollision);
  }

  @override
  void idle() {
    switch (lastDirection) {
      case Direction.left:
        animation?.play(SimpleAnimationEnum.idleLeft);
        break;
      case Direction.right:
        animation?.play(SimpleAnimationEnum.idleRight);
        break;
      case Direction.up:
        if (animation?.idleUp != null) {
          animation?.play(SimpleAnimationEnum.idleUp);
        } else {
          if (lastDirectionHorizontal == Direction.left) {
            animation?.play(SimpleAnimationEnum.idleLeft);
          } else {
            animation?.play(SimpleAnimationEnum.idleRight);
          }
        }
        break;
      case Direction.down:
        if (animation?.idleDown != null) {
          animation?.play(SimpleAnimationEnum.idleDown);
        } else {
          if (lastDirectionHorizontal == Direction.left) {
            animation?.play(SimpleAnimationEnum.idleLeft);
          } else {
            animation?.play(SimpleAnimationEnum.idleRight);
          }
        }
        break;
      case Direction.upLeft:
        if (animation?.idleUpLeft != null) {
          animation?.play(SimpleAnimationEnum.idleTopLeft);
        } else {
          animation?.play(SimpleAnimationEnum.idleLeft);
        }
        break;
      case Direction.upRight:
        if (animation?.idleUpRight != null) {
          animation?.play(SimpleAnimationEnum.idleTopRight);
        } else {
          animation?.play(SimpleAnimationEnum.idleRight);
        }
        break;
      case Direction.downLeft:
        if (animation?.idleDownLeft != null) {
          animation?.play(SimpleAnimationEnum.idleDownLeft);
        } else {
          animation?.play(SimpleAnimationEnum.idleLeft);
        }
        break;
      case Direction.downRight:
        if (animation?.idleDownRight != null) {
          animation?.play(SimpleAnimationEnum.idleDownRight);
        } else {
          animation?.play(SimpleAnimationEnum.idleRight);
        }
        break;
    }
    super.idle();
  }

  @override
  Future<void> onLoad() async {
    await animation?.onLoad();
    idle();
    return super.onLoad();
  }
}
