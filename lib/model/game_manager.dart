import 'dart:math';

import 'package:flags/model/flag.dart';
import 'package:flags/model/flags.dart';

class Question {
  final FlagObject flag;
  final List<FlagObject> options;

  Question({required this.flag, required this.options});

  bool isCorrect(String selectedFlag) {
    return selectedFlag == flag.name;
  }

  void shuffleOptions() {
    options.shuffle();
  }
}

class GameManager {
  static final GameManager _instance = GameManager._internal();

  factory GameManager() {
    return _instance;
  }

  GameManager._internal();

  List<Question> questions = [];
  Set<int> _usedIndexes = {};

  int _score = 0;
  int _hearts = 3;

  int get getScore => _score;

  void incrementScore() {
    _score++;
  }

  int get hearts => _hearts;

  int randomFlagIndex() {
    var random = Random();
    var index = random.nextInt(flags.length);
    while (_usedIndexes.contains(index)) {
      index = random.nextInt(flags.length);
    }
    _usedIndexes.add(index);
    return index;
  }

  int randomQuestions(int flagIndex, Set tempFlagIndex) {
    var random = Random();
    var index = random.nextInt(flags.length);
    while (index == flagIndex && !tempFlagIndex.contains(index)) {
      index = random.nextInt(flags.length);
    }

    return index;
  }

  Question createQuestions() {
    int index = randomFlagIndex();
    _usedIndexes.add(index);

    Set tempFlagIndex = {};
    tempFlagIndex.add(randomQuestions(index, tempFlagIndex));
    tempFlagIndex.add(randomQuestions(index, tempFlagIndex));
    tempFlagIndex.add(randomQuestions(index, tempFlagIndex));

    Question question = Question(
      flag: flags[index],
      options: [
        flags[index],
        flags[tempFlagIndex.elementAt(0)],
        flags[tempFlagIndex.elementAt(1)],
        flags[tempFlagIndex.elementAt(2)],
      ],
    );
    question.shuffleOptions();
    questions.add(question);

    return question;
  }

  resetGame() {
    questions = [];
    _usedIndexes = {};
    _score = 0;
    _hearts = 3;
  }

  void decrementHearts() {
    if (_hearts > 0) _hearts--;
  }

  bool checkQuestion(String answer) {
    if (questions[questions.length - 1].isCorrect(answer)) {
      incrementScore();
      return true;
    } else {
      _hearts--;
      return false;
    }
  }

  bool isGameFinished() {
    return _usedIndexes.length == flags.length;
  }

  bool isGameOver() {
    return _hearts == 0;
  }
}
