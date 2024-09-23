import 'package:flutter/material.dart';
import 'package:quran_majeed/data/model_class/musaf_data_model.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/musaf_option_list_item.dart';

class MusafQuranList extends StatelessWidget {
  const MusafQuranList({
    super.key,
    required this.musafMode,
  });

  final List<MusafDataModel> musafMode;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: musafMode.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return MusafOptionListItem(
          musafDataModel: musafMode[index],
          index: index,
        );
      },
    );
  }
}
