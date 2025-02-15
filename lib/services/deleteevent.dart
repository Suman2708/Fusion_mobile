import 'dart:convert';
import 'package:fusion/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:fusion/constants.dart';
import 'package:fusion/services/service_locator.dart';

import '../api.dart';

class DeleteEventService {
  Future<void> sendDeleteEventRequest(List<Map<String, dynamic>> data) async {
    try {
      print(jsonEncode(data));

      var storageService = locator<StorageService>();
      if (storageService.userInDB?.token == null) {
        throw Exception('Token Error');
      }

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${storageService.userInDB?.token ?? ""}',
      };

      http.Response response = await http.post(
        Uri.http(getLink(), kDeleteEventEndpoint),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(jsonEncode(data));
        print("POST request successful");
      } else {
        print(jsonEncode(data));
        print(response.statusCode);
        throw Exception('Failed to send POST request');
      }
    } catch (e) {
      rethrow;
    }
  }
}
