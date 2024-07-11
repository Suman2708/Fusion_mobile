// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:fusion/api.dart'; // Import if needed
// import 'package:fusion/services/storage_service.dart'; // Import if needed
// import 'package:fusion/constants.dart'; // Import if needed
// import 'package:fusion/services/service_locator.dart'; // Import if needed

// class NewEventCreate {
//   Future<void> createNewEvent({
//     required String eventName,
//     required String inCharge,
//     required String date,
//     required String venue,
//     required String startTime,
//     required String endTime,
//     required String details,
//     // required String event_poster,
//   }) async {
//     try {
//       print('Creating new event...');
//       var storageService = locator<StorageService>();
//       if (storageService.userInDB?.token == null) {
//         throw Exception('Token Error');
//       }

//       Map<String, String> headers = {
//         'Authorization': 'Token ' + (storageService.userInDB?.token ?? ""),
//         'Content-Type': 'application/json',
//       };

//       Map<String, dynamic> body = {
//         'event_name': eventName,
//         'incharge': inCharge,
//         'date': date,
//         'venue': venue,
//         'start_time': startTime,
//         'end_time': endTime,
//         'details': details,
//         // 'event_poster':event_poster,
//       };

//       http.Response response = await http.post(
//         Uri.http(
//           getLink(),
//           kNewEventCreatePath, // Replace with the correct path for creating a new event
//         ),
//         headers: headers,
//         body: jsonEncode(body),
//       );
//       // print(event_poster);

//       print('Response status code: ${response.statusCode}');
//       if (response.statusCode == 201) {
//         print("New event created successfully");
//       } else {
//         print("Failed to create new event: ${response.body}");
//         throw Exception('Failed to create new event');
//       }
//     } catch (e) {
//       print('Error: $e');
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fusion/api.dart'; // Import if needed
import 'package:fusion/services/storage_service.dart'; // Import if needed
import 'package:fusion/constants.dart'; // Import if needed
import 'package:fusion/services/service_locator.dart'; // Import if needed
import 'package:path/path.dart'; // Import for basename function

class NewEventCreate {
  Future<void> createNewEvent({
    required String eventName,
    required String inCharge,
    required String date,
    required String venue,
    required String startTime,
    required String endTime,
    required String details,
    required File? eventPoster, // Make eventPoster optional
  }) async {
    try {
      print('Creating new event...');
      var storageService = locator<StorageService>();
      if (storageService.userInDB?.token == null) {
        throw Exception('Token Error');
      }

      String? eventPosterUrl; // Variable to hold event poster URL

      // Upload event poster if provided
      if (eventPoster != null) {
        eventPosterUrl = await _uploadEventPoster(eventPoster);
      }

      Map<String, String> headers = {
        'Authorization': 'Token ' + (storageService.userInDB?.token ?? ""),
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> body = {
        'event_name': eventName,
        'incharge': inCharge,
        'date': date,
        'venue': venue,
        'start_time': startTime,
        'end_time': endTime,
        'details': details,
        'event_poster': eventPosterUrl, // Include event poster URL in the body
      };

      http.Response response = await http.post(
        Uri.http(
          getLink(),
          kNewEventCreatePath, // Replace with the correct path for creating a new event
        ),
        headers: headers,
        body: jsonEncode(body),
      );

      print(response);

      print('Response status code: ${response.statusCode}');
      if (response.statusCode == 201) {
        print("New event created successfully");
      } else {
        print("Failed to create new event: ${response.body}");
        throw Exception('Failed to create new event');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<String> _uploadEventPoster(File eventPoster) async {
    try {
      // Prepare the request headers for file upload
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };

      // Prepare the request body for file upload
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:8000/gymkhana/api/new_event/'), // Replace with your upload endpoint
      );

      // Attach the event poster file to the request
      request.files.add(
        await http.MultipartFile.fromPath('file', eventPoster.path,
            filename: basename(eventPoster.path)),
      );

      // Send the request and await the response
      http.StreamedResponse response = await request.send();

      // Check the response status code
      if (response.statusCode == 200) {
        print("Event poster uploaded successfully"); // Logging message

        // Read the response body and extract the URL
        String eventPosterUrl = await response.stream.bytesToString();
        return eventPosterUrl;
      } else {
        // If the response indicates an error, throw an exception
        throw Exception(
            'Failed to upload event poster: ${response.statusCode}');
      }
    } catch (e) {
      // Rethrow any caught exceptions
      rethrow;
    }
  }
}

//   Future<String> _uploadEventPoster(String eventPoster) async {
//     try {
//       // Prepare the request headers for file upload
//       Map<String, String> headers = {
//         'Content-Type': 'multipart/form-data',
//       };

//       // Prepare the request body for file upload
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//             'https://example.com/upload'), // Replace with your upload endpoint
//       );

//       // Attach the event poster file to the request
//       request.files.add(
//         await http.MultipartFile.fromPath('file', eventPoster),
//       );

//       // Send the request and await the response
//       http.StreamedResponse response = await request.send();

//       // Check the response status code
//       if (response.statusCode == 200) {
//         print("Event poster uploaded successfully"); // Logging message

//         // Read the response body and extract the URL
//         String eventPosterUrl = await response.stream.bytesToString();
//         return eventPosterUrl;
//       } else {
//         // If the response indicates an error, throw an exception
//         throw Exception(
//             'Failed to upload event poster: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Rethrow any caught exceptions
//       rethrow;
//     }
//   }
// }
