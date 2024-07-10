import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine/data/ticket_model.dart';
import 'package:machine/presentation/home_screen.dart';
import 'package:machine/presentation/logic/home_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final ticketsProvider = FutureProvider.autoDispose<List<Ticket>>((ref) async {
  final response =
      await GetIt.I.get<Supabase>().client.from('Tickets').select('*');

  final res = response.map((e) => Ticket.fromMap(e)).toList();
  res.sort((a, b) => b.created!.compareTo(a.created!));
  return res;
});

class AdminPanel extends ConsumerStatefulWidget {
  const AdminPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminPanelState();
}

class _AdminPanelState extends ConsumerState<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ListView(
                children: [
                  const Header(),
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Builder(builder: (context) {
                    return ref.watch(ticketsProvider).when(data: (data) {
                      return TicketsVIew(data: data);
                    }, error: (error, trace) {
                      return Center(
                        child: Text(error.toString()),
                      );
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                  }),
                ],
              )),
        ),
      ),
    );
  }
}

class TicketsVIew extends StatelessWidget {
  final List<Ticket> data;
  const TicketsVIew({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: List.generate(data.length, (index) {
              final ticket = data[index];
              return TicketTile(ticket: ticket);
            }),
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MediaQuery.sizeOf(context).width > 650
          ? Row(
              children: [
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Заявки",
                      maxLines: 1,
                      style: GoogleFonts.raleway(
                          fontSize: 60,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary),
                    child: Center(
                      child: Text("Главный экран",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    await GetIt.I.get<Supabase>().client.auth.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.redAccent),
                    child: Center(
                      child: Text("Выйти из аккаунта",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
              ],
            )
          : Column(children: [
              Text(
                "Заявки",
                maxLines: 1,
                style: GoogleFonts.raleway(
                    fontSize: 60,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.primary),
                        child: Center(
                          child: Text("Главный экран",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.redAccent),
                        child: Center(
                          child: Text("Выйти из аккаунта",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
    );
  }
}

class TicketTile extends ConsumerWidget {
  const TicketTile({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 3)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Статус: ",
                style: GoogleFonts.raleway(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                ticket.getStatus.$1,
                style: TextStyle(
                    fontSize: 24,
                    color: ticket.getStatus.$2,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () async {
                    log("message");
                    final int res = await showDialog(
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
                                      "Выберите новый статус заявки",
                                      style: GoogleFonts.roboto(
                                        fontSize: 24,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context, 0);
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.blue),
                                        child: Center(
                                          child: Text("Новая заявка",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context, 1);
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.yellow),
                                        child: Center(
                                          child: Text("В работе",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context, 2);
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.green),
                                        child: Center(
                                          child: Text("Завершена",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        });
                    log(res.toString());

                      ticket.status = res;
                      await ref
                          .read(homeScreenProvider)
                          .updateTicket(ticket, context);
                      ref.refresh(ticketsProvider);
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          Text(
            "Имя",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.name ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Почта",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.mail ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Телефон",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.phone ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "VIN",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.vin ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Запчасть",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.part ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Способ связи",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.answer == 1
                ? "Телефон"
                : ticket.answer == 3
                    ? "Whatsapp"
                    : ticket.answer == 4
                        ? "Viber"
                        : "Почта",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Отправлена",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            '${ticket.created!.year}.${ticket.created!.month}.${ticket.created!.day} - ${ticket.created!.hour > 9 ? ticket.created!.hour : '0${ticket.created!.hour}'}:${ticket.created!.minute > 9 ? ticket.created!.minute : '0${ticket.created!.minute}'}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final res = await showDialog(
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
                                    "Вы действительно хотите удалить заявку?",
                                    style: GoogleFonts.roboto(
                                      fontSize: 24,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context, false);
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          child: Center(
                                            child: Text("Нет",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context, true);
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.redAccent),
                                          child: Center(
                                            child: Text("Да",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                      });

                  if (res) {
                    await ref.read(homeScreenProvider).deleteTicket(ticket, context);
                    ref.refresh(ticketsProvider);
                  }
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.redAccent.withOpacity(0.7)),
                  child: Center(
                    child: Text("Удалить заявку",
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
