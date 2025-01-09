import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/home/models/level_config.dart';

class LevelCard extends StatelessWidget {
  final LevelConfig level;
  final bool isLocked;
  final VoidCallback? onTap;

  const LevelCard({
    Key? key,
    required this.level,
    required this.isLocked,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLocked ? Colors.grey[200] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLocked
                ? Colors.grey
                : Theme.of(context).primaryColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLocked)
              const Icon(Icons.lock, size: 32, color: Colors.grey)
            else
              Icon(Icons.play_circle_outline,
                  size: 32,
                  color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              'Level ${level.level}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              '${level.numCards} cards',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${level.timeLimit}s time limit',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}