import 'package:equatable/equatable.dart';

class ComponentData extends Equatable {
  static const String _idkey = "id";
  static const String _componentkey = "component";

  final int id;
  final String component;

  const ComponentData({
    required this.id,
    required this.component,
  });

  factory ComponentData.fromJson(Map json) => ComponentData(
        id: json[_idkey],
        component: json[_componentkey],
      );

  @override
  List<Object?> get props => [id, component];
}
