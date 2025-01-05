import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<dynamic> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        // Log the error status code and reason
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return null; // Return null to indicate failure
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Exception: $e');
      return null; // Return null to indicate failure
    }
  }
}