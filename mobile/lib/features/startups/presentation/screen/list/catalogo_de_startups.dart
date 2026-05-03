import 'package:flutter/material.dart';
import '../../../data/startup_service.dart';
import '../../../domain/startup.dart';
import 'startup_detail_screen.dart';
import 'package:mobile/core/routes/app_routes.dart';

class CatalogoStartupsPage extends StatefulWidget {
  const CatalogoStartupsPage({super.key});

  @override
  State<CatalogoStartupsPage> createState() => _CatalogoStartupsPageState();
}

class _CatalogoStartupsPageState extends State<CatalogoStartupsPage> {
  String _filtroSelecionado = 'Todas';
  final StartupService _startupService = StartupService();
  late Future<List<StartupDetail>> _startupsFuture;

  @override
  void initState() {
    super.initState();
    _startupsFuture = _startupService.getStartups();
  }

  String _normalize(String text) {
    var withDia = 'áàãâäéèêëíìîïóòõôöúùûüçÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÇ';
    var withoutDia = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'; 
    var result = text;
    for (int i = 0; i < withDia.length; i++) {
      result = result.replaceAll(withDia[i], withoutDia[i]);
    }
    return result.toLowerCase().replaceAll(' ', '_');
  }

  void _abrirFiltros() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Filtrar por Estágio", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 10,
              children: ['Todas', 'Nova', 'Em operação', 'Em expansão'].map((label) {
                final bool isSelected = _filtroSelecionado == label;
                return ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _filtroSelecionado = label);
                    Navigator.pop(context);
                  },
                  selectedColor: const Color(0xFF512DA8),
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CORREÇÃO: Restaurada a seta de voltar. 
                  // Ela usa o Smart Back para garantir que o app não feche.
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => AppRoutes.smartBack(context),
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
            Expanded(
              child: FutureBuilder<List<StartupDetail>>(
                future: _startupsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF512DA8)));
                  }
                  if (snapshot.hasError) return const Center(child: Text("Erro ao carregar startups."));
                  
                  final startups = snapshot.data ?? [];
                  final listaFiltrada = _filtroSelecionado == 'Todas'
                      ? startups
                      : startups.where((s) => _normalize(s.stage) == _normalize(_filtroSelecionado)).toList();

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: listaFiltrada.length,
                    separatorBuilder: (_, _) => Divider(color: Colors.grey.shade100, height: 1),
                    itemBuilder: (context, index) {
                      final item = listaFiltrada[index];
                      return ListTile(
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (_) => StartupDetailScreen(startup: item)));
                        },
                        leading: _buildStartupImage(item.coverImageUrl),
                        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(item.shortDescription, maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: Text(item.stage),
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

  Widget _buildStartupImage(String? imageUrl) {
    return Container(
      width: 44, height: 44,
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      child: const Icon(Icons.business, color: Color(0xFF512DA8)),
    );
  }
}
