import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/components/comment_card.dart';
import 'package:social_media_app/components/like_button.dart';
import 'package:social_media_app/components/icon_container.dart';
import 'package:social_media_app/services/auth/auth_services.dart';
import 'package:social_media_app/theme/theme_provider.dart';
import 'package:social_media_app/widgets/my_text_field.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.postText,
    required this.user,
    required this.postId,
    required this.likes,
  });

  final String postText;
  final String user;
  final String postId;
  final List<String> likes;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final currentUser = AuthServices().getCurrentUser();
  bool isLiked = false;
  final commentController = TextEditingController();
  final _postref = FirebaseFirestore.instance.collection('posts');

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser!.email.toString());
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef = _postref.doc(widget.postId);
    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser!.email.toString()]),
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser!.email.toString()]),
      });
    }
  }

  void addComment(String commentText) {
    _postref.doc(widget.postId).collection('comments').add({
      'commentText': commentText,
      'timeStamp': FieldValue.serverTimestamp(),
      'userName': currentUser!.email.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconContainer(),
              const SizedBox(width: 10),
              Text(
                widget.user,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(bottom: 5, right: 10, left: 10),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.grey[800]
                : Colors.white,
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.postText,
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LikeButton(isLiked: isLiked, onTap: toggleLike),
              Text(
                widget.likes.length.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  _commentSection(context);
                },
                icon: Icon(Icons.comment, color: Colors.grey[600]),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(widget.postId)
                    .collection('comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final commentsCount = snapshot.data!.docs.length;
                    return Text(
                      commentsCount.toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text('0');
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _commentSection(BuildContext context) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Comments',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  
                  child: StreamBuilder(
                    stream: _postref
                        .doc(widget.postId)
                        .collection('comments')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final comments = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final commentData = comments[index];
                            return CommentCard(
                              userName: commentData['userName'],
                              commentText: commentData['commentText'],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error loading comments'));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          hintText: 'Add a comment',
                          controller: commentController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          if (commentController.text.isNotEmpty) {
                            addComment(commentController.text);
                            commentController.clear();
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Icon(Icons.send, size: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
