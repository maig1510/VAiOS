import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/quiz.dart';

void main() {
  testWidgets('Start button opens the first question', (tester) async {
    await tester.pumpWidget(const Quiz());

    expect(find.text('Spusti kvíz'), findsOneWidget);

    await tester.tap(find.text('Spusti kvíz'));
    await tester.pump();

    expect(find.text(questions[0].text), findsOneWidget);
  });

  testWidgets('Answering all questions shows results and restart works', (
    tester,
  ) async {
    await tester.pumpWidget(const Quiz());
    await tester.tap(find.text('Spusti kvíz'));
    await tester.pump();

    for (final question in questions) {
      await tester.tap(find.text(question.answers[0]));
      await tester.pump();
    }

    expect(find.text('Správne si odpovedal na 6 z 6 otázok!'), findsOneWidget);

    await tester.tap(find.text('Reštartovať kvíz'));
    await tester.pump();

    expect(find.text(questions[0].text), findsOneWidget);
  });
}
