import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_bloc/screens/otp_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.020),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.320,
                child: Image.asset(
                  'assets/image2.png',
                  // fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: height * 0.020,
              ),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              const Text(
                "Add your phone number. We'll send you a verification code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: height * 0.030,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                decoration: InputDecoration(
                    hintText: "Enter a Phone Number",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 2))),
              ),
              SizedBox(
                height: height * 0.030,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                builder: (BuildContext context, state) {
                  if (state is AuthLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  return SizedBox(
                    width: width,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(50),
                      minSize: 55,
                      color: Colors.deepPurpleAccent,
                      onPressed: () {
                        String phoneNumber =
                            "+91" + phoneNumberController.text.trim();
                        BlocProvider.of<AuthCubit>(context)
                            .sendOtp(phoneNumber);
                      },
                      child: Text("Login"),
                    ),
                  );
                },
                listener: (BuildContext context, Object? state) {
                  if (state is AuthCodeSendState) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => OtpScreen()));
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
