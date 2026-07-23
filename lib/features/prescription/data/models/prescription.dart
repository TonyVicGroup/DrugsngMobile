class Prescription {
  static const String _idKey = "id";
  // static const String _userIdKey = "userId";
  static const String _fileNameKey = "fileName";
  static const String _createdDateKey = "dateCreated";
  static const String _urlKey = "url";
  static const String _sizeKey = "size";

  final int id;
  final DateTime createdDate;
  // final int userId;
  final String fileName;
  final String? url;
  final String size;

  Prescription({
    required this.id,
    required this.createdDate,
    // required this.userId,
    required this.fileName,
    required this.size,
    this.url,
  });

  factory Prescription.fromJson(Map json) {
    return Prescription(
      id: json[_idKey],
      // userId: json[_userIdKey],
      createdDate: DateTime.parse(json[_createdDateKey]),
      fileName: json[_fileNameKey],
      url: json[_urlKey],
      size: json[_sizeKey],
    );
  }
}
