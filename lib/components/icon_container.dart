import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, this.color, this.icon});

  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color?? Colors.grey[500],
                ),
                child: Center(
                  child: Icon(
                    icon ?? Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                ),
              );
  }
}