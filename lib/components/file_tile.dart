import 'package:flutter/material.dart';
import '../models/file_data.dart';

class FileTile extends StatelessWidget {
  final FileData fileData;
  final VoidCallback onRecover;

  const FileTile({
    Key? key,
    required this.fileData,
    required this.onRecover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        fileData.type == 'video'
            ? Icons.video_file
            : fileData.type == 'audio'
                ? Icons.audio_file
                : fileData.type == 'image'
                    ? Icons.image
                    : Icons.insert_drive_file,
      ),
      title: Text(fileData.name),
      subtitle: Text(fileData.path),
      trailing: ElevatedButton(
        onPressed: onRecover,
        child: Text("Recover"),
      ),
    );
  }
}
