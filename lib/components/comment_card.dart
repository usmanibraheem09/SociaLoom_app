import 'package:flutter/material.dart';
import 'package:social_media_app/components/icon_container.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.userName, required this.commentText, this.onTap});

  final String userName;
  final String commentText;
  final VoidCallbackAction? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconContainer(),
          const SizedBox(width: 10,),
          Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                
              ),
              ),
              Text(commentText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
              )
            ],
          )
          )
        ],
      ),
    );
  }
}