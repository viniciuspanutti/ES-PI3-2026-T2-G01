import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/perg_e_resp.dart/componentes/botao_voltar_menu.dart';
import 'package:mobile/features/perg_e_resp.dart/componentes/seta_voltar.dart';

class PerguntasRespostasPage extends StatefulWidget {
  const PerguntasRespostasPage({super.key});

  @override
  State<PerguntasRespostasPage> createState() =>
      _PerguntasRespostasPageState();
}

class _PerguntasRespostasPageState
    extends State<PerguntasRespostasPage> {
  final List<String> startups = [
    "Ethereum",
    "Bitcoin",
    "Tether",
    "Solana",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // TOPO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SetaVoltar(
                    ontap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Perguntas e Respostas",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // LISTA
            Expanded(
              child: ListView.builder(
                itemCount: startups.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.deepPurple.withOpacity(0.2),
                            child: Icon(Icons.currency_bitcoin,
                                color: Colors.deepPurple),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              startups[index],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      PerguntasRespostasChatPage(
                                    nome: startups[index],
                                  ),
                                ),
                              );
                            },
                            child: Text("Perguntar"),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // BOTÃO INFERIOR
            BotaoVoltarMenu(),
          ],
        ),
      ),
    );
  }
}

// =======================
// CHAT
// =======================

class PerguntasRespostasChatPage extends StatefulWidget {
  final String nome;

  const PerguntasRespostasChatPage({super.key, required this.nome});

  @override
  State<PerguntasRespostasChatPage> createState() =>
      _PerguntasRespostasChatPageState();
}

class _PerguntasRespostasChatPageState
    extends State<PerguntasRespostasChatPage> {
  final TextEditingController controller = TextEditingController();

  List<Map<String, dynamic>> mensagens = [];

  @override
  void initState() {
    super.initState();

    mensagens = [
      {
        "texto": "Olá, gostaria de saber mais sobre ${widget.nome}.",
        "usuario": true
      },
      {
        "texto":
            "Claro! ${widget.nome} é uma criptomoeda/plataforma blockchain.",
        "usuario": false
      },
    ];
  }

  void enviarMensagem() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      mensagens.add({
        "texto": controller.text,
        "usuario": true,
      });
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // TOPO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SetaVoltar(
                    ontap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.nome,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // MENSAGENS
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: mensagens.length,
                itemBuilder: (context, index) {
                  final msg = mensagens[index];

                  return Align(
                    alignment: msg["usuario"]
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: msg["usuario"]
                            ? Colors.deepPurple
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        msg["texto"],
                        style: TextStyle(
                          color: msg["usuario"]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // INPUT
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Faça sua pergunta...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.deepPurple),
                    onPressed: enviarMensagem,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}