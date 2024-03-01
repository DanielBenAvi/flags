import 'dart:convert';

class Score {
  int score;
  String name;
  Score({required this.score, required this.name});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(score: json['score'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'score': score, 'name': name};
  }
}

class Scores {
  List<Score> scoresList = [];

  Scores({required this.scoresList});

  static String encode(List<Score> scores) {
    return scores
        .map((score) => json.encode(score.toJson()))
        .toList()
        .toString();
  }

  static List<Score> decode(String scores) {
    return json
        .decode(scores)
        .map<Score>((score) => Score.fromJson(score))
        .toList();
  }

  String prettyPrint() {
    return scoresList
        .map((score) => 'Name: ${score.name}, Score: ${score.score}')
        .toList()
        .toString();
  }
}
