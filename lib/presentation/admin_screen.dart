import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine/data/ticket_model.dart';
import 'package:machine/presentation/home_screen.dart';
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
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Заявки",
                        style: GoogleFonts.raleway(
                            fontSize: 60,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()));
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).colorScheme.primary),
                          child: Center(
                            child: Text("Выйти",
                                style: GoogleFonts.roboto(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Builder(builder: (context) {
                    return ref.watch(ticketsProvider).when(data: (data) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: List.generate(data.length, (index) {
                              final ticket = data[index];
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
                                    Text(
                                      "Имя",
                                      style: GoogleFonts.raleway(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ticket.name ?? '',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Почта",
                                      style: GoogleFonts.raleway(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ticket.mail ?? '',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Телефон",
                                      style: GoogleFonts.raleway(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ticket.phone ?? '',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "VIN",
                                      style: GoogleFonts.raleway(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ticket.vin ?? '',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Запчасть",
                                      style: GoogleFonts.raleway(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ticket.part ?? '',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Способ связи",
                                      style: GoogleFonts.raleway(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ticket.answer == 1
                                          ? "Телефон"
                                          : ticket.answer == 3
                                              ? "Вацап"
                                              : "Почта",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Отправлена",
                                      style: GoogleFonts.raleway(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${ticket.created!.year}.${ticket.created!.month}.${ticket.created!.day} - ${ticket.created!.hour > 9 ? ticket.created!.hour : '0${ticket.created!.hour}'}:${ticket.created!.minute > 9 ? ticket.created!.minute : '0${ticket.created!.minute}'}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ],
                      );
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

class TicketTile extends ConsumerStatefulWidget {
  const TicketTile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketTileState();
}

class _TicketTileState extends ConsumerState<TicketTile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
