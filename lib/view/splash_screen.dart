import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentHeadlineIndex = 0;
  Timer? _headlineTimer;

  final List<String> _headlines = [
    "BREAKING",
    "TRENDING",
    "LATEST",
    "GLOBAL",
    "HEADLINES"
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startHeadlineTimer();
    _navigateToHomeScreen();
  }

  @override
  void dispose() {
    _headlineTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _buildBackgroundGradient(),
        child: SafeArea(
          child: Stack(
            children: [
              _buildBackgroundPattern(),
              _buildMainContent(),
              _buildBottomText(),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.forward();
  }

  void _startHeadlineTimer() {
    _headlineTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentHeadlineIndex = (_currentHeadlineIndex + 1) % _headlines.length;
      });
    });
  }

  void _navigateToHomeScreen() {
    Timer(const Duration(seconds: 3), () {
      _headlineTimer?.cancel();
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  BoxDecoration _buildBackgroundGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blue.shade800,
          Colors.blue.shade600,
          Colors.indigo.shade800,
        ],
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.05,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: 100,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAppLogo(),
          const SizedBox(height: 40),
          _buildAppName(),
          const SizedBox(height: 20),
          _buildHeadlineAnimations(),
          const SizedBox(height: 60),
          _buildLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.article_rounded,
          size: 60,
          color: Colors.blue.shade800,
        ),
      ),
    )
        .animate(controller: _controller)
        .scale(
          begin: const Offset(0.5, 0),
          end: const Offset(1.0, 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: const Duration(milliseconds: 600));
  }

  Widget _buildAppName() {
    return Text(
      "NEWSFLASH",
      style: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: 2,
      ),
    )
        .animate(controller: _controller)
        .slideY(
          begin: 0.3,
          end: 0,
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutQuint,
        )
        .fadeIn(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 600),
        );
  }

  Widget _buildHeadlineAnimations() {
    return SizedBox(
      height: 30,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutQuad,
              )),
              child: child,
            ),
          );
        },
        child: Text(
          _headlines[_currentHeadlineIndex],
          key: ValueKey<int>(_currentHeadlineIndex),
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9),
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 60,
      height: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ).animate(controller: _controller).custom(
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return FractionallySizedBox(
                      widthFactor: value,
                      heightFactor: 1,
                      alignment: Alignment.centerLeft,
                      child: child,
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          "Stay informed. Stay ahead.",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 0.5,
          ),
        ),
      ),
    )
        .animate(controller: _controller)
        .slideY(
          begin: 0.5,
          end: 0,
          delay: const Duration(milliseconds: 800),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutQuint,
        )
        .fadeIn(
          delay: const Duration(milliseconds: 800),
          duration: const Duration(milliseconds: 800),
        );
  }
}
