import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kib_currency_converter/features/home/presentation/HomeScreen.dart';
import 'package:kib_currency_converter/features/splash/splash_cubit.dart';
import '../../injectable.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashCubit _splashCubit = getIt<SplashCubit>();

  @override
  void initState() {
    super.initState();
    _splashCubit.checkIfTheUserLoggedInOrNot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => _splashCubit,
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashLoaded) {
              _navigateToMainScreen(context);
            }
          },
          builder: (context, state) {
            if (state is SplashError) {
              return const Center(child: Text('Error!'));
            } else{
            return const _LoadingWidget();
            }
          },
        ),
      ),
    );
  }

  void _navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
          (Route<dynamic> route) => false,
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/splash.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
