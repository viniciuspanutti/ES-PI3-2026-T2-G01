import 'package:flutter/material.dart';
// ── SUBSTITUIÇÃO DO MOCK ─────────────────────────────────────────────
// Antes:  import '../../../data/startup_mock.dart';
// Agora o catálogo consome dados reais do Firestore via StartupService.
// ─────────────────────────────────────────────────────────────────────
import '../../../data/startup_service.dart';
import '../../../domain/startup.dart';
import 'startup_detail_screen.dart';

class CatalogoStartupsPage extends StatefulWidget {
  const CatalogoStartupsPage({super.key});

  @override
  State<CatalogoStartupsPage> createState() => _CatalogoStartupsPageState();
}

class _CatalogoStartupsPageState extends State<CatalogoStartupsPage> {
  String _filtroSelecionado = 'Todas';

  // ── SUBSTITUIÇÃO DO MOCK ───────────────────────────────────────────
  // Antes:  final List<StartupDetail> startups = StartupMock.allStartups;
  // Agora usamos o serviço real que consulta o Firestore.
  // ───────────────────────────────────────────────────────────────────
  final StartupService _startupService = StartupService();
  late Future<List<StartupDetail>> _startupsFuture;

  @override
  void initState() {
    super.initState();
    _startupsFuture = _startupService.getStartups();
  }

  void _abrirFiltros() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Filtrar por Estágio",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ['Todas', 'Nova', 'Em operação', 'Em expansão'].map((
                  label,
                ) {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho Restaurado: Voltar, Título e Filtro
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                  ),
                  const Text(
                    "Startups MesclaInvest",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune, color: Colors.black),
                    onPressed: _abrirFiltros,
                  ),
                ],
              ),
            ),

            if (_filtroSelecionado != 'Todas')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Text(
                      "Filtrado por: ",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
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

            // ── SUBSTITUIÇÃO DO MOCK ─────────────────────────────────
            // Antes:  lista síncrona direta (startups).
            // Agora:  FutureBuilder com estados de loading, erro e vazio.
            // ─────────────────────────────────────────────────────────
            Expanded(
              child: FutureBuilder<List<StartupDetail>>(
                future: _startupsFuture,
                builder: (context, snapshot) {
                  // ── Estado de carregamento ─────────────────────────
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF512DA8),
                      ),
                    );
                  }

                  // ── Estado de erro ─────────────────────────────────
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_off,
                              size: 64,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Erro ao carregar startups.\nVerifique sua conexão.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            OutlinedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _startupsFuture =
                                      _startupService.getStartups();
                                });
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Tentar novamente"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // ── Dados carregados ───────────────────────────────
                  final startups = snapshot.data ?? [];

                  // Aplica o filtro de estágio sobre os dados reais
                  final listaFiltrada = _filtroSelecionado == 'Todas'
                      ? startups
                      : startups
                            .where((s) => s.stage == _filtroSelecionado)
                            .toList();

                  if (listaFiltrada.isEmpty) {
                    return Center(
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
                            "Nenhuma startup encontrada\nneste estágio.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: listaFiltrada.length,
                    separatorBuilder: (_, _) =>
                        Divider(color: Colors.grey.shade100, height: 1),
                    itemBuilder: (context, index) {
                      final item = listaFiltrada[index];
                      return InkWell(
                        onTap: () {
                          // ── Navegação mantida ──────────────────────
                          // O objeto StartupDetail real do Firestore é
                          // passado diretamente para a tela de detalhes.
                          // ───────────────────────────────────────────
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StartupDetailScreen(startup: item),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  // ── SUBSTITUIÇÃO DO MOCK ───────────
                                  // Antes: Image.asset (imagens locais).
                                  // Agora: suporte a URL remota E asset.
                                  // ──────────────────────────────────
                                  child: _buildStartupImage(item.coverImageUrl),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      item.shortDescription,
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    item.stage,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Text(
                                    "ATIVA",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.home_outlined, color: Colors.white),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF512DA8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "Explorar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.grid_view, color: Colors.white),
            const Icon(Icons.person_outline, color: Colors.white),
          ],
        ),
      ),
    );
  }

  /// Decide se a imagem é um asset local ou uma URL remota.
  Widget _buildStartupImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(Icons.business, color: Color(0xFF512DA8));
    }

    // Se começa com http/https, carrega da rede (Firestore pode guardar URLs)
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.business, color: Color(0xFF512DA8)),
      );
    }

    // Caso contrário, tenta carregar como asset local
    return Image.asset(
      imageUrl,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.business, color: Color(0xFF512DA8)),
    );
  }
}
