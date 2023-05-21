// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CommunityModel {
  final String id;
  final String name;
  final String banner;
  final String avatar;
  final List<String> members;
  final List<String> mods;

  CommunityModel(
      {required this.id,
      required this.name,
      required this.banner,
      required this.avatar,
      required this.members,
      required this.mods});

  CommunityModel copyWith({
    String? id,
    String? name,
    String? banner,
    String? avatar,
    List<String>? members,
    List<String>? mods,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      avatar: avatar ?? this.avatar,
      members: members ?? this.members,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'banner': banner,
      'avatar': avatar,
      'members': members,
      'mods': mods,
    };
  }

  factory CommunityModel.fromMap(Map<String, dynamic> map) {
    return CommunityModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        banner: map['banner'] ?? '',
        avatar: map['avatar'] ?? '',
        members: List<String>.from(map['members']),
        mods: List<String>.from(
          (map['mods']),
        ));
  }

  String toJson() => json.encode(toMap());

  factory CommunityModel.fromJson(String source) =>
      CommunityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CommunityModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.banner == banner &&
        other.avatar == avatar &&
        listEquals(other.members, members) &&
        listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        banner.hashCode ^
        avatar.hashCode ^
        members.hashCode ^
        mods.hashCode;
  }
}
