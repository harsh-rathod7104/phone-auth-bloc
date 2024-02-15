import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_bloc/screens/home_screen.dart';

class OtpScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();
  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Otp Screen")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextField(
            controller: otpController,
            decoration: const InputDecoration(
              hintText: "Enter Code",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (BuildContext context, AuthState state) {
              if (state is AuthLoggedInState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => HomeScreen()));
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (BuildContext context, AuthState state) {
              if (state is AuthLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Colors.pink,
                  child: Text("Verify"),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context)
                        .verifyOtp(otpController.text);
                  },
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
