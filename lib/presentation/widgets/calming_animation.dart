import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class CalmingAnimation extends StatefulWidget {
  const CalmingAnimation({super.key});

  @override
  State<CalmingAnimation> createState() => _CalmingAnimationState();
}

class _CalmingAnimationState extends State<CalmingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _fadeController;
  late Animation<double> _breathingAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _breathingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _breathingAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOut,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    
    _startAnimations();
  }

  void _startAnimations() {
    _fadeController.forward();
    _breathingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _breathingAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _breathingAnimation.value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppConstants.primaryColor.withOpacity(0.3),
                        AppConstants.primaryColor.withOpacity(0.1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppConstants.primaryColor.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      size: 80,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppConstants.spacingXL),
          Text(
            'Breathe in... Breathe out...',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppConstants.textPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            'Focus on your breath and let your mind rest',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 