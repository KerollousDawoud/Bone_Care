import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../login_screen/Login.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isloading = false;
  bool obscure = true;
  Widget? value;
  final List<DropdownMenuItem<Widget>>? specialties = [
    const DropdownMenuItem(
      value: Text(
        'Male',
        style: TextStyle(fontSize: 20.0, color: Colors.black54),
      ),
      child: Center(
        child: Text(
          'Male',
          style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: Text(
        'Female',
        style: TextStyle(fontSize: 20.0, color: Colors.black54),
      ),
      child: Center(
        child: Text(
          'Female',
          style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ];
  void changeValue(Widget? value) {
    this.value = value;
    emit(SpecialtiesChangeValue());
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    required String age,
    required String gender,
    required String weight,
    required String height,
    required context,
  }) {
    isloading = true;
    emit(Isloading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      FirebaseFirestore.instance.collection('user').doc(value.user!.uid).set({
        'id': value.user!.uid.toString(),
        'name': name,
        'email': email,
        'age': age,
        'gender': gender,
        'weight': weight,
        'height': height,
        'image': 'https://cdn-icons-png.flaticon.com/512/2815/2815428.png'
      }).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => Login()));
      });
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.lightBlueAccent,
          textColor: Colors.white,
          fontSize: 18.0);
      isloading = false;
      emit(Isloading());
    });
  }

  changeObscure() {
    obscure = !obscure;
    emit(ChangeObscureSuccessfuly());
  }
}
