import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/domain/models/user_model.dart';
import 'package:catch_all_app/domain/repositories/auth_repository.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:catch_all_app/ui/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockPokemonRepository mockPokemonRepository;

  setUpAll(() {
    GetIt.I.allowReassignment = true;
    mockAuthRepository = MockAuthRepository();
    mockPokemonRepository = MockPokemonRepository();

    GetIt.I.registerLazySingleton<IAuthRepository>(() => mockAuthRepository);
    GetIt.I.registerLazySingleton<PokemonRepository>(() => mockPokemonRepository);
  });

  testWidgets('HomeScreen shows header with user greeting', (WidgetTester tester) async {
    const tUser = UserModel(id: '1', displayName: 'Ash Ketchum');

    when(() => mockAuthRepository.getCurrentUser()).thenAnswer((_) async => tUser);
    when(() => mockPokemonRepository.getPokemons(any(), any())).thenAnswer((_) async => null);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(create: (_) => ThemeCubit(), child: const HomeScreen()),
      ),
    );

    // Initial pump for building the widget tree
    await tester.pump();
    // Pump again for context to catch up with future builder and bloc
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('¡Hola, Ash Ketchum!'), findsOneWidget);
    expect(find.text('¿A quién atraparemos hoy?'), findsOneWidget);
  });
}
