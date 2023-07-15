// ignore_for_file: must_be_immutable

import 'package:dopproject/register_screen/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  String gender = '';
  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Register Now',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: userName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: 'User Name',
                              labelStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlueAccent,
                                fontStyle: FontStyle.italic,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.lightBlueAccent,
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              labelText: 'E-Mail',
                              labelStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),
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
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),
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
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: age,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  labelText: 'Age',
                                  labelStyle: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),
                                  prefixIcon: const Icon(Icons.date_range_outlined, color: Colors.lightBlueAccent),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 60,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: DropdownButton<Widget>(
                                    dropdownColor: Colors.blue,
                                    alignment: Alignment.center,
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    value: cubit.value,
                                    items: cubit.specialties,
                                    hint: const Center(
                                        child: Text(style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), "Gender")),
                                    icon: const Icon(
                                      Icons.expand_more,
                                      color: Colors.white,
                                    ),
                                    onChanged: (value) {
                                      debugPrint((value as Text).data);
                                      cubit.changeValue(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: weight,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  labelText: 'weight',
                                  labelStyle: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),
                                  prefixIcon: const Icon(Icons.arrow_right_alt, color: Colors.lightBlueAccent),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: height,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  labelText: 'height',
                                  labelStyle: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),
                                  prefixIcon: const Icon(Icons.height, color: Colors.lightBlueAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        cubit.isloading == false
                            ? ElevatedButton(
                                onPressed: () {
                                  cubit.signUp(
                                    context: context,
                                    email: email.text,
                                    password: password.text,
                                    name: userName.text,
                                    age: age.text,
                                    gender: gender,
                                    weight: weight.text,
                                    height: height.text,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlueAccent,
                                    elevation: 10.0,
                                    textStyle:
                                        const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                                child: const Text('Create an account'),
                              )
                            : CircularProgressIndicator(),
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
