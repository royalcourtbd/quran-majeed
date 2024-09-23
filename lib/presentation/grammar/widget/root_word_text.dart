import 'package:flutter/material.dart';

class RootWordText extends StatelessWidget {
  const RootWordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Root word: ',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
