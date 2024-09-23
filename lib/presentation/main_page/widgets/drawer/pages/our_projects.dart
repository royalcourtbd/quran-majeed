import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/data/model_class/our_project_model.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/pages/project_info_card_item.dart';

class OurProjectsPage extends StatelessWidget {
  OurProjectsPage({super.key});
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: globalKey,
      appBar: CustomAppBar(
        title: "Our Project",
        theme: theme,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            RoundedScaffoldBody(
              isColored: true,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: ourProjectList.length,
                itemBuilder: (context, index) {
                  return ProjectInfoCardItem(
                    key: ValueKey("custom_tile$index"),
                    ourProject: ourProjectList[index],
                  );
                },
              ),
            ),
            gapH25,
          ],
        ),
      ),
    );
  }
}
