// import 'package:memmatch/modules/home/bloc/home_bloc.dart';
// import 'package:memmatch/modules/home/bloc/home_state.dart';
// import 'package:memmatch/modules/home/views/memory_grid.dart';
//
// import '../../../core/package_loader/load_modules.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<HomeBloc>().getImages();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Memory Match')),
//       body: BlocBuilder<HomeBloc, AppState>(
//         builder: (context, state) {
//           if (state is ImagesLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ImagesLoaded) {
//             return MemoryGrid(images: state.images);
//           } else if (state is ImagesError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Center(child: Text('Press the button to load images'));
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/game/views/game_screen.dart';
import 'package:memmatch/modules/home/bloc/home_bloc.dart';
import 'package:memmatch/modules/home/bloc/home_state.dart';
import 'package:memmatch/modules/home/models/score_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Score> scores = [];

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().loadScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        elevation: 0,
      ),
      body: BlocConsumer<HomeBloc, AppState>(
        listener: (context, state) {
          if (state is ScoresLoaded) {
            scores = state.scores;
            setState(() {});
          }
        },
        builder: (context, state) {
          // final scores = state is ScoresLoaded ? state.scores : <Score>[];

          return Column(
            children: [
              // Game Options
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Start New Game',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Test your memory with a new challenge',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Scores Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: const [
                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: scores.isEmpty
                    ? const Center(
                        child: Text('No games played yet'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          final score = scores[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text('Moves: ${score.moves}'),
                              subtitle: Text(
                                'Time: ${score.timeInSeconds ~/ 60}m ${score.timeInSeconds % 60}s\n'
                                '${score.timestamp.toString().split('.')[0]}',
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
