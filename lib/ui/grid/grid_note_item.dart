import 'package:flip_notes/data/models/note_model.dart';
import 'package:flip_notes/ui/shared_widgets/info_labbel.dart';
import 'package:flip_notes/utils/formatters.dart';
import 'package:flutter/material.dart';

class GridNoteItem extends StatelessWidget {
  const GridNoteItem({
    super.key,
    required this.note,
    required this.onTap,
    required this.onLongPress,
  });

  final Note note;
  final void Function() onTap;
  final void Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = ColorScheme.fromSeed(seedColor: note.color, brightness: Theme.of(context).brightness);
    return Hero(
      tag: note.id,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: colors.primaryContainer,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colors.onPrimaryContainer,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RichText(
                  maxLines: 6,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  text: TextSpan(text: note.contentFront, style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 20,
                      child: InfoLabel('${note.tags.firstOrNull ?? ''}${(note.tags.length > 1) ? '...' : ''}'),
                    ),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 20,
                      child: InfoLabel(
                        textAlign: TextAlign.end,
                        note.updatedAt.toShortDateString(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
