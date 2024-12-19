import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

final Map<ColorSwatch<Object>, String> availableColors = Map.fromEntries(
  ColorTools.primaryColorNames.entries.where(
    (entry) => !(entry.value == 'Brown' || entry.value == 'Grey'),
  ),
);

class EditNoteColorPicker extends StatefulWidget {
  const EditNoteColorPicker({
    super.key,
    required this.initialColor,
    required this.pickColor,
  });

  final Color initialColor;
  final Function(Color pickedColor) pickColor;
  @override
  State<EditNoteColorPicker> createState() => _EditNoteColorPickerState();
}

class _EditNoteColorPickerState extends State<EditNoteColorPicker> {
  late Color _color = widget.initialColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select a color',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            ColorPicker(
              color: _color,
              pickersEnabled: const {
                ColorPickerType.accent: false,
                ColorPickerType.primary: false,
                ColorPickerType.custom: true,
              },
              customColorSwatchesAndNames: availableColors,
              showColorName: true,
              colorNameTextStyle:
                  Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
              enableShadesSelection: false,
              height: 30,
              width: 30,
              onColorChanged: (newColor) {
                setState(() => _color = newColor);
                widget.pickColor(newColor);
              },
            ),
          ],
        ),
      ),
    );
  }
}
