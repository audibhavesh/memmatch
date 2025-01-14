import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:memmatch/core/management/cache/file_prefetcher.dart';
import 'package:memmatch/injector.dart';
import 'package:memmatch/modules/home/models/level_config.dart';
import 'dart:math' show pi;

import 'package:memmatch/modules/home/models/score_model.dart';

class MemoryGrid extends StatefulWidget {
  final List<String>? images;
  final Function(int moves)? onGameComplete;
  final Function()? restartGame;
  final LevelConfig levelConfig;

  const MemoryGrid(
      {Key? key,
      required this.images,
      this.onGameComplete,
      this.restartGame,
      required this.levelConfig})
      : super(key: key);

  @override
  _MemoryGridState createState() => _MemoryGridState();
}

class _MemoryGridState extends State<MemoryGrid> with TickerProviderStateMixin {
  late List<String> _shuffledImages;
  List<bool> _matched = [];
  List<bool> _flipped = [];
  List<int> _selectedIndices = [];
  List<AnimationController> _controllers = [];
  bool _isProcessing = false;
  int _moves = 0;
  int _matchedPairs = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _shuffledImages = [...widget.images ?? [], ...widget.images ?? []];
    _shuffledImages.shuffle();
    _matched = List<bool>.filled(_shuffledImages.length, false);
    _flipped = List<bool>.filled(_shuffledImages.length, false);
    _selectedIndices.clear();
    _moves = 0;
    _matchedPairs = 0;
    _controllers = _shuffledImages
        .map((e) => AnimationController(
              duration: const Duration(milliseconds: 400),
              vsync: this,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // int fullRows = _shuffledImages.length ~/ widget.levelConfig.numCardsPerRow;
    // int remainder = _shuffledImages.length % widget.levelConfig.numCardsPerRow;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Moves: $_moves',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Matches: $_matchedPairs/${widget.images?.length ?? 0}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // crossAxisCount: (widget.levelConfig.numCards / 2).toInt(),
                crossAxisCount: widget.levelConfig.numCardsPerRow,
                // Changed to 3 columns for better card size
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio:
                    0.7, // Making cards more rectangular like playing cards
              ),
              itemCount: _shuffledImages.length,
              itemBuilder: (context, index) => _buildCard(index),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                widget.restartGame?.call();
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('Reset Game', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(int index) {
    precacheImage(CachedNetworkImageProvider(_shuffledImages[index]), context);
    return GestureDetector(
      onTap: () => _onCardTap(index),
      child: AnimatedBuilder(
        animation: _controllers[index],
        builder: (context, child) {
          return Transform(
            transform: Matrix4.rotationY(_controllers[index].value * pi),
            alignment: Alignment.center,
            child: Card(
              elevation: _flipped[index] ? 8 : 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: _matched[index] ? Colors.green : Colors.white,
                  width: _matched[index] ? 2 : 1,
                ),
              ),
              child: _controllers[index].value > 0.5
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child:
                            // Image(
                            //     loadingBuilder: (context, child, url) =>
                            //         const Center(
                            //           child: CupertinoActivityIndicator(),
                            //         ),
                            //     errorBuilder: (context, url, error) =>
                            //         const Center(
                            //           child: Icon(Icons.error, color: Colors.red),
                            //         ),
                            //     image:CachedNetworkImageProvider(
                            //         _shuffledImages[index],
                            //         cacheManager:
                            //             getIt.get<DefaultCacheManager>(),
                            //         cacheKey: ImagePreFetcher.generateCacheKey(
                            //             _shuffledImages[index])))

                            CachedNetworkImage(
                          // cacheKey: ImagePreFetcher.generateCacheKey(
                          //     _shuffledImages[index]),
                          imageUrl: _shuffledImages[index],
                          placeholder: (context, url) => const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                          fit: BoxFit.cover,
                          // cacheManager: getIt.get<DefaultCacheManager>()
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo.shade300,
                            Colors.indigo.shade500,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 4,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.style,
                              size: 30,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          // Decorative corners
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Icon(
                              Icons.brightness_1,
                              size: 12,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Icon(
                              Icons.brightness_1,
                              size: 12,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  void _onCardTap(int index) async {
    if (_isProcessing || _matched[index] || _flipped[index]) return;

    setState(() {
      _flipped[index] = true;
      _selectedIndices.add(index);
    });

    await _controllers[index].forward();

    if (_selectedIndices.length == 2) {
      _isProcessing = true;
      _moves++;

      if (_shuffledImages[_selectedIndices[0]] ==
          _shuffledImages[_selectedIndices[1]]) {
        setState(() {
          _matched[_selectedIndices[0]] = true;
          _matched[_selectedIndices[1]] = true;
          _matchedPairs++;
        });

        if (_matchedPairs == (widget.images?.length ?? 0)) {
          widget.onGameComplete?.call(_moves);
          // _showGameCompleteDialog();
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 1000));

        setState(() {
          _flipped[_selectedIndices[0]] = false;
          _flipped[_selectedIndices[1]] = false;
        });

        await Future.wait([
          _controllers[_selectedIndices[0]].reverse(),
          _controllers[_selectedIndices[1]].reverse(),
        ]);
      }

      _selectedIndices.clear();
      _isProcessing = false;
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
