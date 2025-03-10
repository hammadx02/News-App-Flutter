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
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller.forward();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeInOutCubic;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var fadeAnimation = animation.drive(tween);

              return FadeTransition(
                opacity: fadeAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
              Colors.indigo.shade800,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: Opacity(
                  opacity: 0.05,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
              ),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App logo/icon
                    Container(
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
                        .fadeIn(duration: const Duration(milliseconds: 600)),

                    const SizedBox(height: 40),

                    // App name
                    Text(
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
                        ),

                    const SizedBox(height: 20),

                    // Rotating headlines
                    SizedBox(
                      height: 30,
                      child: _buildHeadlineAnimations(),
                    ),

                    const SizedBox(height: 60),

                    // Loading indicator
                    _buildLoadingIndicator()
                        .animate(controller: _controller)
                        .scale(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.elasticOut,
                        )
                        .fadeIn(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 800),
                        ),
                  ],
                ),
              ),

              // Bottom text
              Positioned(
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
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadlineAnimations() {
    return Stack(
      alignment: Alignment.center,
      children: List.generate(_headlines.length, (index) {
        return Text(
          _headlines[index],
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9),
            letterSpacing: 1.5,
          ),
        )
            .animate(controller: _controller)
            .fadeIn(
              delay: Duration(milliseconds: 700 + (index * 200)),
              duration: const Duration(milliseconds: 400),
            )
            .then()
            .fadeOut(
              delay: Duration(milliseconds: 900 + (index * 200)),
              duration: const Duration(milliseconds: 400),
            );
      }),
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
}
