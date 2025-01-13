import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/register/bloc/register_bloc.dart';
import 'package:memmatch/modules/register/bloc/register_state.dart';
import 'package:memmatch/modules/register/models/avatar.dart';
import 'package:memmatch/routes/route_name.dart';

class RegisterScreen extends StatefulWidget {
  String viewType = "NEW";

  RegisterScreen({super.key, required this.viewType});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  List<Avatar> avatars = [];
  int selectedIndex = 1;
  final PageController _pageController =
      PageController(viewportFraction: 0.5, initialPage: 1);
  final TextEditingController _nameController = TextEditingController();

  late AnimationController _typeController;

  String get _placeholderText => "Type your name";
  String _animatedText = "";
  int _currentIndex = 0;
  bool _showCursor = true;
  bool _showError = false;

  // Animation controller and animation for arrow
  late AnimationController _arrowController;
  late Animation<Offset> _arrowAnimation;

  @override
  void initState() {
    super.initState();
    context.read<RegisterBloc>().getAvatarImages();

    _typeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addListener(_onTick);

    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true); // Makes the animation go back and forth

    // Create arrow animation
    _arrowAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0.3, 0), // Move right by 30% of the width
    ).animate(CurvedAnimation(
      parent: _arrowController,
      curve: Curves.easeInOut,
    ));

    // Start the typing animation after a short delay
    Future.delayed(const Duration(milliseconds: 500), _startTypingAnimation);
  }

  void _startTypingAnimation() {
    if (_currentIndex < _placeholderText.length) {
      _typeController.forward(from: 0).then((_) {
        setState(() {
          _animatedText += _placeholderText[_currentIndex];
          _currentIndex++;
        });
        _startTypingAnimation();
      });
    }
  }

  void _onTick() {
    setState(() {
      _showCursor = !_showCursor;
    });
  }

  void _handleButtonPress() {
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _showError = true;
      });
      // Shake animation for the text field
      _shakeTextField();
    } else {
      setState(() {
        _showError = false;
      });

      context.read<RegisterBloc>().addNameAndAvatar(
          name: _nameController.text.trim().toString(),
          selectedIndex: selectedIndex,
          avatars: avatars);
      // Proceed with navigation or next step
      // Add your navigation logic here
    }
  }

  void _shakeTextField() {
    const int shakeDuration = 50;
    const double shakeOffset = 5.0;

    Future.delayed(const Duration(milliseconds: 0), () {
      if (mounted) setState(() => _textFieldOffset = -shakeOffset);
      Future.delayed(const Duration(milliseconds: shakeDuration), () {
        if (mounted) setState(() => _textFieldOffset = shakeOffset);
        Future.delayed(const Duration(milliseconds: shakeDuration), () {
          if (mounted) setState(() => _textFieldOffset = -shakeOffset);
          Future.delayed(const Duration(milliseconds: shakeDuration), () {
            if (mounted) setState(() => _textFieldOffset = 0.0);
          });
        });
      });
    });
  }

  double _textFieldOffset = 0.0;

  @override
  void dispose() {
    _typeController.dispose();
    _nameController.dispose();
    _pageController.dispose();
    _arrowController.dispose();
    super.dispose();
  }

  void _scrollToSelectedIndex() {
    // Add post frame callback to ensure PageView is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          selectedIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, AppState>(
      listener: (context, state) {
        if (state is AvatarImageLoaded) {
          avatars = state.avatars;
          setState(() {});
          if (widget.viewType == "EDIT") {
            context.read<RegisterBloc>().loadUserDetails();
          }
        }
        if (state is UserDetailsSaved) {
          GoRouter.of(context).pushReplacementNamed(RouteName.homeScreen);
        }
        if (state is UserDetailsLoaded) {
          _nameController.text = state.username;
          selectedIndex = state.selectedIndex;

          _scrollToSelectedIndex();
          setState(() {});
        }
      },
      builder: (context, state) {
        if (state is AvatarImageLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics()),
            primary: false,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Select Your Avatar",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // PageView for scrolling images
                          SizedBox(
                            height: 210,
                            child: PageView.builder(
                              // scrollBehavior: CupertinoScrollBehavior(),
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              itemCount: avatars.length,
                              itemBuilder: (context, index) {
                                final avatar = avatars[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: UiWidgets.getSvgFromNetwork(
                                          avatar.imageUrl ?? "",
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover)),
                                );
                              },
                            ),
                          ),
                          // Fixed blue circle overlay
                          Positioned(
                            top: 250,
                            child: Icon(
                              Icons.keyboard_double_arrow_up_outlined,
                              size: 50,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          if (state is SavingUserDetails)
                            Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: const Center(
                                    child: CircularProgressIndicator()))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: Offset(_textFieldOffset, 0),
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText:
                                    _animatedText + (_showCursor ? "|" : ""),
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color:
                                        _showError ? Colors.red : Colors.blue,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color:
                                        _showError ? Colors.red : Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color:
                                        _showError ? Colors.red : Colors.blue,
                                  ),
                                ),
                              ),
                              maxLength: 20,
                            ),
                          ),
                          if (_showError)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 12.0),
                              child: Text(
                                'Please enter your name',
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: ElevatedButton(
                        onPressed: _handleButtonPress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.viewType == "NEW" ? "Let's Go" : "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (widget.viewType == "NEW")
                              SlideTransition(
                                position: _arrowAnimation,
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
