import 'package:firebase_assignment/models/entry_model.dart';
import '../../services/firestore_service.dart';

class EntryRepository {
  final FirestoreService _firestoreService;

  EntryRepository(this._firestoreService);

  Future<void> saveEntry(Entry entry) async {
    try {
      await _firestoreService.saveEntry(entry);
    } catch (e) {
      print("Error saving entry: $e");
      rethrow; // Rethrow the error to handle it in the calling code
    }
  }

  Future<void> deleteEntry(String entryId) async {
    try {
      await _firestoreService.deleteEntry(entryId);
    } catch (e) {
      print("Error deleting entry: $e");
      rethrow; // Rethrow the error to handle it in the calling code
    }
  }
}