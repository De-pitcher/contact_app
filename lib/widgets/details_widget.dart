import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  final String title;
  final double height;
  final List<Widget> children;
  const DetailsWidget({
    super.key,
    required this.title,
    required this.children,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 8,
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Column(
            children: [
              ...children,
            ],
          ),
        ],
      ),
    );
  }
}
