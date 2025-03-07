// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:news_app/view/home_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       const Duration(seconds: 2),
//       () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const HomeScreen(),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height * 1;
//     // ignore: unused_local_variable
//     final width = MediaQuery.sizeOf(context).width * 1;
//     return Scaffold(
//       // ignore: avoid_unnecessary_containers
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'images/splash_pic.jpg',
//               fit: BoxFit.cover,
//               height: height * 0.5,
//             ),
//             SizedBox(
//               height: height * 0.04,
//             ),
//             Text(
//               'TOP HEADLINES',
//               style: GoogleFonts.anton(
//                 letterSpacing: .6,
//                 color: Colors.grey.shade700,
//               ),
//             ),
//             SizedBox(
//               height: height * 0.04,
//             ),
//             const SpinKitChasingDots(
//               color: Colors.blue,
//               size: 40,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller.forward();

    Timer(
      const Duration(seconds: 2),
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
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with hero animation for transition
              Hero(
                tag: 'app_logo',
                child: Container(
                  height: height * 0.35,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'images/splash_pic.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
                  .animate(controller: _controller)
                  .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutQuint)
                  .fadeIn(duration: const Duration(milliseconds: 600)),

              SizedBox(height: height * 0.05),

              // Headline text with staggered animation
              Text(
                'TOP HEADLINES',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                  color: Colors.blueGrey.shade800,
                ),
              )
                  .animate(controller: _controller)
                  .slideY(
                      begin: 0.5,
                      end: 0,
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutQuint)
                  .fadeIn(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 600)),

              SizedBox(height: height * 0.05),

              // Loading indicator with pulsing animation
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 3,
                  ),
                ),
              )
                  .animate(controller: _controller)
                  .scale(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutBack)
                  .fadeIn(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 600))
                  .then()
                  .animate()
                  .scale(
                      begin: Offset(1.0, 1.0),
                      end: Offset(1.05, 1.05),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut)
                  .then()
                  .scale(
                      begin: Offset(1.05, 1.05),
                      end: Offset(1.0, 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut),
            ],
          ),
        ),
      ),
    );
  }
}
