import 'package:flags/pages/start_page.dart';
import 'package:flags/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinishPage extends StatelessWidget {
  final String title;
  final int score;
  const FinishPage({super.key, required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTitle(title: title),
            const SizedBox(height: 40),
            CupertinoButton(
              onPressed: () {
                // input text field to add to high score
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text('Add to High Score'),
                      content: Column(
                        children: [
                          const Text('Enter your name'),
                          CupertinoTextField(
                            controller: textController,
                            placeholder: 'Name',
                          ),
                        ],
                      ),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () {
                            addHighScore(textController.text, score);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Add to High Score'),
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const StartPage()),
                );
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addHighScore(String name, int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> highScores = prefs.getStringList('highScores') ?? [];

    highScores.add('$name: $score');

    prefs.setStringList('highScores', highScores);
  }
}
