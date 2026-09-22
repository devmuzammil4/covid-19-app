import 'dart:convert';
import 'package:http/http.dart' as http;

class StatesServices {

  // 1. World States ka data lene ke liye (Pehle se mojood)
  Future fetchWorldStatesRecords() async {
    try {
      final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception('Internet ka masla hai, apna connection check karein!');
    }
  }

  // 2. Saare countries ki list lene ke liye (Naya function)
  Future<List<dynamic>> countriesListApi() async {
    try {
      final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Error fetching countries data");
      }
    } catch (e) {
      throw Exception('Internet ka masla hai, apna connection check karein!');
    }
  }
}