import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestState()) {
    on<LoginEvent>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('token', '12345678');
      emit(state.copyWith(isLoggin: true));
    });
    on<LogoutEvent>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      emit(state.copyWith(isLoggin: false));
    });
  }
}
