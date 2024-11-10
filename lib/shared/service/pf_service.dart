import 'package:http/http.dart' as http;
import 'package:unveels/features/product/product_model.dart';
import 'dart:convert';
import 'package:unveels/features/skin_tone_finder/presentation/models/skin_tone_model.dart';
import 'package:unveels/features/skin_tone_finder/presentation/models/tone_type_model.dart';
import 'package:unveels/shared/constant/constant.dart';

class PfService {
  Future<ProductModel> fetchProductData(personalityValue) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl'
              '/rest/V1/products?'
              'searchCriteria[filter_groups][0][filters][0][field]=category_id&'
              'searchCriteria[filter_groups][0][filters][0][value]=457&'
              'searchCriteria[filter_groups][0][filters][0][condition_type]=eq&'
              'searchCriteria[filter_groups][1][filters][0][field]=type_id&'
              'searchCriteria[filter_groups][1][filters][0][value]=simple&'
              'searchCriteria[filter_groups][1][filters][0][condition_type]=eq&'
              'searchCriteria[filter_groups][2][filters][0][field]=personality&'
              'searchCriteria[filter_groups][2][filters][0][value]=${personalityValue}&'
              'searchCriteria[filter_groups][2][filters][0][condition_type]=finset'
      ),
      headers: {"Authorization": "Bearer $apiKey"},
    );
    print('product data111' + response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProductModel.fromJson(data);
    } else {
      throw Exception("Failed to load product data");
    }
  }
}
