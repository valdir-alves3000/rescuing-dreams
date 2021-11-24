import 'package:flutter/material.dart';
import 'package:rescuing_dreams/src/model/guincho.dart';

class MechanicsRepository extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final List<Guincho> _Mechanics = [
    Guincho(
      nome: 'Mecanic do Zé',
      endereco:
          'R. Lourival Portal da Silva, 16 - Jardim Zaira, Mauá - SP, 09321-450',
      foto: '',
      latitude: -23.650583,
      longitude: -46.643549,
    ),
    Guincho(
      nome: 'Auto Mecanic Rodoviária',
      endereco:
          'R. Adílson Dias de Souza, 428 - Jardim Zaira, Mauá - SP, 09321-410',
      foto: '',
      latitude: -23.649579,
      longitude: -46.442677,
    ),
    Guincho(
      nome: 'Auto Mecanic Nilo Cairo',
      endereco:
          'R. Doná Emília Scarparo, 305 - Jardim Zaira, Mauá - SP, 09321-460',
      foto: '',
      latitude: -23.655223,
      longitude: -46.446919,
    ),
  ];

  // ignore: non_constant_identifier_names
  List<Guincho> get Mechanics => _Mechanics;
}
