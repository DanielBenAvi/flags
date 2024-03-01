import 'package:confetti/confetti.dart';
import 'package:flags/model/flag.dart';
import 'package:flags/model/game_manager.dart';
import 'package:flags/pages/finish_page.dart';
import 'package:flags/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final confetti = ConfettiController(
    duration: const Duration(seconds: 1),
  );
  GameManager gameManager = GameManager();
  late Question question;

  @override
  void initState() {
    gameManager.resetGame();
    question = gameManager.createQuestions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CupertinoPageScaffold(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // display the heart based on the number of lives
                    for (int i = 0; i < gameManager.hearts; i++)
                      const Icon(
                        CupertinoIcons.heart_fill,
                        color: CupertinoColors.systemRed,
                        size: 40,
                      )
                  ],
                ),
                MyTitle(title: "Score: ${gameManager.getScore}"),
                // display the flag
                FlagImage(flagImage: question.flag.getFlagImage),
                Table(
                  children: [
                    TableRow(
                      children: [
                        FlagText(
                          flagObject: question.options[0],
                          flagCallback: () {
                            flagCallback(question.options[0].name);
                          },
                        ),
                        FlagText(
                          flagObject: question.options[1],
                          flagCallback: () {
                            flagCallback(question.options[1].name);
                          },
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        FlagText(
                          flagObject: question.options[2],
                          flagCallback: () {
                            flagCallback(question.options[2].name);
                          },
                        ),
                        FlagText(
                          flagObject: question.options[3],
                          flagCallback: () {
                            flagCallback(question.options[3].name);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        ConfettiWidget(
            confettiController: confetti,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 20,
            gravity: 0.3,
            emissionFrequency: 0.05,
            maxBlastForce: 20,
            minBlastForce: 8,
            blastDirection: 3.14,
            colors: const [
              CupertinoColors.systemRed,
              CupertinoColors.systemGreen,
              CupertinoColors.systemBlue,
              CupertinoColors.systemYellow,
              CupertinoColors.systemPurple,
              CupertinoColors.systemOrange,
            ])
      ],
    );
  }

  void flagCallback(String flagName) {
    developer.log("flagCallback: $flagName");
    setState(() {
      if (gameManager.checkQuestion(flagName)) {
        _showConfetti();
      }
      question = gameManager.createQuestions();
    });

    if (gameManager.isGameOver()) {
      // chhange to game over page
      developer.log("Game Over");
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                FinishPage(title: "Game Over", score: gameManager.getScore)),
      );
    }
    if (gameManager.isGameFinished()) {
      // change to game finished page
      developer.log("Game Finished");
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => FinishPage(
                title: "Game Finished", score: gameManager.getScore)),
      );
    }
  }

  void _showConfetti() {
    confetti.play();
  }
}
