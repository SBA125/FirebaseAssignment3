import 'package:flutter/material.dart';
class EntryForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController uploaderNameController;

  const EntryForm({super.key,
    required this.titleController,
    required this.descriptionController,
    required this.uploaderNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: uploaderNameController,
            decoration: const InputDecoration(labelText: 'Uploader Name'),
          ),
        ],
      ),
    );
  }
}