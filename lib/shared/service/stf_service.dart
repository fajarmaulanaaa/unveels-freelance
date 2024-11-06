import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:unveels/features/skin_tone_finder/presentation/models/skin_tone_model.dart';
import 'package:unveels/shared/constant/constant.dart';

class StfService {
  Future<SkinToneModel> fetchSkinToneData() async {
    final response = await http.get(Uri.parse('$baseUrl/en/rest/V1/products/attributes/tone_type'), headers: {
        "Authorization": "Bearer $apiKey"
      });
      print('ini bodyyy');
      print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SkinToneModel.fromJson(data);
    } else {
      throw Exception("Failed to load skin tone data");
    }
  }
}
