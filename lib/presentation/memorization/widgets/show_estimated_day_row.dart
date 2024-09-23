import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/text_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';

class ShowEstimatedDayRow extends StatelessWidget {
  const ShowEstimatedDayRow({
    super.key,
    required TextEditingController dayEditingController,
  }) : _dayEditingController = dayEditingController;

  final TextEditingController _dayEditingController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color scrimColor = context.color.primaryColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: MenuListItem(
            theme: theme,
            iconPath: SvgPath.icCalendar,
            title: 'Estimated day',
          ),
        ),
        Container(
          width: 25.percentWidth,
          height: 8.5.percentWidth,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            borderRadius: radius5,
            color: context.color.primaryColor.withOpacity(0.1),
            border: Border.all(
              color: scrimColor.withOpacity(0.3),
              width: 1.3,
            ),
          ),
          child: TextFormField(
            contextMenuBuilder: fixedLightContextMenu,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: _dayEditingController,
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w400,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
              FilteringTextInputFormatter.digitsOnly,
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: inputDecorateBottomSheet(
              context: context,
              hintText: '5',
              borderRadius: radius5,
              fillColor: Colors.transparent,
            ),
          ),
        ),

        // ],
      ],
    );
  }
}
