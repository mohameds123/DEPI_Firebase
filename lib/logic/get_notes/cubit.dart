import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi/logic/get_notes/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/note_model.dart';

class GetNotesCubit extends Cubit <GetNoteStates> {
  GetNotesCubit () :super (GetNoteInitialState());


  ///
  Future getNotes () async {
    emit(GetNoteLoadingState());
    try{
      final response = await FirebaseFirestore.instance.collection("notes").get();
      //1- save to model
      //2- toList();
      final x = response.docs
          .map((doc) => NoteModel.fromJson(doc.data())).toList();
      emit(GetNoteSuccessState(notes: x));

    }catch (e){
      emit(GetNoteErrorState(em: e.toString()));
    }
  }
}