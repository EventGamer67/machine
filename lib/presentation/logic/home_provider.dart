import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine/data/ticket_model.dart';
import 'package:machine/domain/api.dart';
import 'package:machine/presentation/admin_screen.dart';
import 'package:machine/presentation/widgets/my_textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider {
  Future<bool> auth(String login, String password) async {
    final response = await GetIt.I
        .get<Supabase>()
        .client
        .auth
        .signInWithPassword(password: password, email: login);

    if (response.user == null) {
      return false;
    }
    return true;
  }
}

final homeScreenProvider = ChangeNotifierProvider<HomeScreenNotifier>((ref) {
  return HomeScreenNotifier();
});

class HomeScreenNotifier extends ChangeNotifier {
  final scrollController = ScrollController();

  Future<void> sendMessage(Ticket ticket, BuildContext context) async {
    final res = await Api.sendTicket(ticket);

    if (res) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Заявка отправлена")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Что-то пошло не так")));
    }
  }

  Future<void> showLogin(BuildContext context, WidgetRef ref) async {
    final TextEditingController loginController =
        TextEditingController(text: "");
    final TextEditingController passwordController =
        TextEditingController(text: "");

    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Авторизация",
                      style: GoogleFonts.roboto(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      controller: loginController,
                      hint: "Логин",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      controller: passwordController,
                      hint: "Пароль",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        final res = await ref.read(authProvider).auth(
                            loginController.text, passwordController.text);
                        if (res) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const AdminPanel()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Неверные данные")));
                        }
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.primary),
                        child: Center(
                          child: Text("Войти",
                              style: GoogleFonts.roboto(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
        });
  }
}
