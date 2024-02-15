import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_bloc/screens/home_screen.dart';
import 'package:phone_auth_bloc/screens/phone_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyB8PSjlMxI7MhYFk808jHmbBl2ONro05wk",
          appId: "1:438277576824:android:eb786efcc5ed016df7358d",
          messagingSenderId: "438277576824",
          projectId: "phone-auth-bloc-4b550",
        ))
      : await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
          theme: ThemeData(useMaterial3: false),
          home: BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) {
              return previous is AuthInitialState;
            },
            builder: (BuildContext context, state) {
              if (state is AuthLoggedInState) {
                return HomeScreen();
              } else if (state is AuthLoggedOutState) {
                return PhoneAuth();
              } else {
                return Scaffold();
              }
            },
          )),
    );
  }
}
