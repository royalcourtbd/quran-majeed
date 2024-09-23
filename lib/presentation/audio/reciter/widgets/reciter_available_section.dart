import 'package:flutter/material.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/audio/reciter/widgets/reciter_list_item.dart';

class ReciterAvailableSection extends StatelessWidget {
  final List<Reciter> reciters;
  final ThemeData theme;
  const ReciterAvailableSection({
    required this.reciters,
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        reciters.length,
        (index) => ReciterListItem(
          reciter: reciters[index],
          theme: theme,
        
        ),
      ),
    );
  }
}
