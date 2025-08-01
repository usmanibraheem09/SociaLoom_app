import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({super.key, this.onTap, required this.isLiked});

  final bool isLiked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
      color: isLiked ? Colors.red: Colors.grey,
      size: 30),
    );
  }
}