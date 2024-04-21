import 'package:example/IconsHelper.dart';
import 'package:flutter/material.dart';
import 'package:icon_craft/icon_craft.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.black,
      Colors.grey.shade800,
      Colors.blue.shade800,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.pink,
    ];
    final List<Alignment> alignments = [
      Alignment.topLeft,
      Alignment.topCenter,
      Alignment.topRight,
      Alignment.centerLeft,
      Alignment.center,
      Alignment.centerRight,
      Alignment.bottomLeft,
      Alignment.bottomCenter,
      Alignment.bottomRight,
    ];

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    childAspectRatio: 1.6,
                  ),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    final baseIcon = IconsHelper.getRandomIcon();
                    final secondIcon = IconsHelper.getRandomIcon();
                    var baseColor = (colors.toList()..shuffle()).first;
                    var baseSecondColor = (colors.toList()..shuffle()).first;
                    var alignment = (alignments.toList()..shuffle()).first;

                    return IconCraft(
                      Icon(
                        baseIcon,
                        size: 50,
                        color: baseColor,
                      ),
                      Icon(
                        secondIcon,
                        color: baseSecondColor,
                      ),
                      alignment: alignment,
                      decoration: const IconDecoration(
                        border: IconBorder(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
