import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshnet_flutter/datas/Belonging.dart';

class PanelEditBelongingsWidget extends StatelessWidget {
  final List<Belonging> belongings;

  late final List<Belonging> templates;

  PanelEditBelongingsWidget({super.key, required this.belongings}) {
    templates = belongings;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: templates
            .map((e) => SectionBottomSheetBelonging(belonging: e))
            .toList(),
      ),
    );
  }
}

class SectionBottomSheetBelonging extends StatelessWidget {
  final Belonging belonging;

  const SectionBottomSheetBelonging({super.key, required this.belonging});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffF7F7F7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0x0D0D0D0F), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: TextEditingController(text: belonging.title),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 80,
                  child: Row(
                    children: [
                      const Text('x'),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: TextEditingController(
                            text: '${belonging.quantity}',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextField(
              controller: TextEditingController(text: belonging.description),
            ),
          ],
        ),
      ),
    );
  }
}
