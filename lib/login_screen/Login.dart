// ignore_for_file: must_be_immutable

import 'package:dopproject/login_screen/login_cubit/login_cubit.dart';
import 'package:dopproject/register_screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: const Image(
                                image: AssetImage('assets/Bone Care.png'),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: 'Enter your E-Mail',
                              labelText: 'E-Mail',
                              labelStyle: const TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.lightBlueAccent,
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: password,
                          keyboardType: TextInputType.text,
                          obscureText: cubit.obscure,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: 'Enter your Password',
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.lightBlueAccent, fontSize: 18, fontWeight: FontWeight.bold),
                            prefixIcon: const Icon(Icons.lock, color: Colors.lightBlueAccent),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeObscure();
                              },
                              icon: cubit.obscure
                                  ? Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.lightBlueAccent,
                                    )
                                  : Icon(
                                      Icons.visibility_off_sharp,
                                      color: Colors.lightBlueAccent,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        cubit.isloading == false
                            ? ElevatedButton(
                                onPressed: () {
                                  cubit.login(
                                    email: email.text,
                                    password: password.text,
                                    context: context,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlueAccent,
                                    elevation: 10.0,
                                    textStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                child: const Text('LOGIN'),
                              )
                            : CircularProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder) => SignUp()));
                                },
                                child: const Text(
                                  'Register Now',
                                  style: TextStyle(color: Colors.lightBlueAccent),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
