import 'package:flip_notes/data/providers/notes.dart';
import 'package:flip_notes/ui/grid/grid_note_item.dart';
import 'package:flip_notes/ui/shared_widgets/custom_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridScreen extends ConsumerStatefulWidget {
  const GridScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GridScreenState();
}

class _GridScreenState extends ConsumerState<GridScreen> {
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
        tooltip: "Create new",
        onPressed: () {}, //TODO
        child: const Icon(Icons.add),
      ),
      body: notes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => CustomErrorView(error.toString()),
        data: (list) {
          if (list.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 192,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (context, index) => GridNoteItem(
                note: list[index],
                onTap: () {}, //TODO
                onLongPress: () {}, //TODO
              ),
            );
          }
          //if empty:
          return ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  Text(
                    'Nothing to see here.\nPlease try creating some cards.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 8),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
