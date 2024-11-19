part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {}

class SplashError extends SplashState {
  final String errorMessage;

  SplashError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
