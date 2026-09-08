import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_craft/icon_craft.dart';

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

  testWidgets('IconCraft applies text scaling when applyTextScaling is true', (WidgetTester tester) async {
    const double testIconSize = 24.0;
    const double textScaleFactor = 1.5;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          iconTheme: const IconThemeData(applyTextScaling: true),
        ),
        home: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: const Scaffold(
            body: IconCraft(
              Icon(Icons.email, size: testIconSize),
              Icon(Icons.check_circle),
            ),
          ),
        ),
      ),
    );

    // Find the primary icon RichText widget
    final richTextWidgets = tester.widgetList<RichText>(find.byType(RichText)).toList();
    
    // The primary icon should have scaled size
    final primaryIconWidget = richTextWidgets.firstWhere(
      (widget) => (widget.text as TextSpan).text == String.fromCharCode(Icons.email.codePoint),
    );
    expect(primaryIconWidget.text.style?.fontSize, equals(testIconSize * textScaleFactor));
  });

  testWidgets('IconCraft applies text scaling with 2.0x scale factor', (WidgetTester tester) async {
    const double testIconSize = 24.0;
    const double textScaleFactor = 2.0;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          iconTheme: const IconThemeData(applyTextScaling: true),
        ),
        home: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: const Scaffold(
            body: IconCraft(
              Icon(Icons.email, size: testIconSize),
              Icon(Icons.check_circle),
            ),
          ),
        ),
      ),
    );

    final richTextWidgets = tester.widgetList<RichText>(find.byType(RichText)).toList();
    
    final primaryIconWidget = richTextWidgets.firstWhere(
      (widget) => (widget.text as TextSpan).text == String.fromCharCode(Icons.email.codePoint),
    );
    expect(primaryIconWidget.text.style?.fontSize, equals(testIconSize * textScaleFactor));
  });

  testWidgets('IconCraft scales both primary and secondary icons proportionally', (WidgetTester tester) async {
    const double testIconSize = 24.0;
    const double textScaleFactor = 1.5;
    const double secondaryIconSizeFactor = 0.5;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          iconTheme: const IconThemeData(applyTextScaling: true),
        ),
        home: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: const Scaffold(
            body: IconCraft(
              Icon(Icons.email, size: testIconSize),
              Icon(Icons.check_circle),
              secondaryIconSizeFactor: secondaryIconSizeFactor,
            ),
          ),
        ),
      ),
    );

    final richTextWidgets = tester.widgetList<RichText>(find.byType(RichText)).toList();
    
    final primaryIconWidget = richTextWidgets.firstWhere(
      (widget) => (widget.text as TextSpan).text == String.fromCharCode(Icons.email.codePoint),
    );
    final secondaryIconWidget = richTextWidgets.firstWhere(
      (widget) => (widget.text as TextSpan).text == String.fromCharCode(Icons.check_circle.codePoint),
    );

    final expectedPrimarySize = testIconSize * textScaleFactor;
    final expectedSecondarySize = expectedPrimarySize * secondaryIconSizeFactor;

    expect(primaryIconWidget.text.style?.fontSize, equals(expectedPrimarySize));
    expect(secondaryIconWidget.text.style?.fontSize, equals(expectedSecondarySize));
  });

  testWidgets('IconCraft does not apply text scaling when applyTextScaling is false', (WidgetTester tester) async {
    const double testIconSize = 24.0;
    const double textScaleFactor = 1.5;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          iconTheme: const IconThemeData(applyTextScaling: false),
        ),
        home: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: const Scaffold(
            body: IconCraft(
              Icon(Icons.email, size: testIconSize),
              Icon(Icons.check_circle),
            ),
          ),
        ),
      ),
    );

    final richTextWidgets = tester.widgetList<RichText>(find.byType(RichText)).toList();
    
    final primaryIconWidget = richTextWidgets.firstWhere(
      (widget) => (widget.text as TextSpan).text == String.fromCharCode(Icons.email.codePoint),
    );

    // Should NOT be scaled
    expect(primaryIconWidget.text.style?.fontSize, equals(testIconSize));
  });

  testWidgets('IconCraft does not apply text scaling when applyTextScaling is not set', (WidgetTester tester) async {
    const double testIconSize = 24.0;
    const double textScaleFactor = 1.5;

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: const Scaffold(
            body: IconCraft(
              Icon(Icons.email, size: testIconSize),
              Icon(Icons.check_circle),
            ),
          ),
        ),
      ),
    );

    final richTextWidgets = tester.widgetList<RichText>(find.byType(RichText)).toList();
    
    final primaryIconWidget = richTextWidgets.firstWhere(
      (widget) => (widget.text as TextSpan).text == String.fromCharCode(Icons.email.codePoint),
    );

    // Should NOT be scaled (applyTextScaling defaults to false/null)
    expect(primaryIconWidget.text.style?.fontSize, equals(testIconSize));
  });

  testWidgets('IconCraft with textScaleFactor 1.0 does not change size', (WidgetTester tester) async {
    const double testIconSize = 24.0;
    const double textScaleFactor = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          iconTheme: const IconThemeData(applyTextScaling: true),
        ),
        home: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: const Scaffold(
            body: IconCraft(
              Icon(Icons.email, size: testIconSize),
              Icon(Icons.check_circle),
            ),
          ),
        ),
      ),
    );

    final richTextWidgets = tester.widgetList<RichText>(find.byType(RichText)).toList();
    
    final primaryIconWidget = richTextWidgets.firstWhere(
      (widget) => (widget.text as TextSpan).text == String.fromCharCode(Icons.email.codePoint),
    );

    // With scale factor of 1.0, size should remain the same
    expect(primaryIconWidget.text.style?.fontSize, equals(testIconSize));
  });
}
