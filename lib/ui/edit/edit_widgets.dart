// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EditNoteSegment extends StatelessWidget {
  const EditNoteSegment({
    super.key,
    this.title,
    required this.children,
  });

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title!,
                  style:
                      Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class EditNoteTextField extends StatefulWidget {
  const EditNoteTextField({
    super.key,
    this.initialText = '',
    required this.onSave,
  });

  final String initialText;
  final Function(String value) onSave;

  @override
  State<EditNoteTextField> createState() => _EditNoteTextFieldState();
}

class _EditNoteTextFieldState extends State<EditNoteTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration.collapsed(hintText: 'Type here...'),
        initialValue: widget.initialText,
        maxLines: null,
        maxLength: 1000,
        textCapitalization: TextCapitalization.sentences,
        onSaved: (newValue) => widget.onSave(newValue ?? ''),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Field shouldn't be empty";
          }
          return null;
        },
      ),
    );
  }
}
