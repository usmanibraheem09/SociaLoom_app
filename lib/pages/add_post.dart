import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/home_page.dart';
import 'package:social_media_app/services/auth/auth_services.dart';
import 'package:social_media_app/services/utils/utils.dart';
import 'package:social_media_app/widgets/my_text_field.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}


class _AddPostState extends State<AddPost> {

  final postController = TextEditingController();

  Future<void> submitPost(String postText) async {
    if(postController.text.isNotEmpty){
      try {
        await FirebaseFirestore.instance.collection('posts').add({
          'text': postText,
          'user': AuthServices().getCurrentUser()!.email.toString(),
          'timeStamp': Timestamp.now(),
          'likes': [],
        });
        Utils().showToast('post added successfully');
        postController.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (error) {
        Utils().showToast(error.toString());
      }
    } else {
      Utils().showToast('Please enter some Text');
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('New Post',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                child: MyTextField(
                hintText: 'What\'s on your mind?',
                controller: postController,
              ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  submitPost(postController.text);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}