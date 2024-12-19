import 'package:flip_notes/data/models/note_model.dart';
import 'package:flip_notes/ui/note_view/note_view_flip_widget.dart';
import 'package:flip_notes/utils/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteViewScreen extends ConsumerStatefulWidget {
  const NoteViewScreen({
    super.key,
    required this.listOfNotes,
    required this.initialIndex,
    required this.initialTheme,
    required this.updateIndex,
  });

  final List<Note> listOfNotes;
  final int initialIndex;
  final ThemeData initialTheme;
  final void Function(int newIndex) updateIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends ConsumerState<NoteViewScreen> {
  late PageController pageController;
  late int currentIndex;
  late ThemeData currentNoteTheme;
  late Note currentNote;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    currentNote = widget.listOfNotes[currentIndex];
    currentNoteTheme = widget.initialTheme;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentNoteTheme.colorScheme.primary,
        foregroundColor: currentNoteTheme.colorScheme.onPrimary,
        title: Text(currentNote.title),
        actions: const [], //TODO
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: currentNoteTheme.colorScheme.primary,
        foregroundColor: currentNoteTheme.colorScheme.onPrimary,
        heroTag: 'edit',
        tooltip: 'Edit this note',
        // label: const Text('New note'),
        child: const Icon(Icons.edit, size: 36),
        onPressed: () {}, //TODO
      ),
      body: Hero(
        tag: currentNote.id,
        child: PageView.builder(
          itemCount: widget.listOfNotes.length,
          onPageChanged: (value) {
            widget.updateIndex(value);
            setState(() {
              currentIndex = value;
              currentNote = widget.listOfNotes[currentIndex];
              currentNoteTheme = getThemeData(currentNote.color, Theme.of(context).brightness);
            });
          },
          controller: pageController,
          itemBuilder: (context, index) {
            return NoteViewFlipWidget(note: widget.listOfNotes[index]);
          },
        ),
      ),
    );
  }
}
