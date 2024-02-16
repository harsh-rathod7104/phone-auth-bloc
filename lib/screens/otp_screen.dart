import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/otp_cubit.dart';
import 'package:phone_auth_bloc/screens/home_page.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    )),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.320,
                  child: Image.asset(
                    'assets/image1.png',
                    // fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: height * 0.020,
                ),
                const Text(
                  "Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                const Text(
                  "Enter the OTP send to your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  onCompleted: (value) {
                    BlocProvider.of<OtpCubit>(context).gotOtp(value);
                  },
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return BlocBuilder<OtpCubit, MyState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: width,
                          child: CupertinoButton(
                            borderRadius: BorderRadius.circular(50),
                            minSize: 55,
                            color: Colors.deepPurpleAccent,
                            onPressed: () {
                              log("Go for verification");
                              log(state.otp);
                              BlocProvider.of<AuthCubit>(context)
                                  .verifyOtp(state.otp);
                              log("verifiaction complete");
                            },
                            child: const Text("Verify"),
                          ),
                        );
                      },
                    );
                  },
                  listener: (BuildContext context, AuthState state) {
                    if (state is AuthLoggedInState) {
                      Navigator.popUntil(context, (route) => route.isFirst);

                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const HomeScrren()));
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
      ),
    );
  }
}
