part of 'test_bloc.dart';

@immutable
class TestState extends Equatable {
  final bool isLoggin;

  const TestState({this.isLoggin = false});

  TestState copyWith({bool? isLoggin}) {
    return TestState(isLoggin: isLoggin ?? this.isLoggin);
  }

  @override
  List<Object?> get props => [isLoggin];
}
