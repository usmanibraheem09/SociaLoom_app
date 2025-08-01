import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/home_page.dart';
import 'package:social_media_app/services/auth/auth_services.dart';
import 'package:social_media_app/services/utils/utils.dart';
import 'package:social_media_app/widgets/my_button.dart';
import 'package:social_media_app/widgets/my_text_field.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person,
                size: 90,
                ),
                Text('Get yourself registered now!!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                ),
                ),
                const SizedBox(height: 10),
               
                MyTextField(
                  hintText: 'Enter Your Email',
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hintText: 'Enter Your Password',
                  controller: passController,
                  obsecureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hintText: 'Confirm Password',
                  controller: confirmPassController,
                  obsecureText: true,
                ),
                const SizedBox(height: 10),
                MyButton(
                  btnText: 'Sign Up',
                  onTap: ()async {
                    if(passController.text == confirmPassController.text){
                      if(passController.text.length >= 8){
                      try{
                        await AuthServices().signUp(
                        emailController.text, 
                        passController.text,
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                          Utils().showToast('User created successfully');
                      }on FirebaseAuthException catch(e){
                        Utils().showToast(e.toString());
                      }
                      }
                    }else{
                      Utils().showToast('Password does\'nt match');
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15,
                    ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}