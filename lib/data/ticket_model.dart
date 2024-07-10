// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

class Ticket {
  int? id;
  String? name;
  String? phone;
  String? mail;
  String? vin;
  String? part;
  int? status = 0;
  DateTime? created;
  final int answer;
  Ticket({
    this.id,
    this.name,
    this.phone,
    this.status,
    this.mail,
    this.vin,
    this.part,
    this.created,
    required this.answer,
  });

  Ticket copyWith({
    int? id,
    String? name,
    String? phone,
    String? mail,
    String? vin,
    String? part,
    DateTime? created,
    int? status,
    int? answer,
  }) {
    return Ticket(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      mail: mail ?? this.mail,
      vin: vin ?? this.vin,
      part: part ?? this.part,
      created: created ?? this.created,
      status: status ?? this.status,
      answer: answer ?? this.answer,
    );
  }

  (String, Color) get getStatus {
    switch (status) {
      case 0:
        return ("Новая заявка",Colors.blue);
      case 1:
        return ("В работе",Colors.yellow);
      case 2:
        return ("Завершена",Colors.green);
      default:
        return ("",Colors.white);
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'mail': mail,
      'vin': vin,
      'part': part,
      'created': created?.millisecondsSinceEpoch,
      'answer': answer,
      'status': status
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        phone: map['phone'] != null ? map['phone'] as String : null,
        mail: map['mail'] != null ? map['mail'] as String : null,
        vin: map['vin'] != null ? map['vin'] as String : null,
        part: map['part'] != null ? map['part'] as String : null,
        created: map['created_at'] != null
            ? DateTime.parse(map['created_at'] as String)
            : null,
        answer: map['answer'] as int,
        status: map['status'] != null ? map['status'] as int : null);
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) =>
      Ticket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ticket(id: $id, name: $name, phone: $phone, mail: $mail, vin: $vin, part: $part, created: $created, answer: $answer)';
  }

  @override
  bool operator ==(covariant Ticket other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.mail == mail &&
        other.vin == vin &&
        other.part == part &&
        other.created == created &&
        other.answer == answer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        mail.hashCode ^
        vin.hashCode ^
        part.hashCode ^
        created.hashCode ^
        answer.hashCode;
  }
}
