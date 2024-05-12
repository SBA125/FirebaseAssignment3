import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_assignment/models/entry_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'entries';

  Future<void> saveEntry(Entry entry) async {
    try {
      if (entry.id.isEmpty) {
        await _firestore.collection(_collectionName).add(entry.toMap());
      } else {
        await _firestore.collection(_collectionName).doc(entry.id).update(entry.toMap());
      }
    } catch (e) {
      print("Error saving entry: $e");
      rethrow;
    }
  }

  Future<void> deleteEntry(String entryId) async {
    try {
      await _firestore.collection(_collectionName).doc(entryId).delete();
    } catch (e) {
      print("Error deleting entry: $e");
      rethrow;
    }
  }
}