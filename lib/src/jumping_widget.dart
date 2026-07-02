import 'dart:async';
import 'package:flutter/material.dart';

/// A premium, highly customizable jumping and shaking widget for Flutter.
///
/// It can wrap any widget (like a crown icon, star, or text badge) and animate it
/// periodically or continuously. Supports optional text labels with coordinated
/// scaling, translation, and color transition animations.
class AwesomeJumpingWidget extends StatefulWidget {
  /// The child widget that will jump and shake (e.g., an Icon or Image).
  final Widget child;

  /// A custom widget to display below the jumping element.
  /// If this is provided, [labelText] is ignored.
  final Widget? label;

  /// Custom label text. If provided and [label] is null, this will be wrapped
  /// in a [Text] widget.
  final String? labelText;

  /// TextStyle for the [labelText].
  final TextStyle? labelStyle;

  /// Whether the widget should start and repeat the animation loop automatically.
  /// Defaults to true.
  final bool shouldAnimate;

  /// The duration of a single jump/shake animation cycle.
  /// Defaults to 1500 milliseconds.
  final Duration animationDuration;

  /// The idle interval duration between animation cycles when looping.
  /// Defaults to 15 seconds.
  final Duration intervalDuration;

  /// The maximum vertical height of the jump (in logical pixels).
  /// Defaults to 10.0.
  final double jumpHeight;

  /// The curve used when the child jumps up.
  /// Defaults to [Curves.easeOut].
  final Curve jumpCurve;

  /// The curve used when the child lands down.
  /// Defaults to [Curves.bounceOut].
  final Curve landCurve;

  /// Whether to shake/rotate the child during the jump.
  /// Defaults to true.
  final bool enableShake;

  /// The maximum angle of rotation during shake, in radians.
  /// Defaults to 0.15.
  final double shakeAngle;

  /// Whether to animate the label text (scale, translate, color).
  /// Defaults to true.
  final bool animateLabel;

  /// The maximum scale applied to the label during animation.
  /// Defaults to 1.1.
  final double labelMaxScale;

  /// The maximum vertical offset applied to the label during animation.
  /// Defaults to -3.0.
  final double labelTranslateY;

  /// If provided, the label text color will transition from [labelColorBegin]
  /// to [labelColorEnd] and back.
  /// If not provided, it defaults to the text style color or [ThemeData.disabledColor].
  final Color? labelColorBegin;

  /// The destination text color at the peak of the jump.
  /// Defaults to [Colors.orange].
  final Color? labelColorEnd;

  /// Width of the widget container. Defaults to 24.0.
  final double width;

  /// Height of the widget container. Defaults to 24.0.
  final double height;

  /// The distance of the label from the top of the container.
  /// Defaults to 27.0.
  final double labelTop;

  /// Horizontal padding/constraints for the positioned label inside the Stack.
  /// Defaults to -60.0 to allow text to overflow wider than the container bounds.
  final double labelHorizontalPadding;

  const AwesomeJumpingWidget({
    super.key,
    required this.child,
    this.label,
    this.labelText,
    this.labelStyle,
    this.shouldAnimate = true,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.intervalDuration = const Duration(seconds: 15),
    this.jumpHeight = 10.0,
    this.jumpCurve = Curves.easeOut,
    this.landCurve = Curves.bounceOut,
    this.enableShake = true,
    this.shakeAngle = 0.15,
    this.animateLabel = true,
    this.labelMaxScale = 1.1,
    this.labelTranslateY = -3.0,
    this.labelColorBegin,
    this.labelColorEnd = Colors.orange,
    this.width = 24.0,
    this.height = 24.0,
    this.labelTop = 27.0,
    this.labelHorizontalPadding = -60.0,
  });

  @override
  State<AwesomeJumpingWidget> createState() => _AwesomeJumpingWidgetState();
}

