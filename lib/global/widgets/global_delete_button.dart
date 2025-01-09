import 'package:flutter/material.dart';

class GlobalIconButton extends StatelessWidget {
  const GlobalIconButton({
    super.key,
    required this.onTap,
    this.iconData = Icons.close,
    this.iconColor = Colors.red,
  });

  final void Function() onTap;
  final IconData? iconData;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(92, 0, 0, 0),
            blurRadius: 10,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(iconData, size: 20, color: iconColor),
        onPressed: onTap,
      ),
    );
  }
}
