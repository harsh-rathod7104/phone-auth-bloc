import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_bloc/cubit/auth_cubit/otp_cubit.dart';

import 'package:phone_auth_bloc/screens/signin_screen.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => OtpCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: SignInScreen(),
      ),
    );
  }
}
