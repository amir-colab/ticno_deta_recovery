import 'package:flutter/material.dart';
import '../services/file_recovery_service.dart';
import '../models/file_data.dart';
import '../components/file_tile.dart';

class RecoverScreen extends StatefulWidget {
  @override
  _RecoverScreenState createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  final FileRecoveryService _fileRecoveryService = FileRecoveryService();
  List<FileData> files = [];
  bool isLoading = false;

  Future<void> recoverFiles(String type) async {
    setState(() {
      isLoading = true;
    });

    try {
      final fileList = await _fileRecoveryService.getDeletedFiles(type);
      setState(() {
        files = fileList.map((file) => FileData.fromJson(file)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recover Files")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => recoverFiles("video"),
                child: Text("Videos"),
              ),
              ElevatedButton(
                onPressed: () => recoverFiles("audio"),
                child: Text("Audios"),
              ),
              ElevatedButton(
                onPressed: () => recoverFiles("image"),
                child: Text("Pictures"),
              ),
              ElevatedButton(
                onPressed: () => recoverFiles("document"),
                child: Text("Documents"),
              ),
            ],
          ),
          isLoading ? CircularProgressIndicator() : Container(),
          Expanded(
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return FileTile(
                  fileData: file,
                  onRecover: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${file.name} recovered!")),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
