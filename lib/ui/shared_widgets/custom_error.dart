import 'package:flutter/material.dart';

const String kErrorMessage =
    'Oops, something went wrong. Please try again later.';

class CustomErrorView extends StatelessWidget {
  const CustomErrorView(this.description, {super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 48),
        Text(
          'Oops, something went wrong.\nPlease try again later.\n',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
