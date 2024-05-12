import 'package:firebase_assignment/models/entry_model.dart';
import 'package:flutter/material.dart';
import '../repositories/entry_repository.dart';
import '../widgets/entry_form.dart';

class CreateEntryScreen extends StatefulWidget {
  final Entry entry;
  final EntryRepository entryRepository;

  const CreateEntryScreen({
    super.key,
    required this.entry,
    required this.entryRepository,
  });

  @override
  CreateEntryScreenState createState() => CreateEntryScreenState();
}

class CreateEntryScreenState extends State<CreateEntryScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _uploaderNameController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry.title);
    _descriptionController = TextEditingController(text: widget.entry.description);
    _uploaderNameController = TextEditingController(text: widget.entry.uploaderName);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _uploaderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveEntry();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: EntryForm(
        titleController: _titleController,
        descriptionController: _descriptionController,
        uploaderNameController: _uploaderNameController,
      ),
    );
  }

  void _saveEntry() {
    final updatedEntry = Entry(
      id: widget.entry.id,
      title: _titleController.text,
      description: _descriptionController.text,
      uploaderName: _uploaderNameController.text,
      profilePicture: widget.entry.profilePicture,
      createdAt: widget.entry.createdAt,
    );
    widget.entryRepository.saveEntry(updatedEntry);
  }
}
