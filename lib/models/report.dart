class Report {
  final String fileName;
  final DateTime timeOfUpload;
  final String url;

  Report({
    required this.fileName,
    required this.timeOfUpload,
    required this.url,
  });

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      fileName: map['fileName'] ?? 'New File',
      timeOfUpload: DateTime.parse(map['timeOfUpload']),
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'timeOfUpload': timeOfUpload.toIso8601String(),
      'url': url,
    };
  }
}
