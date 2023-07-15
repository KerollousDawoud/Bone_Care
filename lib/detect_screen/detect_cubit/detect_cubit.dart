import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite/tflite.dart';

part 'detect_state.dart';

class DetectCubit extends Cubit<DetectState> {
  DetectCubit() : super(DetectInitial());

  static DetectCubit get(context) => BlocProvider.of(context);
  bool loading = false;
  List? outputs;
  TextEditingController notes = TextEditingController();

  Future<void> loadModel() async {
    loading = true;
    await Tflite.loadModel(
      model: 'assets/ai_model/model_unquant.tflite',
      labels: 'assets/ai_model/labels.txt',
    ).then((value) {
      emit(LoadModelSuccess());
    }).catchError((onError) {
      debugPrint('load error');
      debugPrint(onError.toString());
      emit(LoadModelError());
    });
  }

  classifyLungImage(File image) async {
    await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    ).then((value) {
      debugPrint(value.toString());
      loading = false;
      outputs = value;
      // Tflite.close();
      emit(ClassifyLungSuccess());
    }).catchError((onError) {
      debugPrint('error classify');
      debugPrint(onError.toString());
      // Tflite.close();
      emit(ClassifyLungError());
    });
    // Tflite.close();
  }
}
