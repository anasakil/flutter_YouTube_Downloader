import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/downloader_screen.dart';
import 'viewmodels/downloader_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DownloaderViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Downloader',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DownloaderScreen(),
    );
  }
}
