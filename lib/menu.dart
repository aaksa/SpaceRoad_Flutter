import 'package:flutter/material.dart';
import 'package:space_road/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_road/ui/widgets/button_item.dart';
import 'package:flame_audio/flame_audio.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // late SharedPreferences? prefs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int score = 0;

  @override
  void initState() {
    initializeSharedPreferences();
    // startBgmMusic();
    super.initState();
  }

  Future<void> initializeSharedPreferences() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      score = (prefs.getInt('playerScore') ?? 0);
    });
  }

  //   void startBgmMusic() {
  //   FlameAudio.bgm.initialize();
  //   FlameAudio.bgm.play('bgm.mp3');
  // }

  @override
  Widget build(BuildContext context) {
    // if (prefs == null) {
    //   // Handle the case where prefs is still null (not initialized)
    //   return CircularProgressIndicator(); // Or any loading indicator
    // }
    // final int score = prefs!.getInt('playerScore') ?? 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      'Space\nRoad',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 94, 255, 99),
                          fontSize: 40),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Stack(
                        children: [
                          // Background Image
                          Container(
                            child: Image.asset(
                              'assets/images/recordbar.png',
                              scale: 1,
                            ),
                          ),
                          // Centered Text Overlay
                          Positioned.fill(
                            left: 90,
                            child: Center(
                              child: Stack(
                                children: <Widget>[
                                  // Stroked text as border.
                                  Text(
                                    '$score\nRecord',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      height: 1.5,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 6
                                        ..color = Colors.black,
                                    ),
                                  ),
                                  // Solid text as fill.
                                  Text(
                                    '$score\nRecord',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      height: 1.5,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          ButtonItem(
                            title: 'Start',
                            route: Routes.game,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ButtonItem(
                            title: 'Ships',
                            route: Routes.ships,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ButtonItem(
                            title: 'Options',
                            route: Routes.options,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: null,
    //   body: Center(
    //     child: SizedBox(

    //       width: 350,
    //       child: ListView(
    //         children: const [
    //           SizedBox(height: 32),
    //           ButtonItem(
    //             title: '1- The world, bodies, shapes and fixtures',
    //             route: Routes.menu,
    //           ),

    //           ButtonItem(
    //             title: '2- Body types: dynamic, static & kinematic',
    //             route: Routes.lesson07,
    //           ),
    //           ButtonItem(
    //             title: '3- Friction, density & restitution',
    //             route: Routes.lesson07,
    //           ),
    //           ButtonItem(
    //             title: '4- Forces, impulses & linear velocity',
    //             route: Routes.lesson07,
    //           ),
    //           ButtonItem(
    //             title: '5- Bodies and sprites',
    //             route: Routes.lesson07,
    //           ),
    //           ButtonItem(
    //             title: '6- Collisions',
    //             route: Routes.lesson07,
    //           ),
    //           ButtonItem(
    //             title: '7- Collisions with animated sprites',
    //             route: Routes.lesson07,
    //           ),
    //           ButtonItem(
    //             title: '8- Animated sprites: walk, jump, duck',
    //             route: Routes.lesson07,
    //           ),

    //           ButtonItem(
    //             title: '9- Working with the camera',
    //             route: Routes.lesson07,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
