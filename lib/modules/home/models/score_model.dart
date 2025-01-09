import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Score {
  @HiveField(0)
  final int moves;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final int timeInSeconds;

  @HiveField(3)
  final int level;

  @HiveField(4)
  final int totalTime;

  Score(
      {required this.moves,
      required this.timestamp,
      required this.timeInSeconds,
      required this.level,
      required this.totalTime});

  Map<String, dynamic> toJson() => {
        'moves': moves,
        'timestamp': timestamp.toIso8601String(),
        'timeInSeconds': timeInSeconds,
        'level': level,
        'totalTime': totalTime,
      };

  factory Score.fromJson(Map<dynamic, dynamic> json) => Score(
        moves: json['moves'],
        timestamp: DateTime.parse(json['timestamp']),
        timeInSeconds: json['timeInSeconds'],
        level: json['level'],
        totalTime: json['totalTime'],
      );
}
