import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/onboarding/presentation/widgets/splash_button_widget.dart';
import 'package:drugs_ng/features/onboarding/presentation/widgets/splash_card_options_widget.dart';
import 'package:drugs_ng/features/onboarding/presentation/widgets/splash_screen_header.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Route<dynamic> route(RouteSettings route) {
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // 1. Header – slides down from above the screen
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _headerFade;

  // 2. Splash image – fades + rises from slightly below
  late final Animation<double> _imageFade;
  late final Animation<Offset> _imageSlide;

  // 3. Card options – fades + rises from slightly below
  late final Animation<double> _cardFade;
  late final Animation<Offset> _cardSlide;

  // 4. Button – fades + rises from slightly below
  late final Animation<double> _buttonFade;
  late final Animation<Offset> _buttonSlide;

  // 5. Loader – fades in last
  late final Animation<double> _loaderFade;

  CurvedAnimation _interval(
    double begin,
    double end, [
    Curve curve = Curves.easeOutCubic,
  ]) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: curve),
    );
  }

  @override
  void initState() {
    super.initState();

    // Total: 2 000 ms — each widget animates in sequence with a slight overlap
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // ── 1. Header  (0 % → 22 %) ──────────────────────────────────────────
    final headerCurve = _interval(0.0, 0.22);
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(headerCurve);
    _headerFade = Tween<double>(begin: 0.0, end: 1.0).animate(headerCurve);

    // ── 2. Splash image  (20 % → 42 %) ──────────────────────────────────
    final imageCurve = _interval(0.20, 0.42);
    _imageFade = Tween<double>(begin: 0.0, end: 1.0).animate(imageCurve);
    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(imageCurve);

    // ── 3. Card options  (40 % → 62 %) ──────────────────────────────────
    final cardCurve = _interval(0.40, 0.62);
    _cardFade = Tween<double>(begin: 0.0, end: 1.0).animate(cardCurve);
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(cardCurve);

    // ── 4. Button  (60 % → 80 %) ─────────────────────────────────────────
    final buttonCurve = _interval(0.60, 0.80);
    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(buttonCurve);
    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(buttonCurve);

    // ── 5. Loader  (82 % → 100 %) ────────────────────────────────────────
    _loaderFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_interval(0.82, 1.0, Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Stack(
        children: [
          // ── Wave (static, always visible) ──────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 109.h,
            child: CustomImage(Assets.images.onboardingWave.path),
          ),

          // ── 1. Header: slides in from the top ──────────────────────────
          Positioned(
            top: 119.h,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _headerFade,
              child: SlideTransition(
                position: _headerSlide,
                child: const SplashScreenHeader(),
              ),
            ),
          ),

          // ── 2. Splash image: fades + rises up ──────────────────────────
          Positioned(
            top: 310.h,
            left: -1.w,
            right: 0,
            child: FadeTransition(
              opacity: _imageFade,
              child: SlideTransition(
                position: _imageSlide,
                child: CustomImage(
                  Assets.images.splashImage.path,
                  width: double.maxFinite,
                  height: 258.h,
                ),
              ),
            ),
          ),

          // ── 3. Card options: fades + rises up ──────────────────────────
          Positioned(
            top: 547.h,
            left: 20.w,
            right: 20.w,
            child: FadeTransition(
              opacity: _cardFade,
              child: SlideTransition(
                position: _cardSlide,
                child: const SplashCardOptionsWidget(),
              ),
            ),
          ),

          // ── 4. Button: fades + rises up ────────────────────────────────
          Positioned(
            top: 684.h,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _buttonFade,
              child: SlideTransition(
                position: _buttonSlide,
                child: const SplashButtonWidget(),
              ),
            ),
          ),

          // ── 5. Loader: fades in last ────────────────────────────────────
          Positioned(
            top: 760.h,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _loaderFade,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: CircularProgressIndicator(color: AppColor.color0B8AE1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
