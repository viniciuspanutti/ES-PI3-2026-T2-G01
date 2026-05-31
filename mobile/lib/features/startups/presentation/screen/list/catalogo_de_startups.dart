// Vinícius Panutti Salgado - 25007329
// ── catalogo_de_startups.dart ──────────────────────────────────────────
// Tela de listagem (Catálogo) de todas as startups disponíveis na plataforma.
//
// Responsabilidades:
//   1. Buscar e exibir a lista de startups reais do Firestore (StartupService).
//   2. Fornecer um filtro interativo por estágio de maturidade ('Nova', etc.).
//   3. Normalizar strings para permitir filtragem case/accent-insensitive.
//   4. Exibir cards individuais com as informações principais da startup
//      e gerenciar a navegação para a tela de detalhes (StartupDetailScreen).
//
// Padrão de Projeto Utilizado:
//   - FutureBuilder: Gerencia estados assíncronos (carregando, erro, sucesso)
//     durante a chamada ao Firebase. O carregamento de imagem também tenta
//     buscar de URL remota ou localmente como fallback (Mock vs Real).
// ───────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
// ── SUBSTITUIÇÃO DO MOCK ─────────────────────────────────────────────
// Antes:  import '../../../data/startup_mock.dart';
// Agora o catálogo consome dados reais do Firestore via StartupService.
// ─────────────────────────────────────────────────────────────────────
import '../../../data/startup_service.dart';
import '../../../domain/startup.dart';
import 'startup_detail_screen.dart';

// ── CatalogoStartupsPage — Widget Stateful ───────────────────────────
// Mantém o estado do filtro selecionado e do Future do Firestore.
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

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[áàãâä]'), 'a')
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[íìîï]'), 'i')
        .replaceAll(RegExp(r'[óòõôö]'), 'o')
        .replaceAll(RegExp(r'[úùûü]'), 'u')
        .replaceAll('ç', 'c');
  }

  String _formatStage(String stage) {
    switch (stage.toLowerCase()) {
      case 'nova':
        return 'Nova';
      case 'em_operacao':
        return 'Em operação';
      case 'em_expansao':
        return 'Em expansão';
      default:
        return stage;
    }
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
                                  _startupsFuture = _startupService
                                      .getStartups();
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
                  final String filtroNormalizado = _normalize(_filtroSelecionado);
                  final listaFiltrada = _filtroSelecionado == 'Todas'
                      ? startups
                      : startups
                            .where((s) => _normalize(s.stage) == filtroNormalizado)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    _formatStage(item.stage),
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
    final fileName = imageUrl.split('/').last;
    return Image.asset(
      'assets/images/logos/$fileName',
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.business, color: Color(0xFF512DA8)),
    );
  }
}
