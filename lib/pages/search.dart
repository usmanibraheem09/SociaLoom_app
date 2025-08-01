import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/my_text_field.dart';

class Search extends StatelessWidget {
   Search({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              hintText: 'Search Here',
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Recommended posts will appear here'),
            ),
          )
        ],
      )
      ),
    );
  }
}