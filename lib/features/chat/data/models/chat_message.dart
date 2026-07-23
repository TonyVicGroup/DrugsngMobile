import 'dart:convert';

import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum ChatType {
  image,
  text,
  localText,
  localFile;

  bool get istext => this == text || this == localText;
  bool get isImage => this == image || this == localFile;

  String get name => switch (this) {
    image => 'image',
    text => 'text',
    localText => 'localText',
    localFile => 'localFile',
  };

  factory ChatType.fromString(String value) => switch (value) {
    'image' => image,
    'localText' => localText,
    'localFile' => localFile,
    _ => text,
  };
}

class ChatMessage extends Equatable {
  static const String _dataKey = 'data';
  static const String _isImageKey = 'type';
  static const String _dateKey = 'date';
  static const String _userIdKey = 'userId';
  static const String _idKey = 'id';

  final String id;
  final String data;
  final String userId;
  final ChatType type;
  final DateTime date;
  final LoadStatusEnum loadStatus;

  const ChatMessage({
    required this.id,
    required this.data,
    required this.type,
    required this.date,
    required this.userId,
    this.loadStatus = LoadStatusEnum.initial,
  });

  factory ChatMessage.fromJson(String data) {
    final json = jsonDecode(data) as Map<String, dynamic>;
    return ChatMessage(
      id: json[_idKey] as String? ?? '',
      data: json[_dataKey] as String? ?? '',
      type: ChatType.fromString(json[_isImageKey] as String? ?? ''),
      date:
          DateTime.tryParse(json[_dateKey] as String? ?? '') ?? DateTime.now(),
      userId: json[_userIdKey] as String? ?? '',
      loadStatus: LoadStatusEnum.success,
    );
  }

  factory ChatMessage.text(String text, String userId) {
    return ChatMessage(
      id: const Uuid().v8(),
      data: text,
      type: ChatType.localText,
      date: DateTime.now(),
      userId: userId,
      loadStatus: LoadStatusEnum.initial,
    );
  }

  factory ChatMessage.image(String image, String userId) {
    return ChatMessage(
      id: const Uuid().v8(),
      data: image,
      type: ChatType.localFile,
      date: DateTime.now(),
      userId: userId,
      loadStatus: LoadStatusEnum.initial,
    );
  }

  ChatMessage copy({
    String? id,
    String? data,
    String? userId,
    ChatType? type,
    DateTime? date,
    LoadStatusEnum? loadStatus,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      data: data ?? this.data,
      type: type ?? this.type,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  String toJson() {
    final mapData = {
      _dataKey: data,
      _isImageKey: type.name,
      _dateKey: date.toIso8601String(),
      _userIdKey: userId,
    };
    return jsonEncode(mapData);
  }

  @override
  List<Object?> get props => [data, type, date, userId, loadStatus];
}
