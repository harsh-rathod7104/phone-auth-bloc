import 'package:flutter_bloc/flutter_bloc.dart';

class MyState {
  final int field;
  final String otp;
  MyState(this.field, this.otp);
}

class OtpCubit extends Cubit<MyState> {
  OtpCubit() : super(MyState(0, 'intial value'));

  void gotOtp(String otp) {
    emit(MyState(0, otp));
  }
}
