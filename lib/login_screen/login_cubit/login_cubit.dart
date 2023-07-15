import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dopproject/layout/layout.dart';
import 'package:dopproject/shared/cacheHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isloading = false;
  bool obscure = true;

  void login({
    required String email,
    required String password,
    required context,
  }) {
    isloading = true;
    emit(Isloading());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) async {
      uId = value.user!.uid;
      await CacheHelper.setData(key: 'login', value: 'user');
      await CacheHelper.setData(key: 'uId', value: uId);
      FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
        image = value.data()!['image'];
        emit(Users());
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const HomeLayout()));
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
