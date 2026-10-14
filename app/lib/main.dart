import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF292929),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: false,
    ),
  );
  runApp(const BookfaceApp());
}

class BookfaceApp extends StatelessWidget {
  const BookfaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3978E8)),
        useMaterial3: true,
      ),
      home: const FacebookSplashScreen(),
    );
  }
}

class FacebookSplashScreen extends StatefulWidget {
  const FacebookSplashScreen({super.key});

  @override
  State<FacebookSplashScreen> createState() => _FacebookSplashScreenState();
}

class _FacebookSplashScreenState extends State<FacebookSplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _loadingController;
  Timer? _transitionTimer;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.98,
      upperBound: 1.02,
    )..repeat(reverse: true);
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 840),
    )..repeat();
    _transitionTimer = Timer(
      const Duration(milliseconds: 2600),
      _showLoginScreen,
    );
  }

  void _showLoginScreen() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, _, _) => const FacebookLoginScreen(),
        transitionsBuilder: (_, animation, _, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.025),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _transitionTimer?.cancel();
    _logoController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final logoSize = (constraints.maxWidth * 0.19)
                      .clamp(64.0, 92.0)
                      .toDouble();

                  return Stack(
                    children: [
                      Align(
                        alignment: const Alignment(0, -0.02),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ScaleTransition(
                              scale: _logoController,
                              child: FacebookMark(size: logoSize),
                            ),
                            const SizedBox(height: 22),
                            LoadingDots(controller: _loadingController),
                          ],
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: 48,
                        child: MetaSignature(),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: 14,
                        child: Center(child: GestureIndicator()),
                      ),
                    ],
                  );
                },
              ),
            ),
            AttributionBar(bottomInset: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}

class LoadingDots extends StatelessWidget {
  const LoadingDots({required this.controller, super.key});

  final Animation<double> controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final activeDot = (controller.value * 3).floor() % 3;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF3978E8)
                    .withValues(alpha: index == activeDot ? 1 : 0.25),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}

class FacebookMark extends StatelessWidget {
  const FacebookMark({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFF3978E8),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Transform.translate(
            offset: Offset(1, size * 0.035),
            child: Text(
              'f',
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.88,
                fontWeight: FontWeight.w700,
                height: 0.95,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MetaSignature extends StatelessWidget {
  const MetaSignature({super.key});

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF3978E8);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'from',
          style: TextStyle(color: Color(0xFF75818D), fontSize: 12, height: 1.2),
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 35,
              height: 22,
              child: CustomPaint(painter: MetaInfinityPainter(blue)),
            ),
            const SizedBox(width: 5),
            Text(
              'Meta',
              style: TextStyle(
                color: blue,
                fontSize: 21,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MetaInfinityPainter extends CustomPainter {
  const MetaInfinityPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.5, size.height * 0.54)
      ..cubicTo(
        size.width * 0.35,
        size.height * 0.16,
        size.width * 0.08,
        size.height * 0.16,
        size.width * 0.08,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width * 0.08,
        size.height * 0.84,
        size.width * 0.32,
        size.height * 0.84,
        size.width * 0.5,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width * 0.68,
        size.height * 0.16,
        size.width * 0.92,
        size.height * 0.16,
        size.width * 0.92,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width * 0.92,
        size.height * 0.84,
        size.width * 0.65,
        size.height * 0.84,
        size.width * 0.5,
        size.height * 0.54,
      );

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(MetaInfinityPainter oldDelegate) =>
      oldDelegate.color != color;
}

class GestureIndicator extends StatelessWidget {
  const GestureIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      height: 4,
      decoration: BoxDecoration(
        color: const Color(0xFF9B9B9B),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class AttributionBar extends StatelessWidget {
  const AttributionBar({required this.bottomInset, super.key});

  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final barHeight = (MediaQuery.sizeOf(context).height * 0.07)
        .clamp(54.0, 68.0)
        .toDouble();

    return Container(
      color: const Color(0xFF292929),
      padding: EdgeInsets.fromLTRB(18, 0, 18, bottomInset),
      child: SizedBox(
        height: barHeight,
        child: Row(
          children: [
            const _FacebookAttribution(),
            const Spacer(),
            Text(
              'curated by',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.82),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              'Mobbin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FacebookAttribution extends StatelessWidget {
  const _FacebookAttribution();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Color(0xFF3978E8),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'f',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
        const SizedBox(width: 7),
        const Text(
          'Facebook',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class FacebookLoginScreen extends StatefulWidget {
  const FacebookLoginScreen({super.key});

  @override
  State<FacebookLoginScreen> createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  bool _hidePassword = true;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  InputDecoration _fieldDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFDADDE1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3978E8), width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFF0F2F5);
    const blue = Color(0xFF3978E8);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 32,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'facebook',
                                style: TextStyle(
                                  color: blue,
                                  fontSize: 43,
                                  fontWeight: FontWeight.w700,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Log in to Facebook',
                                style: TextStyle(
                                  color: Color(0xFF1C1E21),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 25),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: _fieldDecoration(
                                  'Email or phone number',
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                obscureText: _hidePassword,
                                textInputAction: TextInputAction.done,
                                decoration: _fieldDecoration(
                                  'Password',
                                  suffixIcon: IconButton(
                                    tooltip: _hidePassword
                                        ? 'Show password'
                                        : 'Hide password',
                                    onPressed: () => setState(
                                      () => _hidePassword = !_hidePassword,
                                    ),
                                    icon: Icon(
                                      _hidePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xFF606770),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: FilledButton(
                                  onPressed: () => _showMessage(
                                    'Sign-in is not connected yet.',
                                  ),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => _showMessage(
                                  'Password recovery is not connected yet.',
                                ),
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Text(
                                      'or',
                                      style: TextStyle(
                                        color: Color(0xFF606770),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              const SizedBox(height: 18),
                              OutlinedButton(
                                onPressed: () => _showMessage(
                                  'Account creation is not connected yet.',
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF2E8B25),
                                  side: const BorderSide(
                                    color: Color(0xFF2E8B25),
                                  ),
                                  minimumSize: const Size.fromHeight(48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Create new account',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
