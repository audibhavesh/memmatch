class LevelConfig {
  final int level;
  final int numCards;
  final int timeLimit;
  final int requiredMoves;
  final bool isLocked;
  final int numCardsPerRow;

  LevelConfig({
    required this.level,
    required this.numCards,
    required this.timeLimit,
    required this.requiredMoves,
    required this.numCardsPerRow,
    this.isLocked = true,
  });
}