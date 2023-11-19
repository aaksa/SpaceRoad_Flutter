import 'package:flutter/material.dart';
import 'package:space_road/audio.dart';
import 'package:space_road/high_scores.dart';
import 'package:space_road/routes.dart';
import 'package:space_road/ui/assets.dart';
import 'package:flame_audio/flame_audio.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Assets.load();
  await HighScores.load();
  await Audio.load();

  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.routes,
      theme: ThemeData(fontFamily: 'Quinque'),
    ),
  );
}
