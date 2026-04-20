import 'package:flutter/material.dart';

// Classe principal da sua tela de catálogo
class CatalogoStartupsPage extends StatefulWidget {
  const CatalogoStartupsPage({super.key});

  @override
  State<CatalogoStartupsPage> createState() => _CatalogoStartupsPageState();
}

class _CatalogoStartupsPageState extends State<CatalogoStartupsPage> {
  // Lista mockada com os requisitos: Nome, Descrição e Estágio
  final List<Map<String, String>> startups = [
    {'nome': 'EcoFlow', 'desc': 'Soluções de energia renovável.', 'estagio': 'Expansão'},
    {'nome': 'HealthTech', 'desc': 'IA para diagnósticos rápidos.', 'estagio': 'Operação'},
    {'nome': 'FinanciaApp', 'desc': 'Gestão financeira pessoal.', 'estagio': 'Nova'},
    {'nome': 'AgroSmart', 'desc': 'Monitoramento de safras via satélite.', 'estagio': 'Expansão'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Define o fundo branco conforme o Figma
      body: SafeArea( // Garante que o conteúdo não fique sob o notch/barra de status
        child: Column(
          children: [
            // Header com ícone de ajuste (Figma) e título centralizado
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.tune, color: Colors.black), // Ícone de filtros à esquerda
                  const Text("Startups", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Título
                  const Icon(Icons.search, color: Colors.black), // Decisão: Lupa de busca à direita
                ],
              ),
            ),

            // Filtros horizontais (Requisito: Botões de filtro)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Permite rolar os botões lateralmente
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: ['Todas', 'Nova', 'Operação', 'Expansão'].map((label) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: ActionChip( // Chip arredondado seguindo o estilo do protótipo
                        label: Text(label, style: const TextStyle(fontSize: 12)),
                        onPressed: () {}, // Lógica de filtro será implementada aqui
                        backgroundColor: Colors.white,
                        shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade300)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Lista de Cards (Requisito: Nome + Descrição + Estágio)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: startups.length,
                separatorBuilder: (_, __) => Divider(color: Colors.grey.shade100, height: 1), // Divisória discreta
                itemBuilder: (context, index) {
                  final item = startups[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        // Avatar circular para o logo (similar ao estilo das criptos na imagem)
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey.shade100,
                          child: const Icon(Icons.rocket_launch, size: 20, color: Color(0xFF512DA8)),
                        ),
                        const SizedBox(width: 15),
                        // Informações textuais da Startup
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['nome']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(item['desc']!, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                            ],
                          ),
                        ),
                        // Estágio da Startup (Alinhado à direita conforme o Figma)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(item['estagio']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                            const Text("ESTÁGIO: ATIVA", style: TextStyle(fontSize: 9, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar customizada para parecer uma pílula flutuante (conforme imagem)
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20), // Margens para o efeito flutuante
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF222222), // Cor escura do protótipo
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.home_outlined, color: Colors.white),
            // Botão "Explorar" destacado com fundo roxo
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
                  Text("Explorar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
}