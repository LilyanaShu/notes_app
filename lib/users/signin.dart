import 'package:flutter/material.dart';
import 'package:users_app/utils/get_color.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {

  final _formSignIn = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            Image.asset("assets/images/hello.jpeg"),
            const SizedBox(height: 10,),
            //Icon(Icons.person, size: 80, ,),
            Form(
              key: _formSignIn,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please entry your username/email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Username or Email'
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please entry your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      label: Text("Password")
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20,),
            SizedBox(
                width: 270,
                child: ElevatedButton(
                  child: const Text("Login"),
                  onPressed: () {
                    _formSignIn.currentState!.validate();
                  },)
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text ("Don't have account?", style: TextStyle(color: GetColor.blackTextColor, fontSize: 16),),
                GestureDetector(
                  onTap: () { Navigator.of(context).pushNamed("/signup"); },
                  child: InkWell(
                    child: Text("| Sign Up", style: TextStyle(color: GetColor.primarySeedColor, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
