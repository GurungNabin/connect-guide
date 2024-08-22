import 'package:connect_me_app/core/network/constant/endpoints.dart';
import 'package:connect_me_app/model/business/business_model.dart';
import 'package:http/http.dart' as http;

class BusinessService {
  Future<BusinessModel> fetchBusinessData() async {
    try {
      final response = await http.post(Uri.parse(Endpoints.businessUrl));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if the response body contains the expected JSON structure
        final businessModel = businessModelFromJson(response.body);
        print('Parsed model: ${businessModel.results}');
        return businessModel;
      } else {
        print('Failed to load business data: ${response.statusCode}');
        throw Exception('Failed to load business data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load business data');
    }
  }
}
