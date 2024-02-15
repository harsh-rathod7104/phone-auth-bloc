import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_bloc/screens/otp_screen.dart';

class PhoneAuth extends StatelessWidget {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextField(
            controller: phoneNumberController,
            decoration: const InputDecoration(
              hintText: "Enter 1-digit Phone number",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            builder: (BuildContext context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Colors.pink,
                  child: Text("Submit"),
                  onPressed: () {
                    String phoneNumber =
                        "+91" + phoneNumberController.text.toString();
                    BlocProvider.of<AuthCubit>(context).sendOtp(phoneNumber);
                  },
                ),
              );
            },
            listener: (BuildContext context, state) {
              if (state is AuthCodeSentState) {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => OtpScreen()));
              }
            },
          )
        ]),
      ),
    );
  }
}
