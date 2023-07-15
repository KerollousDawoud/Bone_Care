import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dopproject/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/history_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  static HistoryCubit get(context) => BlocProvider.of(context);
  List<HistoryModel> history = [];
  void getHistory() {
    history = [];
    FirebaseFirestore.instance.collection('user').doc(uId).collection('history').get().then((value) {
      value.docs.forEach((element) {
        history.add(HistoryModel.fromJson(element.data()));
        emit(GetHistory());
      });
      emit(GetHistory());
    });
  }

  void deleteHistory({required String id}) {
    FirebaseFirestore.instance.collection('user').doc(uId).collection('history').doc(id).delete().then((value) {
      getHistory();
    });
  }
}
