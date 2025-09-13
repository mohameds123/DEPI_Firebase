import 'dart:io';

import 'package:depi/core/utils/colors_manager.dart';
import 'package:depi/data/note_model.dart';
import 'package:depi/logic/create_note/cubit.dart';
import 'package:depi/logic/create_note/state.dart';
import 'package:depi/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';

class CreateNote extends StatefulWidget {
  CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController headlineController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

XFile ? selectedMedia;

  Future selectMediaGallery () async {
    ImagePicker picker = ImagePicker();
    selectedMedia = await picker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
  }

  Future selectMediaCamera () async {
    ImagePicker picker = ImagePicker();
    selectedMedia = await picker.pickImage(source: ImageSource.camera);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CreateNoteCubit(),
  child: BlocConsumer<CreateNoteCubit, CreateNoteStates>(
  listener: (context, state) {
    if(state is CreateNoteSuccessState){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Note Was Creates Successfully")));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }else if (state is CreateNoteErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong, please try again !")));

    }

  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text(
                'Create New Note ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 17),
              Text(
                'Head line',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              SizedBox(
                height: 50,
                child: TextField(
                  controller: headlineController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                    ),

                    hintText: 'Enter Note Address',
                    hintStyle: TextStyle(
                      color: Color(0xffB3B3B3),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 17),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              SizedBox(
                height: 190,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                    ),

                    hintText: 'Enter Your Description',
                    hintStyle: TextStyle(
                      color: Color(0xffB3B3B3),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              //Spacer(),
              SizedBox(height: 10),
             selectedMedia != null? Image.file(File(selectedMedia!.path)):SizedBox(height: 10),
              selectedMedia != null ? SizedBox(height: 10,) : SizedBox(height: 0,),

              InkWell(
                onTap: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      content: Container(
                        height: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(

                              child: Container(
                                width: 160,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: ColorsManager.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("Camera",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                selectMediaCamera();
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            InkWell(

                              child: Container(
                                width: 160,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: ColorsManager.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("Gallery",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                selectMediaGallery();
                                Navigator.pop(context);

                              },
                            ),

                          ],
                        ),
                      ),
                    );
                  });

                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ColorsManager.primary,
                  ),
                  child: Text(
                    'Select Media',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              (state is CreateNoteLoadingState) ? Center(child: CircularProgressIndicator()) : AppButton(function: (){
                context.read<CreateNoteCubit>().createNoteData(notes: NoteModel(
                    description: descriptionController.text,
                    headline: headlineController.text,
                    postTime: DateTime.now()));
              }, txt: "Create")
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}
