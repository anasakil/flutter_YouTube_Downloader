class DownloadRequest {
  final String url;
  final String quality;
  final String format;
  final String folderPath;

  DownloadRequest({
    required this.url,
    required this.quality,
    required this.format,
    required this.folderPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'quality': quality,
      'format': format,
      'folder_path': folderPath,
    };
  }
}
