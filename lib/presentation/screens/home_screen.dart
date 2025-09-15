import 'package:depi/logic/get_notes/cubit.dart';
import 'package:depi/logic/get_notes/state.dart';
import 'package:depi/presentation/screens/Login_screen.dart';
import 'package:depi/presentation/screens/create_note.dart';
import 'package:depi/presentation/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetNotesCubit()..getNotes(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateNote()),
                      );
                    },
                    txt: "Add Note",
                    buttonWidth: 164,
                  ),
                  AppButton(
                    function: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    txt: "Log Out",
                    buttonWidth: 164,
                  ),
                ],
              ),
              SizedBox(height: 16),

              BlocBuilder<GetNotesCubit, GetNoteStates>(
                builder: (context, state) {
                  if (state is GetNoteLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetNoteSuccessState) {
                    return SizedBox(
                      height: 370,
                      child: ListView.builder(
                        itemCount: state.notes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              height: 80,
                              width: 390,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.notes[index].headline),
                                    SizedBox(height: 8),
                                    state.notes[index].mediaLink!= null ? Image.network(state.notes[index].mediaLink!) : SizedBox(),
                                    Row(
                                      children: [
                                        Text(
                                          state.notes[index].description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${state.notes[index].postTime.hour}:${state.notes[index].postTime.minute}${state.notes[index].postTime.hour >= 12 ? "PM" : "AM"}"
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is GetNoteErrorState) {
                    return Center(child: Text(state.em));
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
