import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_craft/icon_craft.dart';
import 'package:icons_plus/icons_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Icon Craft',
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                IconShowcase(
                  baseIcon: const Icon(Icons.verified_user_rounded),
                  auxiliarIcon: const Icon(Icons.currency_exchange),
                  alignment: Alignment.bottomLeft,
                  auxiliarColor: Colors.green.shade700,
                ),
                IconShowcase(
                  baseIcon: const Icon(
                    Icons.person_4,
                    color: Colors.blue,
                  ),
                  auxiliarIcon: const Icon(Icons.balance),
                  alignment: Alignment.bottomLeft,
                  auxiliarColor: Colors.yellow.shade200,
                  decoration: IconDecoration(
                    border: IconBorder(
                      width: 4,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ),
                const IconShowcase(
                  baseIcon: Icon(FontAwesome.ticket_simple_solid),
                  auxiliarIcon: Icon(Bootstrap.airplane_fill),
                  alignment: Alignment.bottomLeft,
                ),
                IconShowcase(
                  baseIcon: const Icon(Icons.notifications),
                  auxiliarIcon: const Icon(Icons.error),
                  alignment: Alignment.topRight,
                  auxiliarColor: Colors.red.shade700,
                ),
                const IconShowcase(
                  baseIcon: Icon(Icons.favorite),
                  auxiliarIcon: Icon(Icons.add),
                  alignment: Alignment.topRight,
                ),
                IconShowcase(
                  baseIcon: const Icon(CupertinoIcons.person_alt),
                  auxiliarIcon: const Icon(Icons.heart_broken),
                  alignment: Alignment.center,
                  auxiliarColor: Colors.red.shade700,
                ),
                IconShowcase(
                  baseIcon: const Icon(BoxIcons.bxl_apple),
                  auxiliarIcon: const Icon(Icons.do_disturb),
                  alignment: Alignment.topLeft,
                  auxiliarColor: Colors.green.shade700,
                ),
                IconShowcase(
                  baseIcon: const Icon(FontAwesome.accessible_icon_brand),
                  auxiliarIcon: const Icon(FontAwesome.heart),
                  alignment: Alignment.center,
                  auxiliarColor: Colors.red.shade700,
                ),
                IconShowcase(
                  baseIcon: const Icon(IonIcons.car_sport),
                  auxiliarIcon: const Icon(FontAwesome.camera_solid),
                  alignment: Alignment.topRight,
                  auxiliarColor: Colors.yellow.shade800,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconShowcase extends StatelessWidget {
  final Icon baseIcon;
  final Icon auxiliarIcon;
  final Alignment alignment;
  final Color? baseColor;
  final Color? auxiliarColor;
  final IconDecoration? decoration;
  const IconShowcase({
    super.key,
    required this.baseIcon,
    required this.auxiliarIcon,
    required this.alignment,
    this.baseColor,
    this.auxiliarColor,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 1; i <= 5; i++)
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: IconCraft(
                    Icon(
                      baseIcon.icon,
                      size: 8.0 + (i * 8),
                      color: baseIcon.color ?? Colors.grey.shade800,
                    ),
                    Icon(auxiliarIcon.icon),
                    alignment: alignment,
                    secondaryIconColor: auxiliarColor,
                    decoration: decoration ??
                        const IconDecoration(
                          border: IconBorder(),
                        ),
                  ),
                ),
              ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
