import 'package:depi/core/utils/colors_manager.dart';
import 'package:depi/logic/login/cubit.dart';
import 'package:depi/logic/login/state.dart';
import 'package:depi/presentation/screens/Login_screen.dart';
import 'package:depi/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginStates>(
  listener: (context, state) {
    if (state is LoginSuccessState){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login is Successful")));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }else if (state is LoginErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.em)));

    }
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Center(
                child: Text(
                  'Login',
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }

                    bool emailValid = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value);
                    if (!emailValid) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.number,
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
              (state is LoginLoadingState)? Center(child: CircularProgressIndicator()) : AppButton(function: (){
               context.read<LoginCubit>().login(email: emailController.text, pass: passwordController.text);
             }, txt: "Continue"),
              SizedBox(height: 32),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xffE1E1E1),
                        thickness: 1.5,
                        indent: 60,
                        endIndent: 14,
                      ),
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                        color: Color(0xffE1E1E1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xffE1E1E1),
                        thickness: 1.5,
                        indent: 16,
                        endIndent: 60,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Color(0xffE1E1E1), width: 1),
                ),
                child: Row(
                  spacing: 7,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/pngwing 1.png'),
                    Text(
                      'Login with Apple',
                      style: TextStyle(
                        color: Color(0xff2A2A2A),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Color(0xffE1E1E1), width: 1),
                ),
                child: Row(
                  spacing: 7,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/pngwing 2.png'),
                    Text(
                      'Login with Google',
                      style: TextStyle(
                        color: Color(0xff2A2A2A),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don’t have an account?',
                          style: TextStyle(
                            color: Color(0xff989898),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' Sign up',
                          style: TextStyle(
                            color: Color(0xff648DDB),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
