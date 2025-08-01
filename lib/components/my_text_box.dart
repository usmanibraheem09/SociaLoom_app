import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/theme/theme_provider.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({super.key, required this.boxText, this.onTap, required this.sectionName, this.myIcon});

  final String boxText;
  final String sectionName;
  final VoidCallback? onTap;
  final IconData? myIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey[300]: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              sectionName,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              ),
              IconButton(onPressed: onTap,
              icon: Icon(
              myIcon,
              color: Colors.grey[600],
              size: 20,
              ),
              ),
            ],
          ),
          Text(
          boxText,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          ),
        ],
      ),
    );
  }
}