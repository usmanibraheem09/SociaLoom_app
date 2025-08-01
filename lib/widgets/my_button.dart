import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, this.btnText, this.onTap, this.btnHeight, this.isLoading = false, this.color});

  final String? btnText;
  final VoidCallback? onTap;
  final double? btnHeight;
  final bool isLoading;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: btnHeight ?? 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color?? Colors.deepPurple,
        ),
        child: Center(
          child: isLoading? CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ) : Text(
          btnText!,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          ),
        ),
      ),
    );
  }
}