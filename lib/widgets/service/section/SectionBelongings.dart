import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Service.dart';
import 'package:freshnet_flutter/widgets/service/item/Belonging.dart';
import 'package:freshnet_flutter/widgets/service/BottomSheetService.dart';
import 'package:freshnet_flutter/widgets/service/panel/PanelEditBelongings.dart';
import 'package:freshnet_flutter/widgets/service/section/Section.dart';

class SectionBelongingsWidget extends StatelessWidget {
  final Service service;

  const SectionBelongingsWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Belongings',
      onTapEdit: () {
        BottomSheetServiceWidget.show(
          context,
          title: 'Edit Belongings',
          widget: PanelEditBelongingsWidget(belongings: service.belongings),
        );
      },
      body: service.belongings.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: service.belongings.map((e) {
                return BelongingWidget(e);
              }).toList(),
            )
          : const Text('Empty', style: TextStyle()),
    );
  }
}
