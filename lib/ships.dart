import 'package:flutter/material.dart';
import 'package:space_road/audio.dart';
import 'package:space_road/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_road/ui/widgets/button_item.dart';

class Ships extends StatelessWidget {
  const Ships({super.key});

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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int ships = 1;
  @override
  void initState() {
    initializeSharedPreferences();
    super.initState();
  }

  Future<void> initializeSharedPreferences() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      ships = (prefs.getInt('currentShips') ?? 1);
    });
  }

  Future<void> updateShips(int number) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setInt('currentShips', number);
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
                      'Ships',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 94, 255, 99),
                          fontSize: 40),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                ships = (ships - 2 + 4) % 4 +
                                    1; // Loop between 1 and 4
                              });
                              updateShips(ships);
                              Audio.clickSound();
                            },
                            child: const Text(
                              '<',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/images/Space$ships.png',
                          scale: 2,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Audio.clickSound();

                              setState(() {
                                ships = (ships % 4) + 1; // Loop between 1 and 4
                              });
                              updateShips(ships);
                            },
                            child: const Text(
                              '>',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            )),
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
                                  Audio.clickSound();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.menu,
                                    (route) =>
                                        false, // This predicate removes all previous routes
                                  );
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
