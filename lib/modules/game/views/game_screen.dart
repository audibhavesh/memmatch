import 'package:memmatch/core/injector.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/game/bloc/game_bloc.dart';
import 'package:memmatch/modules/game/bloc/game_state.dart';
import 'package:memmatch/modules/home/views/memory_grid.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<GameBloc>()..startGame(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Memory Match'),
          elevation: 0,
        ),
        body: BlocConsumer<GameBloc, AppState>(
          listener: (buildContext, state) {
            if (state is GameCompleted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text('Congratulations! 🎉'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Moves: ${state.score.moves}'),
                      Text(
                        'Time: ${state.score.timeInSeconds ~/ 60}m ${state.score.timeInSeconds % 60}s',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Back to Home'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        buildContext.read<GameBloc>().startGame();
                      },
                      child: const Text('Play Again'),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is GameImagesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GameImagesLoaded) {
              return MemoryGrid(
                images: state.images,
                onGameComplete: (moves) {
                  context.read<GameBloc>().onGameComplete(moves);
                },
                restartGame: () {
                  context.read<GameBloc>().startGame();
                },
              );
            }

            if (state is GameError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () {
                        // context.read<GameBloc>().getImages();
                        context.read<GameBloc>().startGame();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
