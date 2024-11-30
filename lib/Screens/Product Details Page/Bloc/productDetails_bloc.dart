import 'package:lipstick/Screens/Product%20Details%20Page/Models/productDetailsRepository.dart';
import 'package:lipstick/Screens/Product%20Details%20Page/Models/productDetailsResponse.dart';
import 'package:lipstick/constants/errors.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
part 'productDetails_event.dart';
part 'productDetails_state.dart';

class productDetailsBloc
    extends Bloc<productDetailsEvent, productDetailsState> {
  Productdetailsrepository productDetailsRepository;

  productDetailsBloc(this.productDetailsRepository)
      : super(productDetailsInitial()) {
    on<productDetailsEvent>((event, emit) async {
      if (event is Start) {
        print('the event is triggred');
        try {
          emit(productDetailsLoading());

          final productDetailsResponse =
              await productDetailsRepository.productDetails();

          emit(productDetailsSuccessful(productDetailsResponse));
        } catch (err) {
          print('error Occured ${err.toString()}');
          emit(productDetailsError(
              failure: const CommonFailure('Fill all the fields')));
          rethrow;
        }
      }
    });
  }
}
