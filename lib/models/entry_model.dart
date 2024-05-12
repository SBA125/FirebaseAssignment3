import 'package:cloud_firestore/cloud_firestore.dart';

class Entry {
  final String id;
  final String title;
  final String description;
  final String uploaderName;
  final String profilePicture;
  final Timestamp createdAt;

  Entry({
    required this.id,
    required this.title,
    required this.description,
    required this.uploaderName,
    required this.profilePicture,
    required this.createdAt,
  });

  factory Entry.fromMap(Map<String, dynamic> map, String id) {
    return Entry(
      id: id,
      title: map['title'],
      description: map['description'],
      uploaderName: map['uploaderName'],
      profilePicture: map['profilePicture'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'uploaderName': uploaderName,
      'profilePicture': profilePicture,
      'createdAt': createdAt,
    };
  }
}
