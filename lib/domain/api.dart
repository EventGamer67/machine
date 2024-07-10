import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:machine/data/ticket_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Api {
  static Future<bool> deleteTicket(Ticket ticket) async {
    final supa = GetIt.I.get<Supabase>();

    try {
      await supa.client.from("Tickets").delete().eq('id', ticket.id ?? -1);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> updateTicket(Ticket ticket) async {
    final supa = GetIt.I.get<Supabase>();

    try {
      await supa.client.from("Tickets").update({'status':ticket.status}).eq('id', ticket.id ?? -1);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> sendTicket(Ticket ticket) async {
    final supa = GetIt.I.get<Supabase>();

    try {
      await supa.client.from("Tickets").insert({
        'name': ticket.name,
        'phone': ticket.phone,
        'mail': ticket.mail,
        'vin': ticket.vin,
        'part': ticket.part,
        'answer': ticket.answer,
      });
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
