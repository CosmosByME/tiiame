import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tiiame/config.dart';

class DriveStorageService {
  static const _url    = 'https://script.google.com/macros/s/AKfycbzq6_9WPAueYIkkJBYgFE5-gVeBC6K0jkPHWPYkULBIQ_zUKCIGcZZgsi5xvqeuJK2hcg/exec';
  static const _secret =  secret;

  /// Upload any file to a named folder
  // Instead of http.post with JSON body, use this:
static Future<String?> uploadFile({
  required String folder,
  required String fileName,
  required Uint8List bytes,
  required String mimeType,
}) async {
  try {
  final base64Data = base64Encode(bytes);
  
  // Send as plain text to avoid CORS preflight
  final res = await http.post(
    Uri.parse(_url),
    headers: {
      'Content-Type': 'text/plain', // ✅ avoids CORS preflight
    },
    body: jsonEncode({
      'token':    _secret,
      'folder':   folder,
      'fileName': fileName,
      'mimeType': mimeType,
      'base64':   base64Data,
    }),
  );
  
    debugPrint('Response status: ${res.statusCode}'); // ✅ add
    debugPrint('Response body: ${res.body}'); 
  
  final body = jsonDecode(res.body);
  return body['url'];
}  catch (e) {
  debugPrint('❌ DriveStorageService error: $e');
}
}

  /// List all files in a folder
  static Future<List<Map<String, dynamic>>> listFiles(String folder) async {
    final res = await http.get(
      Uri.parse('$_url?token=$_secret&folder=$folder'),
    );
    final body = jsonDecode(res.body);
    return List<Map<String, dynamic>>.from(body['files'] ?? []);
  }
}