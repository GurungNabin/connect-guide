import 'package:connect_me_app/core/network/constant/endpoints.dart';
import 'package:connect_me_app/model/business/business_model.dart';
import 'package:http/http.dart' as http;
// Replace with the path to your model file

class BusinessService {
  // final String baseUrl;

  // BusinessService(this.baseUrl);

  Future<BusinessModel> fetchBusinessData() async {
    final response = await http.get(Uri.parse(Endpoints.businessUrl));

    if (response.statusCode == 200) {
      return businessModelFromJson(response.body);
    } else {
      throw Exception('Failed to load business data');
    }
  }
}
