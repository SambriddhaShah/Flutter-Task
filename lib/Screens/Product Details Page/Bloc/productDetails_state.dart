part of 'productDetails_bloc.dart';

@immutable
abstract class productDetailsState {}

class productDetailsInitial extends productDetailsState {}

class productDetailsLoading extends productDetailsState {}

class productDetailsSuccessful extends productDetailsState {
  final ProductDetailsResponse productDetails;

  productDetailsSuccessful(this.productDetails);
}

class productDetailsError extends productDetailsState {
  final Failure failure;
  productDetailsError({
    required this.failure,
  });
}
