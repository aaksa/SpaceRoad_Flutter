import 'dart:core';

import 'package:flutter/material.dart';
import 'package:space_road/menu.dart';
import 'package:space_road/my_game.dart';
import 'package:space_road/options.dart';
import 'package:space_road/ships.dart';

import 'game_start/game_start.dart';

class Routes {
  static const menu = '/';
  static const game = '/game';
  static const ships = '/ships';
  static const options = '/options';

  final String route;

  const Routes(this.route);

  static Route routes(RouteSettings settings) {
    MaterialPageRoute _buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }

    switch (settings.name) {
      case menu:
        return _buildRoute(const Menu());
      case game:
        return _buildRoute(MyGameWidget(game: GameStart()));
      case ships:
        return _buildRoute(const Ships());
      case options:
        return _buildRoute(const Options());

      default:
        throw Exception('Route does not exists');
    }
  }
}

extension BuildContextExtension on BuildContext {
  void pushAndRemoveUntil(Routes route) {
    Navigator.pushNamedAndRemoveUntil(this, route.route, (route) => false);
  }

  void push(Routes route) {
    Navigator.pushNamed(this, route.route);
  }
}
