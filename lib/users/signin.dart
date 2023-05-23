import 'package:flutter/material.dart';
import 'package:users_app/pages/homepage.dart';
import 'package:users_app/utils/get_color.dart';
import 'package:users_app/utils/get_shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final _formSignIn = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool isPassExist = false;
  String? _password;


  @override
  void initState(){

    usernameController = TextEditingController();
    passwordController = TextEditingController();
    String? pass = GetSharedPreferences.getPassword();

    if(pass != null){
      setState(() {
        isPassExist = true;
        _password = pass;
      });
    }
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

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
                    controller: usernameController,
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
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
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
                  onPressed: () async{
                    if (
                      //usernameController.text.isNotEmpty && passwordController.text.isNotEmpty
                        _formSignIn.currentState!.validate()
                      ){
                      await GetSharedPreferences.setLogin(
                          username: usernameController.text,
                          password: passwordController.text);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context){
                            return const HomePage();
                          }));
                    }
                  }
                  ,)
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
