import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_bloc/screens/phone_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Container(
        child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => PhoneAuth()));
              }
            },
            builder: (context, state) {
              return CupertinoButton(
                child: Text("Logout"),
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logOut();
                },
                color: Colors.red,
              );
            },
          ),
        ),
      ),
    );
  }
}
