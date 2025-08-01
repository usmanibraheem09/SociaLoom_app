import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth/auth_services.dart';
import 'package:social_media_app/services/utils/utils.dart';
import 'package:social_media_app/widgets/my_button.dart';
import 'package:social_media_app/widgets/my_text_field.dart';
import 'package:social_media_app/screens/home_page.dart';
import 'package:social_media_app/screens/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/bg_logo.png', height: 100,),
                const SizedBox(height: 10),
                Text('Welcome Back... You have been missed',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                ),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: 'Enter Email',
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hintText: 'Enter your Password',
                  controller: passwordController,
                  obsecureText: true,
                ),
                const SizedBox(height: 10),
                MyButton(
                btnText: 'Login',
                isLoading: isLoading,
                onTap: () async{
                  setState(() {
                    isLoading = true;
                  });
                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                     try{
                      await AuthServices().signIn(emailController.text, passwordController.text);
                     if(!mounted) return;
                     Utils().showToast('User logged in as ${emailController.text}');
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                     }on FirebaseAuthException catch(e){
                      Utils().showToast(e.toString());
                     }
                  }else{
                    Utils().showToast('Fill all the fields carefully');
                  }
                },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    'Does\'nt have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15,
                    ),
                    ),
                    TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    }, 
                    child: Text(
                    'SignUp',
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