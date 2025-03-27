import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_craft/icon_craft.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

void main() {
  //
  testWidgets('IconCraft renders both icons with default properties', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IconCraft(
          Icon(Icons.email),
          Icon(Icons.check_circle),
        ),
      ),
    ));

    expect(find.text(String.fromCharCode(Icons.email.codePoint), findRichText: true), findsOneWidget);
    expect(find.text(String.fromCharCode(Icons.check_circle.codePoint), findRichText: true), findsOneWidget);

    BuildContext context = tester.element(find.byType(IconCraft));
    Color? defaultIconColor = IconTheme.of(context).color;

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is RichText && widget.text.style?.color == defaultIconColor,
      ),
      findsNWidgets(2),
    );
  });

  testWidgets('IconCraft renders both icons with custom properties', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IconCraft(
          Icon(
            Icons.person,
            color: Colors.yellow,
          ),
          Icon(Icons.comment_bank),
          decoration: IconDecoration(
            border: IconBorder(
              color: Colors.black,
              width: 5.0,
            ),
          ),
        ),
      ),
    ));

    expect(find.text(String.fromCharCode(Icons.person.codePoint), findRichText: true), findsOneWidget);
    expect(find.text(String.fromCharCode(Icons.comment_bank.codePoint), findRichText: true), findsNWidgets(2));

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is RichText && widget.text.style?.color == Colors.yellow,
      ),
      findsNWidgets(2), // secondary icon should inherit the color of the base icon
    );

    final richTextFinder = find.byWidgetPredicate(
      (Widget widget) => widget is RichText,
    );

    final Iterable<RichText> richTextWidgets = tester.widgetList(richTextFinder).cast<RichText>();

    for (final RichText richText in richTextWidgets) {
      final TextSpan textSpan = richText.text as TextSpan;
      final TextStyle? textStyle = textSpan.style;
      final Paint? paint = textStyle?.foreground;

      if (paint?.strokeWidth != null) {
        expect(paint!.strokeWidth, equals(5.0));
      }

      if (paint?.color != null) {
        expect(paint!.color, Colors.black);
      }
    }
  });

  testWidgets('IconCraft applies custom color and size factor to secondary icon', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IconCraft(
          Icon(Icons.email),
          Icon(
            Icons.check_circle,
            color: Colors.red,
          ),
          secondaryIconSizeFactor: 0.1,
        ),
      ),
    ));

    expect(find.text(String.fromCharCode(Icons.email.codePoint), findRichText: true), findsOneWidget);
    expect(find.text(String.fromCharCode(Icons.check_circle.codePoint), findRichText: true), findsOneWidget);

    final RichText secondaryIcon = tester.widget(find.text(String.fromCharCode(Icons.check_circle.codePoint), findRichText: true));
    expect(secondaryIcon.text.style?.color, equals(Colors.red));
    expect(secondaryIcon.text.style?.fontSize, equals(24.0 * 0.1)); // Assuming default size is 24.0
  });

  testWidgets('IconCraft applies rotation to primary and secondary icons', (WidgetTester tester) async {
    const double primaryRotation = 45.0;
    const double secondaryRotation = 90.0;

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IconCraft(
          Icon(Icons.email),
          Icon(Icons.check_circle),
          rotation: primaryRotation,
          secondaryRotation: secondaryRotation,
        ),
      ),
    ));

    final primaryIconFinder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is Transform &&
          widget.alignment == Alignment.center &&
          isRotationApplied(widget.transform, primaryRotation),
    );
    expect(primaryIconFinder, findsOneWidget);

    final secondaryIconFinder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is Transform &&
          widget.alignment == Alignment.center &&
          isRotationApplied(widget.transform, secondaryRotation),
    );
    expect(secondaryIconFinder, findsOneWidget);
  });
}

bool isRotationApplied(Matrix4 matrix, double expectedRotationInDegrees) {
  final Matrix3 rotationMatrix = matrix.getRotation();
  final double sinTheta = rotationMatrix.entry(1, 0);
  final double cosTheta = rotationMatrix.entry(0, 0);
  final double actualRotationInRadians = atan2(sinTheta, cosTheta);
  final double actualRotationInDegrees = actualRotationInRadians * (180 / pi);

  // Allow a small margin for floating-point precision issues
  return (actualRotationInDegrees - expectedRotationInDegrees).abs() < 0.01;
}

