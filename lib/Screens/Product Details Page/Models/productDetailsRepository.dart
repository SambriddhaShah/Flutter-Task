import 'package:lipstick/Screens/Product%20Details%20Page/Models/productDetailsResponse.dart';
import 'package:lipstick/Service/apiService.dart';

class Productdetailsrepository {
  final ApiService apiService;

  Productdetailsrepository(this.apiService);

  // Perform user login authentication.
  Future<ProductDetailsResponse> productDetails() async {
    var response = await apiService.productDetails();

    ProductDetailsResponse productResposne =
        ProductDetailsResponse.fromJson(response!.data);
    return productResposne;
  }
}
