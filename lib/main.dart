import 'package:bloc/bloc.dart';
import 'package:demo_flut/_general_widgets/loading.dart';
import 'package:demo_flut/authentication/bloc/authentication_bloc.dart';
import 'package:demo_flut/authentication/data/user_repository.dart';
import 'package:demo_flut/custom_bloc_delegate.dart';
import 'package:demo_flut/home/home_page.dart';
import 'package:demo_flut/login/login_page.dart';
import 'package:demo_flut/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = CustomBlocDelegate();
  final userRepository = UserRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(userRepository: userRepository)
            ..add(AuthenticationAppStarted());
        },
      ),
    ],
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashPage();
          }
          if (state is AuthenticationSuccess) {
            return HomePage();
          }
          if (state is AuthenticationFailure) {
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationInProgress) {
            return LoadingIndicator();
          }
          return Container();
        },
      ),
    );
  }
}