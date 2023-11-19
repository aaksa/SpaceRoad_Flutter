import 'package:flutter/material.dart';
import 'package:space_road/audio.dart';
import 'package:space_road/routes.dart';

class Options extends StatelessWidget {
  const Options({super.key});

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
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // int ships = 1;

  @override
  void initState() {
    // initializeSharedPreferences();
    super.initState();
  }

  // Future<void> initializeSharedPreferences() async {
  //   final SharedPreferences prefs = await _prefs;
  //   setState(() {
  //     ships = (prefs.getInt('currentShips') ?? 1);
  //   });
  // }

  Future<void> updateShips(int number) async {
    // final SharedPreferences prefs = await _prefs;

    // prefs.setInt('currentShips', number);
  }

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Options',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 94, 255, 99),
                          fontSize: 30),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (Audio.isSoundMuted) {
                              Audio.unmuteSfx();
                            } else {
                              Audio.muteSfx();
                            }
                            setState(() {
                              Audio.isSoundMuted;
                            });
                          },
                          child: Opacity(
                            opacity: Audio.isSoundMuted
                                ? 0.5
                                : 1.0, // Set opacity based on the audio state
                            child: Image.asset(
                              'assets/images/sound.png',
                              scale: 2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            if (Audio.isAudioMuted) {
                              Audio.resume();
                            } else {
                              Audio.muteBG();
                            }
                            setState(() {
                              Audio.isAudioMuted;
                            });
                          },
                          child: Opacity(
                            opacity: Audio.isAudioMuted
                                ? 0.5
                                : 1.0, // Set opacity based on the audio state
                            child: Image.asset(
                              'assets/images/music.png',
                              scale: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.deepPurple)),
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.menu,
                                    (route) =>
                                        false, // This predicate removes all previous routes
                                  );
                                  Audio.clickSound();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: Text(
                                    'Back',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
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
  }
}
