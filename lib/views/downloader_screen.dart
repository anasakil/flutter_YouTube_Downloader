import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/download_request.dart';
import '../viewmodels/downloader_view_model.dart';

class DownloaderScreen extends StatefulWidget {
  @override
  _DownloaderScreenState createState() => _DownloaderScreenState();
}

class _DownloaderScreenState extends State<DownloaderScreen> {
  final _urlController = TextEditingController();
  String _quality = '720p';
  String _format = 'mp4';
  String _folderPath = '/downloads';

  @override
  Widget build(BuildContext context) {
    final downloaderViewModel = Provider.of<DownloaderViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('YouTube Downloader')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'YouTube URL'),
            ),
            DropdownButtonFormField<String>(
              value: _quality,
              items: ['720p', '480p', '360p'].map((quality) {
                return DropdownMenuItem(value: quality, child: Text(quality));
              }).toList(),
              onChanged: (value) => setState(() => _quality = value!),
              decoration: InputDecoration(labelText: 'Quality'),
            ),
            DropdownButtonFormField<String>(
              value: _format,
              items: ['mp4', 'mp3'].map((format) {
                return DropdownMenuItem(value: format, child: Text(format));
              }).toList(),
              onChanged: (value) => setState(() => _format = value!),
              decoration: InputDecoration(labelText: 'Format'),
            ),
            TextField(
              onChanged: (value) => _folderPath = value,
              decoration: InputDecoration(labelText: 'Folder Path'),
            ),
            SizedBox(height: 20),
            downloaderViewModel.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      final request = DownloadRequest(
                        url: _urlController.text,
                        quality: _quality,
                        format: _format,
                        folderPath: _folderPath,
                      );

                      downloaderViewModel.downloadVideo(request);
                    },
                    child: Text('Download'),
                  ),
            if (downloaderViewModel.statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(downloaderViewModel.statusMessage),
              ),
          ],
        ),
      ),
    );
  }
}
