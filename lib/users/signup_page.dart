import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:users_app/utils/get_color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var gender = 'male';
  late String _selecteddate = '';
  final _formKey = GlobalKey<FormState>();

  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 4745)),
      firstDate: DateTime(1945),
      lastDate: DateTime(2014),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: GetColor.primarySeedColor,
              onPrimary: GetColor.whiteTextColor,
              onSurface: GetColor.primarySeedColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: GetColor.primarySeedColor, // button text color
                foregroundColor: GetColor.whiteTextColor,
              ),),
          ),
          child: child!,
        );
      },
    );
    if(selected != null && selected.toString() != _selecteddate) {
      setState(() {
        _selecteddate = DateFormat("dd-MM-yyyy").format(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(40),
        children: [
          Image.asset("assets/images/hello.jpeg",),
          const SizedBox(height: 20,),
          Form(
            key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    //controller: usernameController;
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please entry your name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person, ),
                      label: Text("Name"),
                    ),

                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    //controller: passwordController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please entry your email address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email, ),
                      label: Text("Email address"),
                    ),

                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: true,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please entry your password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock, ),
                      label: Text("Password"),
                    ),
                    style: const TextStyle(
                        color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    children: [
                      const Icon(Icons.person_pin_sharp, ),
                      Radio(value: 'male', groupValue: gender,
                          onChanged: (String? val){
                            setState(() {
                              if (val != null) {
                                gender = val;
                              }
                            });
                          }),
                      const Text("Male"),
                      const SizedBox(width: 30,),
                      Radio(value: 'female', groupValue: gender,
                          onChanged: (String? val){
                            setState(() {
                              if (val != null) {
                                gender = val;
                              }
                            });
                          }),
                      const Text("Female"),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    children: [
                      const Icon(Icons.calendar_month_rounded, ),
                      const SizedBox(width: 15,),
                      OutlinedButton(
                        onPressed: () => _selectDate(context),
                        //statesController: ,
                        child: Text(_selecteddate.length>1?_selecteddate : 'Birthdate',),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),

                ],
              )
          ),
          ElevatedButton(onPressed: (){
            _formKey.currentState!.validate();
          }, child:
          const Text("Sign Up"),

          ),
          const SizedBox(height: 20,),
          Center(
          child: GestureDetector(
            onTap: () { Navigator.pop(context); },
            child: InkWell(
              child: Text("Back to Sign In", style: TextStyle(color: GetColor.primarySeedColor, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          )),
        ],
      ),
    );
  }
}
