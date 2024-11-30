part of 'productDetails_bloc.dart';

@immutable
abstract class productDetailsEvent {}

class Start extends productDetailsEvent {
  Start();
}
