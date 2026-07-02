import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:awesome_jumping_widget/awesome_jumping_widget.dart';

void main() {
  testWidgets('AwesomeJumpingWidget renders child and label correctly',
      (WidgetTester tester) async {
    const key = Key('jumping-child');
    const childWidget = SizedBox(key: key, width: 10, height: 10);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AwesomeJumpingWidget(
            labelText: 'Go Pro',
            child: childWidget,
          ),
        ),
      ),
    );

    // Verify the child widget is rendered
    expect(find.byKey(key), findsOneWidget);

    // Verify the label text is rendered
    expect(find.text('Go Pro'), findsOneWidget);
  });

  testWidgets('AwesomeJumpingWidget honors width and height settings',
      (WidgetTester tester) async {
    const childWidget = Icon(Icons.star);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AwesomeJumpingWidget(
            width: 50.0,
            height: 60.0,
            child: childWidget,
          ),
        ),
      ),
    );

    // Find the SizedBox that constrains the widget size
    final sizedBox = tester.widget<SizedBox>(
      find.byType(SizedBox).first,
    );

    expect(sizedBox.width, 50.0);
    expect(sizedBox.height, 60.0);
  });

  testWidgets('AwesomeJumpingWidget executes animation cycle',
      (WidgetTester tester) async {
    const key = Key('jumping-child');
    const childWidget = SizedBox(key: key, width: 10, height: 10);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AwesomeJumpingWidget(
            animationDuration: Duration(milliseconds: 1000),
            jumpHeight: 15.0,
            child: childWidget,
          ),
        ),
      ),
    );

    // Initially at rest (y-offset = 0)
    Transform translateWidget = tester.widget<Transform>(
      find.byType(Transform).first,
    );
    expect(translateWidget.transform.getTranslation().y, 0.0);

    // Trigger the animation forward
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Should be in flight (y-offset should not be 0.0)
    translateWidget = tester.widget<Transform>(
      find.byType(Transform).first,
    );
    expect(translateWidget.transform.getTranslation().y, isNot(0.0));

    // Finish animation duration
    await tester.pump(const Duration(milliseconds: 900));

    // Should return back to 0.0 at the end of cycle
    translateWidget = tester.widget<Transform>(
      find.byType(Transform).first,
    );
    expect(translateWidget.transform.getTranslation().y, 0.0);
  });
}
