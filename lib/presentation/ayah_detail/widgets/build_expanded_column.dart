import 'package:flutter/material.dart';

class BuildExpandedColumn extends StatelessWidget {
  const BuildExpandedColumn({
    super.key,
    required this.flex,
    this.searchTextField,
    required this.itemBuilder,
    this.itemCount,
  });

  final int flex;
  final Widget? searchTextField;
  final IndexedWidgetBuilder itemBuilder;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment:
            flex == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          //TODO: jokhon Jumpto ayah bottom sheet e surah and ayah search korar functionality kora hobe tokhon eta uncomment korte hobe
          /*
          SizedBox(
            height: fortyFivePx,
            child: searchTextField,
          ),
          gapH15,
          */
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }
}
