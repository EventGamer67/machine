import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:machine/app.dart';
import 'package:machine/secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supa = await Supabase.initialize(
    url: API_URL,
    anonKey: API_ANON_KEY,
  );

  GetIt.I.registerSingleton<Supabase>(supa);

  runApp(const ProviderScope(child: MyApp()));
}
