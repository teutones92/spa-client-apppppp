import 'package:flutter/material.dart';

class LogoImageWidget extends StatefulWidget {
  const LogoImageWidget({super.key});

  @override
  State<LogoImageWidget> createState() => _LogoImageWidgetState();
}

class _LogoImageWidgetState extends State<LogoImageWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    scaleAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (__, _) {
          return Transform.scale(
            scale: scaleAnimation.value,
            child: AnimatedContainer(
              height: 120,
              width: 120,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/icons/Logo.png',
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: _controller.isCompleted
                        ? Colors.black38
                        : Colors.transparent,
                    offset: const Offset(2, 4),
                    blurRadius: 10,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
