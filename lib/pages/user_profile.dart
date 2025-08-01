import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_text_box.dart';
import 'package:social_media_app/screens/login_page.dart';
import 'package:social_media_app/services/auth/auth_services.dart';
import 'package:social_media_app/services/utils/utils.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final currentUser = AuthServices().getCurrentUser();
  final userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> _editField(String fieldName, BuildContext context) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(fieldName),
        content: TextField(
          onChanged: (value) {
            newValue = value;
          },
          decoration: InputDecoration(hintText: 'Enter new $fieldName'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (currentUser?.email != null && newValue.isNotEmpty) {
                await userCollection.doc(currentUser!.email).update({
                  fieldName: newValue,
                });
                Navigator.of(context).pop();
                Utils().showToast('$fieldName updated successfully');
              } else {
                Utils().showToast('Please enter a valid $fieldName');
              }
            },
            child: Text('save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null || currentUser?.email == null) {
      return Scaffold(
      body: Center(child: Text('No user logged in'))
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: userCollection.doc(currentUser!.email).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  const SizedBox(height: 50),
                  Icon(
                    Icons.person,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    currentUser!.email.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'My Details',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MyTextBox(
                    sectionName: 'user name',
                    boxText: snapshot.data!['userName'] ?? 'No username',
                    myIcon: Icons.edit,
                    onTap: () {
                      _editField('user name', context);
                    },
                  ),
                  MyTextBox(
                    boxText: snapshot.data!['bio'] ?? 'Empty bio',
                    sectionName: 'bio',
                    myIcon: Icons.edit,
                    onTap: () {
                      _editField('bio', context);
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Colors.white),
                      contentPadding: EdgeInsets.only(left: 50),
                      tileColor: Colors.red.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      title: Text(
                        'L O G O U T',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        AuthServices().logOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                        Utils().showToast('User Logged Out');
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
