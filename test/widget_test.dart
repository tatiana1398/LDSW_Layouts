import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ldsw_layouts/main.dart';

void main() {
  testWidgets('Inicio muestra Hello World, la imagen de fondo y los íconos',
      (tester) async {
    await tester.pumpWidget(const CineCatalogoApp());

    expect(find.text('CineCatálogo'), findsOneWidget);
    expect(find.text('Hello World'), findsOneWidget);
    expect(find.text('¡Bienvenido!'), findsOneWidget);

    final fondo = tester.widget<Image>(find.byType(Image));
    expect((fondo.image as AssetImage).assetName,
        'assets/images/fondo_cine.jpg');

    expect(find.byIcon(Icons.movie_filter), findsOneWidget);
    expect(find.byIcon(Icons.local_movies), findsOneWidget);
  });

  testWidgets('Ingresar lleva al catálogo', (tester) async {
    await tester.pumpWidget(const CineCatalogoApp());

    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    expect(find.text('Películas destacadas'), findsOneWidget);
  });

  testWidgets('No hay desbordes en una pantalla pequeña', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const CineCatalogoApp());
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
