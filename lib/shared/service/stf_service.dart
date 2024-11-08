import 'package:http/http.dart' as http;
import 'package:unveels/features/skin_tone_finder/presentation/models/product_model.dart';
import 'dart:convert';
import 'package:unveels/features/skin_tone_finder/presentation/models/skin_tone_model.dart';
import 'package:unveels/features/skin_tone_finder/presentation/models/tone_type_model.dart';
import 'package:unveels/shared/constant/constant.dart';

class StfService {
  Future<SkinToneModel> fetchSkinToneData() async {
    final response = await http.get(
        Uri.parse('$baseUrl/en/rest/V1/products/attributes/tone_type'),
        headers: {"Authorization": "Bearer $apiKey"});
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SkinToneModel.fromJson(data);
    } else {
      throw Exception("Failed to load skin tone data");
    }
  }

  Future<ToneTypeModel> fetchToneType() async {
    final response = await http.get(
        Uri.parse('$baseUrl/en/rest/V1/products/attributes/skin_tone'),
        headers: {"Authorization": "Bearer $apiKey"});
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ToneTypeModel.fromJson(data);
    } else {
      throw Exception("Failed to load skin tone data");
    }
  }

  Future<ProductModel> fetchProductData(toneType, skinTone) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=451&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=simple&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[filter_groups][2][filters][0][field]=skin_tone&searchCriteria[filter_groups][2][filters][0][value]=${skinTone}&searchCriteria[filter_groups][2][filters][0][condition_type]=eq&searchCriteria[filter_groups][3][filters][0][field]=tone_type&searchCriteria[filter_groups][3][filters][0][value]=${toneType}&searchCriteria[filter_groups][3][filters][0][condition_type]=finset'),
      headers: {"Authorization": "Bearer $apiKey"},
    );
    print('bisaa');
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProductModel.fromJson(data);
    } else {
      throw Exception("Failed to load product data");
    }
  }
}
