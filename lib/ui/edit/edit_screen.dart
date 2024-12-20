// ignore_for_file: prefer_final_fields

import 'package:flip_notes/data/models/note_model.dart';
import 'package:flip_notes/data/providers/notes.dart';
import 'package:flip_notes/ui/edit/edit_note_color_picker.dart';
import 'package:flip_notes/ui/edit/edit_widgets.dart';
import 'package:flip_notes/utils/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditScreen extends ConsumerStatefulWidget {
  const EditScreen({super.key, this.noteToEdit});

  final Note? noteToEdit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _formIsDirty = false;

  late String? _enteredTitle = widget.noteToEdit?.title;
  late String? _enteredContentFront = widget.noteToEdit?.contentFront;
  late String? _enteredContentBack = widget.noteToEdit?.contentBack;
  late Color _enteredColor = widget.noteToEdit?.color ?? kDefaultColorSeed; //TODO: Get default from provider
  late Set<String>? _enteredTags = widget.noteToEdit?.tags;

  _saveCard() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if (mounted) setState(() => _formIsDirty = false);

    if (widget.noteToEdit != null) {
      ref.read(notesProvider.notifier).updateNote(
            id: widget.noteToEdit!.id,
            title: _enteredTitle,
            contentFront: _enteredContentFront,
            contentBack: _enteredContentBack,
            color: _enteredColor,
            tags: _enteredTags,
          );
      if (mounted) Navigator.of(context).pop();
    } else {
      ref.read(notesProvider.notifier).createNote(
            title: _enteredTitle!,
            contentFront: _enteredContentFront!,
            contentBack: _enteredContentBack!,
            color: _enteredColor,
            tags: _enteredTags?.toList(),
          );
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = getThemeData(_enteredColor, Theme.of(context).brightness);
    return Theme(
      data: themeData,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.primaryContainer,
          foregroundColor: themeData.colorScheme.onPrimaryContainer,
          title: widget.noteToEdit == null ? const Text('Create new card') : const Text('Edit card'),
          actions: [
            IconButton(
              onPressed: _saveCard,
              icon: const Icon(Icons.save),
              tooltip: 'Save card',
            )
          ],
        ),
        body: Theme(
          data: themeData,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                onChanged: () => setState(() => _formIsDirty = true),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                          alignLabelWithHint: true,
                        ),
                        initialValue: widget.noteToEdit?.title ?? '',
                        maxLines: 1,
                        maxLength: 100,
                        textCapitalization: TextCapitalization.words,
                        onSaved: (newValue) => _enteredTitle = newValue,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Field shouldn't be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    EditNoteSegment(
                      title: 'Note Front',
                      children: [
                        EditNoteTextField(
                          initialText: widget.noteToEdit?.contentFront ?? '',
                          onSave: (text) => _enteredContentFront = text,
                        ),
                      ],
                    ),
                    EditNoteSegment(
                      title: 'Note Back',
                      children: [
                        EditNoteTextField(
                          initialText: widget.noteToEdit?.contentBack ?? '',
                          onSave: (text) => _enteredContentBack = text,
                        ),
                      ],
                    ),
                    EditNoteColorPicker(
                      initialColor: _enteredColor,
                      pickColor: (newColor) => setState(() {
                        _formIsDirty = true;
                        _enteredColor = newColor;
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => ref.read(notesProvider.notifier).addDummyNotes(),
                          child: const Text('Add Dummy Cards'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeData.colorScheme.primaryContainer,
                            foregroundColor: themeData.colorScheme.onPrimaryContainer,
                          ),
                          onPressed: _saveCard,
                          child: const Text('Save card'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
