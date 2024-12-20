import 'package:flip_notes/data/providers/notes.dart';
import 'package:flip_notes/data/sources/local_db.dart';
import 'package:flip_notes/ui/edit/edit_screen.dart';
import 'package:flip_notes/ui/grid/grid_note_item.dart';
import 'package:flip_notes/ui/note_view/note_view_screen.dart';
import 'package:flip_notes/ui/shared_widgets/custom_error.dart';
import 'package:flip_notes/utils/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridScreen extends ConsumerStatefulWidget {
  const GridScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GridScreenState();
}

class _GridScreenState extends ConsumerState<GridScreen> {
  late ScrollController gridScrollcontroller = ScrollController();
  @override
  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: const Text('Flip Notes!'),
        actions: const [],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        heroTag: 'create',
        tooltip: 'Create a new note',
        // label: const Text('New note'),
        child: const Icon(Icons.add, size: 36),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditScreen(),
          ),
        ),
      ),
      body: notes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: CustomErrorView(error.toString())),
        data: (list) {
          if (list.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () => ref.read(notesProvider.notifier).reload(),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 384,
                  mainAxisExtent: 192,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                controller: gridScrollcontroller,
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) => GridNoteItem(
                  note: list[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteViewScreen(
                          listOfNotes: list,
                          initialIndex: index,
                          initialTheme: getThemeData(list[index].color, Theme.of(context).brightness),
                          updateIndex: (newIndex) => gridScrollcontroller
                              .jumpTo(1.0 * newIndex * gridScrollcontroller.position.maxScrollExtent / list.length),
                        ),
                      ),
                    );
                  },
                  onLongPress: () {}, //TODO
                ),
              ),
            );
          }
          //if empty:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Center(
                child: Text(
                  'Nothing to see here.\nPlease try creating some cards.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 8),
            ],
          );
        },
      ),
    );
  }
}
