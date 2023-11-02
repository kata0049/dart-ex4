import 'package:async_http_and_json/package_retrieval_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(List<String> arguments) async {
  try {
    final Uri url =
        Uri.parse('https://random-data-api.com/api/v2/users?size=10');

    final http.Response packageResponse = await http.get(url);

    if (packageResponse.statusCode != 200) {
      throw PackageRetrievalException(
        statusCode: packageResponse.statusCode,
      );
    }

    List<Map<String, String>> decodeData() {
      List<dynamic> decodedJson = jsonDecode(packageResponse.body);

      List<Map<String, dynamic>> decodedJsonMaps =
          List<Map<String, dynamic>>.from(decodedJson);

      List<Map<String, String>> data = [];

      for (final dynamicMap in decodedJsonMaps) {
        // create a new Map where the values are Strings
        Map<String, String> convertedMap =
            dynamicMap.map((key, value) => MapEntry(key, value.toString()));

        // save Map<String, String> inside the List data
        data.add(convertedMap);
      }
      return data;
    }

    void output(List<Map<String, String>> data) {
      for (var user in data) {
        String? uid = user["uid"];
        String? firstName = user["first_name"];
        String? lastName = user["last_name"];
        print("Hello, ${firstName} ${lastName}. Your uid is: ${uid}.");
      }
    }

    output(decodeData());
  } catch (e) {
    print(e);
  }
}
