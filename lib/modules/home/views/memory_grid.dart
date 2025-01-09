// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:memmatch/modules/home/models/image_response.dart';
// import '../../../core/package_loader/load_modules.dart';
//
// class MemoryGrid extends StatefulWidget {
//   final List<String>? images;
//
//   MemoryGrid({required this.images});
//
//   @override
//   _MemoryGridState createState() => _MemoryGridState();
// }
//
// class _MemoryGridState extends State<MemoryGrid>
//     with TickerProviderStateMixin {
//   late List<String> _shuffledImages;
//   List<bool> _matched = [];
//   List<int> _selectedIndices = [];
//   List<AnimationController> _controllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _shuffledImages = [...widget.images ?? [], ...widget.images ?? []];
//     _shuffledImages.shuffle();
//     _matched = List<bool>.filled(_shuffledImages.length, false);
//     for (int i = 0; i < _shuffledImages.length; i++) {
//       _controllers.add(AnimationController(
//         duration: Duration(milliseconds: 300),
//         vsync: this,
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 4.0,
//         mainAxisSpacing: 4.0,
//       ),
//       itemCount: _shuffledImages.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () => _onCardTap(index),
//           child: AnimatedBuilder(
//             animation: _controllers[index],
//             builder: (context, child) {
//               return Transform(
//                 transform:
//                     Matrix4.rotationY(_controllers[index].value * 3.1415),
//                 alignment: Alignment.center,
//                 child: _controllers[index].value > 0.5
//                     ? Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: CachedNetworkImage(
//                           cacheKey: _shuffledImages[index],
//                           imageUrl: _shuffledImages[index],
//                           placeholder: (context, url) => const SizedBox(
//                             width: 60,
//                             height: 60,
//                             child: CupertinoActivityIndicator(),
//                           ),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                           fit: BoxFit.fill,
//                         ),
//                       )
//                     : Container(
//                         color: Colors.grey,
//                         child: Center(
//                           child: Text(
//                             'Memory',
//                             style: TextStyle(color: Colors.white, fontSize: 24),
//                           ),
//                         ),
//                       ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   void _onCardTap(int index) {
//     if (_matched[index] || _selectedIndices.contains(index)) return;
//
//     _controllers[index].forward(from: 0);
//
//     setState(() {
//       _selectedIndices.add(index);
//       if (_selectedIndices.length == 2) {
//         if (_shuffledImages[_selectedIndices[0]] ==
//             _shuffledImages[_selectedIndices[1]]) {
//           _matched[_selectedIndices[0]] = true;
//           _matched[_selectedIndices[1]] = true;
//         } else {
//           Future.delayed(Duration(seconds: 1), () {
//             _controllers[_selectedIndices[0]].reverse();
//             _controllers[_selectedIndices[1]].reverse();
//           });
//         }
//         _selectedIndices.clear();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }

