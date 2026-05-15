import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    Future.microtask(() {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF131313);
    const surfaceColor = Color(0xFF201F1F);
    const primaryColor = Color(0xFFFFB59D);
    const secondaryColor = Color(0xFF8E8E93);
    const textPrimary = Color(0xFFFFFFFF);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeIn,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 64,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'ShopScape',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Discover & Shop',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PulseDot(controller: _pulseController, offset: 0.0),
                  _PulseDot(controller: _pulseController, offset: 0.2),
                  _PulseDot(controller: _pulseController, offset: 0.4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PulseDot extends StatelessWidget {
  final AnimationController controller;
  final double offset;

  const _PulseDot({required this.controller, required this.offset});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFFB59D);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final phase = (controller.value + offset) % 1.0;
        final intensity = 1 - (phase - 0.5).abs() * 2;
        final opacity = 0.2 + 0.6 * intensity.clamp(0.0, 1.0);

        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
