import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi/logic/create_note/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/note_model.dart';

class CreateNoteCubit extends Cubit <CreateNoteStates> {
  CreateNoteCubit () : super(CreateNoteInitialState());


  /// Function to set note data to firebase by UI ==> noteModel(toJson) ==> Function
    Future createNoteData ({required NoteModel notes}) async {
      emit(CreateNoteLoadingState());
      try {
       await FirebaseFirestore.instance.collection("notes").add(notes.toJson());
       emit(CreateNoteSuccessState());

      }catch (e){
        emit(CreateNoteErrorState(em: e.toString()));
      }
    }
}