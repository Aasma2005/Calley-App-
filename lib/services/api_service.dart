import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://mock-api.calleyacd.com/api';

  // Get all lists for a user
  static Future<List<dynamic>> getLists(String userId, String email) async {
    final url = Uri.parse('$baseUrl/list?userId=$userId');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return [data]; // API seems to return a single object, so wrap in a list
    } else {
      throw Exception('Failed to load lists');
    }
  }

  
  static Future<Map<String, dynamic>> getListDetails(
      String listId, String email) async {
    final url = Uri.parse('$baseUrl/list/$listId');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch list details');
    }
  }
}
