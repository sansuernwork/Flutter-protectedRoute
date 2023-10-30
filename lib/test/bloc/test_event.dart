part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

class LoginEvent extends TestEvent {}

class LogoutEvent extends TestEvent {}
