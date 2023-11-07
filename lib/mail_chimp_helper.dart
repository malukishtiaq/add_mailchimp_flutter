import 'dart:convert';
import 'package:http/http.dart' as http;

class MailChimpHelper {
  // The API Key should be kept confidential. Use environment variables or a secrets manager.
  final apiKey =
      'YOUR_API_KEY'; // Replace with environment variable or secure storage
  final audienceId =
      'YOUR_AUDIENCE_ID'; // Replace with environment variable or secure storage

  Future<void> addSubscriber(dynamic userData) async {
    final url = 'https://us13.api.mailchimp.com/3.0/lists/$audienceId/members';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode('anystring:$apiKey'.codeUnits)}',
      },
      body: jsonEncode(
        {
          'email_address': userData['Email'],
          'status': 'subscribed',
          "merge_fields": {
            "FNAME": userData['FirstName'],
            "LNAME": userData['LastName'],
            "PHONE": userData['Phone'],
            "GENDER": userData['SexMaleFemale'],
            "LATITUDE": userData['LocationLatitude'],
            "LONGITUDE": userData['LocationLongitude'],
          },
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Subscriber added successfully.');
    } else {
      print('Failed to add subscriber: ${response.reasonPhrase}');
    }
  }

  Future<void> subscribeUserToMailchimp(String email) async {
    final url = Uri.parse(
        'https://us13.api.mailchimp.com/3.0/lists/$audienceId/members');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $apiKey',
    };

    final data = {
      'email_address': email,
      'status': 'subscribed',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print('User subscribed to Mailchimp successfully');
    } else {
      print(
          'Failed to subscribe user to Mailchimp. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }
}