class _AwesomeJumpingWidgetState extends State<AwesomeJumpingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _iconJumpAnimation;
  late Animation<double> _iconShakeAnimation;

  late Animation<double> _textScaleAnimation;
  late Animation<double> _textTranslateAnimation;
  late Animation<Color?> _textColorAnimation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupAnimations();
    _restartAnimationLoopIfNeeded();
  }

  @override
  void didUpdateWidget(covariant AwesomeJumpingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    bool needsAnimationRebuild = false;

    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
      needsAnimationRebuild = true;
    }

    if (widget.jumpHeight != oldWidget.jumpHeight ||
        widget.jumpCurve != oldWidget.jumpCurve ||
        widget.landCurve != oldWidget.landCurve ||
        widget.enableShake != oldWidget.enableShake ||
        widget.shakeAngle != oldWidget.shakeAngle ||
        widget.labelMaxScale != oldWidget.labelMaxScale ||
        widget.labelTranslateY != oldWidget.labelTranslateY ||
        widget.labelColorBegin != oldWidget.labelColorBegin ||
        widget.labelColorEnd != oldWidget.labelColorEnd) {
      needsAnimationRebuild = true;
    }

    if (needsAnimationRebuild) {
      _setupAnimations();
    }

    if (widget.shouldAnimate != oldWidget.shouldAnimate ||
        widget.intervalDuration != oldWidget.intervalDuration) {
      if (widget.shouldAnimate) {
        _startAnimationLoop();
      } else {
        _stopAndReset();
      }
    }
  }

  void _setupAnimations() {
    _iconJumpAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -widget.jumpHeight).chain(CurveTween(curve: widget.jumpCurve)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: ConstantTween(-widget.jumpHeight),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -widget.jumpHeight, end: 0.0).chain(CurveTween(curve: widget.landCurve)),
        weight: 40,
      ),
    ]).animate(_controller);

    if (widget.enableShake) {
      _iconShakeAnimation = TweenSequence<double>([
        TweenSequenceItem(tween: ConstantTween(0.0), weight: 20),
        TweenSequenceItem(
          tween: TweenSequence([
            TweenSequenceItem(tween: Tween(begin: 0.0, end: widget.shakeAngle), weight: 1),
            TweenSequenceItem(tween: Tween(begin: widget.shakeAngle, end: -widget.shakeAngle), weight: 2),
            TweenSequenceItem(tween: Tween(begin: -widget.shakeAngle, end: widget.shakeAngle), weight: 2),
            TweenSequenceItem(tween: Tween(begin: widget.shakeAngle, end: 0.0), weight: 1),
          ]),
          weight: 40,
        ),
        TweenSequenceItem(tween: ConstantTween(0.0), weight: 40),
      ]).animate(_controller);
    } else {
      _iconShakeAnimation = ConstantTween<double>(0.0).animate(_controller);
    }

    _textScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: widget.labelMaxScale).chain(CurveTween(curve: widget.jumpCurve)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: ConstantTween(widget.labelMaxScale),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.labelMaxScale, end: 1.0).chain(CurveTween(curve: widget.landCurve)),
        weight: 40,
      ),
    ]).animate(_controller);

    _textTranslateAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: widget.labelTranslateY).chain(CurveTween(curve: widget.jumpCurve)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: ConstantTween(widget.labelTranslateY),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.labelTranslateY, end: 0.0).chain(CurveTween(curve: widget.landCurve)),
        weight: 40,
      ),
    ]).animate(_controller);

    final effectiveBeginColor = widget.labelColorBegin ??
        widget.labelStyle?.color ??
        Theme.of(context).disabledColor;

    final effectiveEndColor = widget.labelColorEnd ?? Colors.orange;

    _textColorAnimation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: effectiveBeginColor, end: effectiveEndColor),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: ConstantTween(effectiveEndColor),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: effectiveEndColor, end: effectiveBeginColor),
        weight: 40,
      ),
    ]).animate(_controller);
  }

  void _restartAnimationLoopIfNeeded() {
    if (widget.shouldAnimate && !_controller.isAnimating && _timer == null) {
      _startAnimationLoop();
    }
  }

  void _startAnimationLoop() {
    _timer?.cancel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.shouldAnimate) {
        _controller.forward(from: 0.0);
      }
    });

    _timer = Timer.periodic(widget.intervalDuration, (_) {
      if (mounted && widget.shouldAnimate) {
        _controller.forward(from: 0.0);
      }
    });
  }

  void _stopAndReset() {
    _timer?.cancel();
    _timer = null;
    _controller.stop();
    _controller.value = 0.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showLabel = widget.label != null || widget.labelText != null;

    Widget childWidget = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, _iconJumpAnimation.value),
              child: Transform.rotate(
                angle: _iconShakeAnimation.value,
                child: widget.child,
              ),
            ),
            if (showLabel)
              Positioned(
                top: widget.labelTop,
                left: widget.labelHorizontalPadding,
                right: widget.labelHorizontalPadding,
                child: Center(
                  child: widget.animateLabel
                      ? Transform.translate(
                          offset: Offset(0, _textTranslateAnimation.value),
                          child: Transform.scale(
                            scale: _textScaleAnimation.value,
                            child: _buildLabel(context),
                          ),
                        )
                      : _buildLabel(context),
                ),
              ),
          ],
        );
      },
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: childWidget,
    );
  }

  Widget _buildLabel(BuildContext context) {
    if (widget.label != null) {
      return widget.label!;
    }

    final TextStyle defaultStyle = TextStyle(
      fontSize: 12,
      fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
      fontWeight: FontWeight.w400,
    );

    final textStyle = widget.labelStyle != null
        ? defaultStyle.merge(widget.labelStyle)
        : defaultStyle;

    final Color? animatedColor = widget.animateLabel
        ? _textColorAnimation.value
        : (widget.labelColorBegin ?? textStyle.color);

    return Text(
      widget.labelText!,
      style: textStyle.copyWith(color: animatedColor),
    );
  }
}
