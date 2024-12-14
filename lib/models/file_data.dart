class FileData {
  final String name;   // File name
  final String path;   // File path
  final String type;   // File type (e.g., video, audio)
  final int size;      // File size in bytes

  FileData({
    required this.name,
    required this.path,
    required this.type,
    required this.size,
  });

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      name: json['name'],
      path: json['path'],
      type: json['type'],
      size: json['size'],
    );
  }
}
