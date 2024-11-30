import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipstick/Routes/routes.dart';
import 'package:lipstick/Screens/Product%20Details%20Page/Bloc/productDetails_bloc.dart';
import 'package:lipstick/Screens/Product%20Details%20Page/Models/productDetailsRepository.dart';
import 'package:lipstick/Screens/Product%20Details%20Page/Presentation/productDetailsPage.dart';
import 'package:lipstick/Screens/SplashScreen/splashScreen.dart';
import 'package:lipstick/Service/apiService.dart';
import 'package:flutter_bloc/src/multi_bloc_provider.dart';

class RouteGenerator {
  final productDetailsBloc _productDetailsBloc =
      productDetailsBloc(Productdetailsrepository(ApiService(Dio())));

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.SplashScreen:
        // Route to the Splash screen with NetworkCubit provided
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          // BlocProvider<NetworkCubit>.value(
          //   value: _networkCubit,
          //   child: const SplashScreen(),
          // ),
        );

      case Routes.prouctDetails:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider<productDetailsBloc>.value(
              value: _productDetailsBloc,
            ),
          ], child: const productDetailsPage()),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN ROUTE NAVIGATION '),
        ),
      );
    });
  }
}
