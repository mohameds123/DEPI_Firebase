import 'package:depi/logic/sign_up/cubit.dart';
import 'package:depi/logic/sign_up/states.dart';
import 'package:depi/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SignUpCubit(),
  child: BlocConsumer<SignUpCubit, SignUpStates>(
  listener: (context, state) {
    if (state is SignUpSuccessState){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Account Was Created Successfully")));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }else if (state is SignUpErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.em)));

    }

  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Center(
              child: Text(
                'Sign up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Your Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 50,

              child: TextField(
                controller:emailController ,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                  ),

                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    color: Color(0xffB3B3B3),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 50,

              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                  ),

                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Color(0xffB3B3B3),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forget password?',
                  style: TextStyle(
                    color: Color(0xff648DDB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            InkWell(
              onTap: (){
                context.read<SignUpCubit>().signUp(email: emailController.text, pass: passwordController.text);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xff4E55D7),
                ),
                child:(state is SignUpLoadingState) ? Center(child: CircularProgressIndicator()) : Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  },
),
);
  }
}
