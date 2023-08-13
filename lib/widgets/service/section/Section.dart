import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final Function? onTapEdit;

  const SectionWidget({
    super.key,
    required this.title,
    required this.body,
    this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (onTapEdit != null)
                    InkWell(
                      onTap: () => onTapEdit!(),
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.edit_outlined),
                      ),
                    )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