// import 'dart:math';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class MemoryGrid extends StatefulWidget {
//   final List<String>? images;
//   final Function()? onGameComplete;
//
//   const MemoryGrid({
//     Key? key,
//     required this.images,
//     this.onGameComplete,
//   }) : super(key: key);
//
//   @override
//   _MemoryGridState createState() => _MemoryGridState();
// }
//
// class _MemoryGridState extends State<MemoryGrid> with TickerProviderStateMixin {
//   late List<String> _shuffledImages;
//   List<bool> _matched = [];
//   List<bool> _flipped = [];
//   List<int> _selectedIndices = [];
//   List<AnimationController> _controllers = [];
//   bool _isProcessing = false;
//   int _moves = 0;
//   int _matchedPairs = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeGame();
//   }
//
//   void _initializeGame() {
//     // Create pairs of images and shuffle them
//     _shuffledImages = [...widget.images ?? [], ...widget.images ?? []];
//     _shuffledImages.shuffle();
//
//     // Initialize game state
//     _matched = List<bool>.filled(_shuffledImages.length, false);
//     _flipped = List<bool>.filled(_shuffledImages.length, false);
//     _selectedIndices.clear();
//     _moves = 0;
//     _matchedPairs = 0;
//
//     // Initialize animations
//     _controllers = _shuffledImages.map((e) => AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     )).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Game stats
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Moves: $_moves',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'Matches: $_matchedPairs/${widget.images?.length ?? 0}',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         // Game grid
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 1,
//               ),
//               itemCount: _shuffledImages.length,
//               itemBuilder: (context, index) => _buildCard(index),
//             ),
//           ),
//         ),
//         // Reset button
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 for (var controller in _controllers) {
//                   controller.reset();
//                 }
//                 _initializeGame();
//               });
//             },
//             child: const Text('Reset Game'),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCard(int index) {
//     return GestureDetector(
//       onTap: () => _onCardTap(index),
//       child: AnimatedBuilder(
//         animation: _controllers[index],
//         builder: (context, child) {
//           return Transform(
//             transform: Matrix4.rotationY(_controllers[index].value * pi),
//             alignment: Alignment.center,
//             child: Card(
//               elevation: _flipped[index] ? 8 : 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 side: BorderSide(
//                   color: _matched[index] ? Colors.green : Colors.grey,
//                   width: _matched[index] ? 2 : 1,
//                 ),
//               ),
//               child: _controllers[index].value > 0.5
//                   ? ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: CachedNetworkImage(
//                   cacheKey: _shuffledImages[index],
//                   imageUrl: _shuffledImages[index],
//                   placeholder: (context, url) => const Center(
//                     child: CupertinoActivityIndicator(),
//                   ),
//                   errorWidget: (context, url, error) => const Center(
//                     child: Icon(Icons.error, color: Colors.red),
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               )
//                   : Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   gradient: LinearGradient(
//                     colors: [Colors.blue.shade200, Colors.blue.shade400],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: const Center(
//                   child: Icon(
//                     Icons.memory,
//                     size: 40,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _onCardTap(int index) async {
//     // Prevent interactions during processing or with matched/flipped cards
//     if (_isProcessing || _matched[index] || _flipped[index]) return;
//
//     setState(() {
//       _flipped[index] = true;
//       _selectedIndices.add(index);
//     });
//
//     await _controllers[index].forward();
//
//     // Handle second card selection
//     if (_selectedIndices.length == 2) {
//       _isProcessing = true;
//       _moves++;
//
//       if (_shuffledImages[_selectedIndices[0]] ==
//           _shuffledImages[_selectedIndices[1]]) {
//         // Match found
//         setState(() {
//           _matched[_selectedIndices[0]] = true;
//           _matched[_selectedIndices[1]] = true;
//           _matchedPairs++;
//         });
//
//         // Check for game completion
//         if (_matchedPairs == (widget.images?.length ?? 0)) {
//           widget.onGameComplete?.call();
//           _showGameCompleteDialog();
//         }
//       } else {
//         // No match
//         await Future.delayed(const Duration(milliseconds: 1000));
//
//         setState(() {
//           _flipped[_selectedIndices[0]] = false;
//           _flipped[_selectedIndices[1]] = false;
//         });
//
//         await Future.wait([
//           _controllers[_selectedIndices[0]].reverse(),
//           _controllers[_selectedIndices[1]].reverse(),
//         ]);
//       }
//
//       _selectedIndices.clear();
//       _isProcessing = false;
//     }
//   }
//
//   void _showGameCompleteDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Text('Congratulations! 🎉'),
//         content: Text('You completed the game in $_moves moves!'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               setState(() {
//                 _initializeGame();
//               });
//             },
//             child: const Text('Play Again'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:memmatch/modules/home/models/score_model.dart';

class MemoryGrid extends StatefulWidget {
  final List<String>? images;
  final Function(int moves)? onGameComplete;
  final Function()? restartGame;

  const MemoryGrid({
    Key? key,
    required this.images,
    this.onGameComplete,
    this.restartGame
  }) : super(key: key);

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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Changed to 3 columns for better card size
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
                        child: CachedNetworkImage(
                          cacheKey: _shuffledImages[index],
                          imageUrl: _shuffledImages[index],
                          placeholder: (context, url) => const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                          fit: BoxFit.cover,
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
