import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension CustomAnimations on Widget {
  // Fade in and slide up animation
  Widget fadeInSlideUp({Duration delay = Duration.zero}) {
    return animate(delay: delay)
        .fadeIn(duration: 1200.ms, curve: Curves.easeOut)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuint);
  }

  // Fade in and slide left animation
  Widget fadeInSlideLeft({Duration delay = Duration.zero}) {
    return animate(delay: delay)
        .fadeIn(duration: 1200.ms, curve: Curves.easeOut)
        .slideX(begin: 0.2, end: 0, curve: Curves.easeOutQuint);
  }

  // Scale animation
  Widget scaleAnimation({Duration delay = Duration.zero}) {
    return animate(delay: delay).scale(
      begin: const Offset(0.8, 0.8),
      end: const Offset(1, 1),
      duration: 1200.ms,
      curve: Curves.easeOut,
    );
  }
}
