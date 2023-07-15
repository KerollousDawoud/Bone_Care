import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dopproject/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  var name;
  var email;
  var age;
  var height;
  var weight;
  File? imageProfilee;
  String? img;
  void imageProfile(context) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      imageProfilee = File(value!.path);
      FirebaseStorage.instance.ref().child('user/profile/$uId}').putFile(imageProfilee!).then((p0) {
        p0.ref.getDownloadURL().then((value) {
          img = value.toString();
          image = img.toString();
          emit(Users());
          FirebaseFirestore.instance.collection('user').doc(uId).update({'image': value.toString()}).then((value) {});
        });
      });
    });
  }

  void Profile() {
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      name = value.data()!['name'];
      email = value.data()!['email'];
      age = value.data()!['age'];
      height = value.data()!['height'];
      weight = value.data()!['weight'];
      img = value.data()!['image'];
      image = img.toString();
    }).then((value) {
      emit(Users());
      print(img);
      print('image');
    });
  }
}
