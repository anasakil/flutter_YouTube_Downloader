import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/download_request.dart';

class DownloaderViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _statusMessage = '';

  bool get isLoading => _isLoading;
  String get statusMessage => _statusMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> downloadVideo(DownloadRequest request) async {
    setLoading(true);
    final url = 'http://127.0.0.1:5000/download';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      final data = jsonDecode(response.body);
      _statusMessage = response.statusCode == 200 ? data['message'] : data['error'];
    } catch (e) {
      _statusMessage = 'Error: $e';
    } finally {
      setLoading(false);
    }
  }
}
