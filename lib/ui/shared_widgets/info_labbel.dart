import 'package:flutter/material.dart';

class InfoLabel extends StatelessWidget {
  const InfoLabel(this.text, {this.textAlign = TextAlign.start, super.key});

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelMedium;
    final semiTransparent = labelStyle!.color!.withOpacity(0.75);
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: labelStyle.copyWith(color: semiTransparent),
    );
  }
}
