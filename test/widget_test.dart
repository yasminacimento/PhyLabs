// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phylabs/main.dart';

void main() {
  testWidgets('login abre como tela inicial e permite acessar o cadastro', (
    tester,
  ) async {
    await tester.pumpWidget(const PhyLabsApp());

    expect(find.text('Bem-vindo de volta'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);

    await tester.ensureVisible(find.text('Criar conta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Criar conta'));
    await tester.pumpAndSettle();

    expect(find.text('Crie sua conta'), findsOneWidget);
    expect(find.text('Nome completo'), findsOneWidget);
    expect(find.text('Confirmar senha'), findsOneWidget);
  });

  testWidgets('login permite abrir recuperação de senha', (tester) async {
    await tester.pumpWidget(const PhyLabsApp());

    await tester.ensureVisible(find.text('Esqueci minha senha'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Esqueci minha senha'));
    await tester.pumpAndSettle();

    expect(find.text('Recuperar acesso'), findsOneWidget);
    expect(find.text('Enviar instruções'), findsOneWidget);

    await tester.tap(find.text('Enviar instruções'));
    await tester.pumpAndSettle();
    expect(find.text('Informe seu e-mail.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'aluno@phylabs.com');
    await tester.tap(find.text('Enviar instruções'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'A recuperação ainda não está conectada a um serviço de autenticação.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('acesso de demonstração abre a tela inicial', (tester) async {
    await tester.pumpWidget(const PhyLabsApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'teste');
    await tester.enterText(find.byType(TextFormField).at(1), 'teste');
    await tester.ensureVisible(find.text('Entrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Olá, Teste'), findsOneWidget);
    expect(find.text('Seu progresso'), findsOneWidget);
    expect(find.text('Continuar de onde parou?'), findsOneWidget);
    expect(find.text('Início'), findsOneWidget);
  });

  testWidgets('catálogo lista matérias e abre as aulas do assunto', (
    tester,
  ) async {
    await tester.pumpWidget(const PhyLabsApp());
    await tester.enterText(find.byType(TextFormField).at(0), 'teste');
    await tester.enterText(find.byType(TextFormField).at(1), 'teste');
    await tester.ensureVisible(find.text('Entrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Matérias'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Cinemática'), findsOneWidget);
    expect(find.text('Termologia'), findsOneWidget);

    await tester.ensureVisible(find.text('Óptica'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Óptica'));
    await tester.pumpAndSettle();

    expect(find.text('Aulas disponíveis'), findsOneWidget);
    expect(
      find.text('Aula 1 - Princípios da óptica geométrica'),
      findsOneWidget,
    );
    expect(find.text('Aula 4 - Instrumentos ópticos'), findsOneWidget);
  });
}
