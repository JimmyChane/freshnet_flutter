import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshnet_flutter/datas/Service.dart';
import 'package:freshnet_flutter/widgets/service/section/Section.dart';

class SectionImagesWidget extends StatelessWidget {
  final Service service;

  const SectionImagesWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Image Reference',
      body: service.belongings.isNotEmpty
          ? Wrap(
              spacing: 4,
              runSpacing: 4,
              children: service.images.map((e) {
                return FutureBuilder<Uint8List>(
                  future: e.toBlob(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Failed to load image');
                    } else if (snapshot.hasData) {
                      return Stack(
                        children: [
                          Image.memory(snapshot.data!, height: 100),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: PopupMenuButton<String>(
                              onSelected: (value) {
                                print('Selected: $value');
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem<String>(
                                    value: 'edit-description',
                                    child: Text('Delete Image')),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text('No image data');
                    }
                  },
                );
              }).toList(),
            )
          : const Text('No Images', style: TextStyle()),
    );
  }
}
