import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/injector.dart';
import 'package:memmatch/modules/history/bloc/history_bloc.dart';
import 'package:memmatch/modules/history/bloc/history_state.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().loadHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          elevation: 0,
        ),
        body: BlocBuilder<HistoryBloc, AppState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoaded) {
              final scores = state.scores;
              return scores.isEmpty
                  ? const Center(child: Text('No games played yet'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: scores.length,
                      itemBuilder: (context, index) {
                        final score = scores[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading:
                                CircleAvatar(child: Text('${index + 1}')),
                            title: Text(
                                'Level: ${score.level} Moves: ${score.moves}'),
                            subtitle: Text(
                              // 'Time: ${score.timeInSeconds ~/ 60}m ${score.timeInSeconds % 60}s\n'
                              // 'Time: ${score.timeInSeconds ~/ 60}m ${score.timeInSeconds % 60}s\n'
                              'Total Time: ${score.totalTime ~/ 60}m ${score.totalTime % 60}s\n'
                              '${score.timestamp.toString().split('.')[0]}',
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return const Center(child: Text('Failed to load history'));
            }
          },
        ));
  }
}
