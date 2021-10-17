import 'package:flutter/material.dart';
import 'package:rescuing_dreams/src/model/guincho.dart';

class GuinchosRepository extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final List<Guincho> _Guinchos = [
    Guincho(
      nome: 'Guincho GT - Rede Rodoil',
      endereco:
          'R. Lourival Portal da Silva, 16 - Jardim Zaira, Mauá - SP, 09321-450',
      foto:
          'https://lh5.googleusercontent.com/p/AF1QipP_xnSi5-sp9slSuMpSx-JlmvwvHGL1VJ_JcOGX=w408-h306-k-no',
      latitude: -23.650583,
      longitude: -46.443549,
    ),
    Guincho(
      nome: 'Auto Guincho Rodoviária',
      endereco:
          'R. Adílson Dias de Souza, 428 - Jardim Zaira, Mauá - SP, 09321-410',
      foto:
          'https://lh5.googleusercontent.com/p/AF1QipPnfQSsnvt6-VAxF-fUQ0onQCeRktJptOvSL_9F=w408-h306-k-no',
      latitude: -23.649579,
      longitude: -46.442677,
    ),
    Guincho(
      nome: 'Auto Guincho Nilo Cairo',
      endereco: 'R. Doná Emília Scarparo, 305 - Jardim Zaira, Mauá - SP, 09321-460',
      foto:
          'https://lh5.googleusercontent.com/p/AF1QipOB2w7C9Q_NTblNRhcxJtN3-s4_gSjHI1rs5cSM=w408-h544-k-no',
      latitude: -23.649223,
      longitude: -46.445419,
    ),
  ];

  // ignore: non_constant_identifier_names
  List<Guincho> get Guinchos => _Guinchos;
}
