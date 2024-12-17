import 'package:flip_card/flip_card.dart';
import 'package:flip_notes/data/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteViewFlipWidget extends ConsumerStatefulWidget {
  const NoteViewFlipWidget({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  ConsumerState<NoteViewFlipWidget> createState() => _CardFlipWidgetState();
}

class _CardFlipWidgetState extends ConsumerState<NoteViewFlipWidget> {
  @override
  Widget build(BuildContext context) {
    final tags = widget.note.tags;
    final ColorScheme colors =
        ColorScheme.fromSeed(seedColor: widget.note.color, brightness: Theme.of(context).brightness);
    final backTextWidget = RichText(
      maxLines: 100,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.center,
      text: TextSpan(
          text: widget.note.contentBack,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.onPrimaryContainer)),
    );

    return
        //  Column(
        //   children: [
        // const Spacer(flex: 1),
        FlipCard(
      fill: widget.note.contentBack.length < widget.note.contentFront.length ? Fill.fillBack : Fill.fillFront,
      front: Card(
        margin: const EdgeInsets.all(16),
        color: colors.primaryContainer,
        child: Center(
          child: SingleChildScrollView(
            primary: false,
            padding: const EdgeInsets.all(8),
            child: RichText(
              maxLines: 100,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              text: TextSpan(
                text: widget.note.contentFront,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: colors.onPrimaryContainer,
                      backgroundColor: colors.primaryContainer,
                    ),
              ),
            ),
          ),
        ),
      ),
      back: Card(
          margin: const EdgeInsets.all(16),
          color: colors.primaryContainer,
          child: Center(
            child: SingleChildScrollView(
              primary: false,
              padding: const EdgeInsets.all(8),
              child: backTextWidget,
            ),
          )),
      // ),
      //   const Spacer(flex: 1),
      //   Expanded(
      //     flex: 1,
      //     child: Material(
      //       child: Wrap(
      //         alignment: WrapAlignment.center,
      //         children: [
      //           for (final tag in tags)
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Chip(label: Text(tag)),
      //             ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
