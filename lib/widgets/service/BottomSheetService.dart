import 'package:flutter/material.dart';

class BottomSheetServiceWidget extends StatelessWidget {
  static show(
    BuildContext context, {
    required String title,
    required Widget widget,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return BottomSheetServiceWidget(widget: widget, title: title);
      },
    );
  }

  final String title;
  final Widget widget;

  const BottomSheetServiceWidget({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.1),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Text(title),
                  ],
                ),
              ),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
