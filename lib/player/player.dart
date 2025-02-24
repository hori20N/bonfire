import 'package:bonfire/base/game_component.dart';
import 'package:bonfire/bonfire.dart';
import 'package:bonfire/joystick/joystick_controller.dart';
import 'package:bonfire/util/mixins/attackable.dart';
import 'package:bonfire/util/mixins/move_to_position_along_the_path.dart';
import 'package:bonfire/util/mixins/movement.dart';
import 'package:bonfire/util/mixins/movement_by_joystick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Player extends GameComponent
    with
        Movement,
        Attackable,
        MoveToPositionAlongThePath,
        JoystickListener,
        MovementByJoystick {
  Player({
    required Vector2 position,
    required double width,
    required double height,
    double life = 100,
    double speed = 100,
  }) {
    this.speed = speed;
    receivesAttackFrom = ReceivesAttackFromEnum.ENEMY;
    initialLife(life);
    this.position = Rect.fromLTWH(
      position.x,
      position.y,
      width,
      height,
    ).toVector2Rect();
  }

  @override
  void joystickAction(JoystickActionEvent event) {}

  @override
  void moveTo(Vector2 position) {
    this.moveToPositionAlongThePath(position);
  }
}
