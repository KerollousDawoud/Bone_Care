import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/doctor_model.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit() : super(DoctorsInitial());
  static DoctorsCubit get(context) => BlocProvider.of(context);
  List<DoctorModel> doctor = [];
  void getDoctor({required String city}) {
    doctor = [];
    emit(GetDoctor());

    FirebaseFirestore.instance.collection(city).get().then((value) {
      value.docs.forEach((element) {
        doctor.add(DoctorModel.fromJson(element.data()));
        print(doctor[0].image);
        emit(GetDoctor());
      });
    });
  }
}
