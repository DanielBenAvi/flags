import 'dart:developer' as developer;
import 'package:flags/pages/game_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/title.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late List highScores;
  String highScoresString = "";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyTitle(title: "Flags Game"),
            const SizedBox(height: 40),
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const GamePage()),
                );
              },
              child: const Text('Start Game'),
            ),
            CupertinoButton(
                child: const Text("High Score"),
                onPressed: () {
                  loadData();
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text(
                        'High Score',
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        highScoresString,
                        style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 16,
                        ),
                      ),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }),
            CupertinoButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text(
                      'About',
                      style: TextStyle(
                        color: CupertinoColors.systemRed,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      'This is a simple game to test your knowledge of flags. You will be shown a flag and you have to guess the country it represents. You have 3 lives. Good luck!',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 16,
                      ),
                    ),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    highScoresString = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    highScores = prefs.getStringList('highScores') ?? [];

    // Sort the high scores
    highScores.sort((a, b) {
      int scoreA = int.parse(a.split(":")[1].trim());
      int scoreB = int.parse(b.split(":")[1].trim());
      return scoreB.compareTo(scoreA);
    });

    highScores =
        highScores.sublist(0, highScores.length > 5 ? 5 : highScores.length);

    // remove [ and ] from the string

    developer.log('High Scores: ${highScores.toString()}');

    for (String score in highScores) {
      highScoresString += "$score\n";
    }

    setState(() {
      highScoresString;
    });
  }
}
