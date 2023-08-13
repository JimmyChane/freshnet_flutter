import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Service.dart';
import 'package:freshnet_flutter/widgets/service/BottomSheetService.dart';
import 'package:freshnet_flutter/widgets/service/panel/PanelEditDescription.dart';
import 'package:freshnet_flutter/widgets/service/section/Section.dart';

class SectionDescriptionWidget extends StatelessWidget {
  final Service service;

  const SectionDescriptionWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Description',
      body: Text(service.description),
      onTapEdit: () {
        BottomSheetServiceWidget.show(
          context,
          title: 'Edit Description',
          widget: PanelEditDescriptionWidget(service: service),
        );
      },
    );
  }
}
