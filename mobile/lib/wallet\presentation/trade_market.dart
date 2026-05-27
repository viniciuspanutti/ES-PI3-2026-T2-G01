// feito por camila fernandes costacurta RA:25012949

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/startup_card.dart';

class BalcaoNegociacaoPage extends StatefulWidget {
  const BalcaoNegociacaoPage({super.key});

  @override
  State<BalcaoNegociacaoPage> createState() => _BalcaoNegociacaoPageState();
}

class _BalcaoNegociacaoPageState extends State<BalcaoNegociacaoPage> {
  String _filtroSelecionado = 'Todas';

  void _abrirFiltros() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Filtrar por Setor",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  'Todas',
                  'Agronegócio',
                  'Tecnologia',
                  'Sustentabilidade',
                  'Saúde',
                  'Educação',
                ].map((label) {
                  final bool isSelected = _filtroSelecionado == label;
                  return ChoiceChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _filtroSelecionado = label;
                      });
                      Navigator.pop(context);
                    },
                    selectedColor: const Color(0xFF512DA8),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar", style: TextStyle(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'BALCÃO DE NEGOCIAÇÕES',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: _abrirFiltros,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_filtroSelecionado != 'Todas')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Text(
                    "Filtrado por: ",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  Chip(
                    label: Text(
                      _filtroSelecionado,
                      style: const TextStyle(fontSize: 10),
                    ),
                    onDeleted: () =>
                        setState(() => _filtroSelecionado = 'Todas'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('startups').get(),
              builder: (context, startupsSnap) {
                if (!startupsSnap.hasData)
                  return const Center(child: CircularProgressIndicator());

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('exchange')
                      .snapshots(),
                  builder: (context, exchangeSnap) {
                    if (!exchangeSnap.hasData)
                      return const Center(child: CircularProgressIndicator());

                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    final investStream = userId != null
                        ? FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('investimentos')
                            .snapshots()
                        : const Stream<QuerySnapshot>.empty();

                    return StreamBuilder<QuerySnapshot>(
                      stream: investStream,
                      builder: (context, investSnap) {
                        final startupsDocs = startupsSnap.data!.docs;
                        final exchangeDocs = exchangeSnap.data!.docs;
                        final investDocs = investSnap.data?.docs ?? [];

                        final List<Map<String, dynamic>> combinedList = [];

                        for (var s in startupsDocs) {
                          final sData = s.data() as Map<String, dynamic>;
                          final ex = exchangeDocs
                              .where((e) => e.id == s.id)
                              .firstOrNull
                              ?.data() as Map<String, dynamic>?;
                          final inv = investDocs
                              .where((i) => i.id == s.id)
                              .firstOrNull
                              ?.data() as Map<String, dynamic>?;

                          final preco = ex?['precoAtual'] ??
                              (sData['currentTokenPriceCents'] ?? 0) / 100.0;
                          final qtd = inv?['tokensComprados'] ?? 0;
                          final double variacao =
                              (ex?['variacao'] ?? 0.0).toDouble();

                          String ticker = s.id.toUpperCase();
                          switch (s.id) {
                            case 'agrisense':
                              ticker = 'AGRI3';
                              break;
                            case 'devmatch':
                              ticker = 'DEVM3';
                              break;
                            case 'ecocycle':
                              ticker = 'ECYC1';
                              break;
                            case 'healthbit':
                              ticker = 'HBIT3';
                              break;
                            case 'smartcampus':
                              ticker = 'SCMP3';
                              break;
                          }

                          combinedList.add({
                            'nome': sData['name'] ?? 'Desconhecido',
                            'ticker': ticker,
                            'logo': sData['coverImageUrl'] ??
                                'assets/images/logos/logotipoAgriSense.png',
                            'preco': preco.toDouble(),
                            'valorizacao': variacao > 0
                                ? '+${variacao.toStringAsFixed(1)}%'
                                : '${variacao.toStringAsFixed(1)}%',
                            'qtd': qtd,
                            'setor': sData['tags']?.isNotEmpty == true
                                ? sData['tags'][0]
                                : 'Desconhecido',
                            'id': s.id,
                          });
                        }

                        final listaFiltrada = _filtroSelecionado == 'Todas'
                            ? combinedList
                            : combinedList.where((s) {
                                final setor =
                                    (s['setor'] as String).toLowerCase();
                                final filtro = _filtroSelecionado.toLowerCase();
                                if (filtro == 'agronegócio' &&
                                    setor.contains('agro')) return true;
                                if (filtro == 'tecnologia' &&
                                    setor.contains('tech')) return true;
                                if (filtro == 'sustentabilidade' &&
                                    (setor.contains('clean') ||
                                        setor.contains('green'))) return true;
                                if (filtro == 'saúde' && setor.contains('health'))
                                  return true;
                                if (filtro == 'educação' &&
                                    setor.contains('edtech')) return true;
                                return s['setor'] == _filtroSelecionado;
                              }).toList();

                        return listaFiltrada.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 64,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Nenhuma startup encontrada\nneste setor.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(20),
                                itemCount: listaFiltrada.length,
                                itemBuilder: (context, index) {
                                  final startup = listaFiltrada[index];
                                  final double total =
                                      startup['preco'] * startup['qtd'];

                                  return StartupCard(
                                    startup: startup,
                                    total: total,
                                  );
                                },
                              );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
