import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendService {

  static const String baseUrl = 'http://10.0.2.2:8080/api';

  static Future<void> registerToken(String token) async {

    final response = await http.post(
      Uri.parse('$baseUrl/tokens'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': 1,
        'token': token,
        'platform': 'android',
      }),
    );

    print('REGISTER TOKEN STATUS: ${response.statusCode}');
    print('REGISTER TOKEN BODY: ${response.body}');
  }

  static Future<void> deleteToken(String token) async {

    final response = await http.delete(
      Uri.parse('$baseUrl/tokens/$token'),
    );

    print('DELETE TOKEN STATUS: ${response.statusCode}');
  }
  
}