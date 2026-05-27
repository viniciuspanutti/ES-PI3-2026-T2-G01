/*Vinícius ->
* Explicação do código:
* Desenvolvi o StartupSocietyWidget: Cuida da estrutura societária (sócios, cargos e %) 
* e das informações financeiras (capital, tokens, preço).*/

import 'package:flutter/material.dart';
import '../../domain/startup.dart';

class StartupSocietyWidget extends StatelessWidget {
  final StartupDetail startup;

  const StartupSocietyWidget({super.key, required this.startup});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Estrutura Societária",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const Divider(),

            if (startup.society.isNotEmpty)
              ...startup.society.map((socio) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            socio['name']?.toString() ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            socio['role']?.toString() ?? '',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${socio['equityPercent'] ?? socio['percentage'] ?? 0}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                );
              })
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Informações societárias em atualização.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Capital Aportado",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        'R\$ ${(startup.capitalRaisedCents / 100).toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Tokens Emitidos",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        startup.totalTokensIssued.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
