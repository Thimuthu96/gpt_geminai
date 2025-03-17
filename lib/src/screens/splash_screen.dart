import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gpt_geminai/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rotationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the bounce AnimationController
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define the bounce animation
    _bounceAnimation = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.bounceOut,
    );

    // Start the bounce animation and begin rotation when done
    _bounceController.forward().then((_) {
      // After the bounce animation finishes, start the rotation
      _rotationController.repeat();
    });

    // Initialize the rotation AnimationController
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _handleNextScreen();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  // Retrieve the stored boolean value
  Future<void> _getStoredValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? storedValue = prefs.getBool('isOnboarded');
    if (storedValue == null || storedValue == false) {
      Navigator.pushNamed(context, AppRoutes.onBoardingScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    }
  }

  void _handleNextScreen() {
    Future.delayed(const Duration(seconds: 4), () {
      _getStoredValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -200 + (_bounceAnimation.value * 200)),
                  child: AnimatedBuilder(
                    animation: _rotationController,
                    builder: (context, child) {
                      // Calculate the rotation angle (only rotates after bounce finishes)
                      double angle = _rotationController.value * 2 * pi;
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002) // Perspective effect
                          ..rotateY(angle), // Rotate around Y-axis
                        alignment: Alignment.center,
                        child: const Image(
                          image: AssetImage("assets/images/robot.png"),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "GPT Geminai",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
