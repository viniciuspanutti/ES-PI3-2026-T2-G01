import '../domain/startup.dart';

class StartupMock {
  static List<StartupDetail> get allStartups => [
        ecoCycleSample,
        devMatchSample,
        healthBitSample,
        agriSenseSample,
        smartCampusSample,
      ];

  static StartupDetail get ecoCycleSample => StartupDetail(
        id: '1',
        name: 'EcoCycle',
        stage: 'Nova',
        shortDescription: 'Gamificação de reciclagem na PUC com créditos na cantina.',
        description: 'Solução para incentivar a reciclagem no campus.',
        capitalRaisedCents: 5000000,
        totalTokensIssued: 1000,
        currentTokenPriceCents: 5000,
        tags: ['Sustentabilidade', 'IoT'],
        executiveSummary: 'O EcoCycle utiliza gamificação para transformar o hábito de reciclar em créditos que podem ser usados na cantina da PUC-Campinas. Nossa tecnologia IoT identifica o descarte correto e recompensa o usuário instantaneamente.',
        faq: [
          {'question': 'Como ganho créditos?', 'answer': 'Basta depositar materiais recicláveis nas máquinas identificadas com o selo EcoCycle e validar seu QR Code.'},
          {'question': 'Onde posso usar os créditos?', 'answer': 'Atualmente em todas as cantinas do Campus I e II.'}
        ],
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        society: [
          {'name': 'Ana Silva', 'role': 'CEO', 'percentage': 51.0},
          {'name': 'Bruno Santos', 'role': 'CTO', 'percentage': 49.0},
        ],
        access: {},
        coverImageUrl: 'assets/images/logos/logotipoEcoCycle.png',
      );

  static StartupDetail get devMatchSample => StartupDetail(
        id: '2',
        name: 'DevMatch',
        stage: 'Em operação',
        shortDescription: 'Conecta alunos de TI a projetos e startups do Mescla.',
        description: 'Plataforma de matchmaking para tecnologia.',
        capitalRaisedCents: 2000000,
        totalTokensIssued: 500,
        currentTokenPriceCents: 4000,
        tags: ['Educação', 'Tecnologia'],
        executiveSummary: 'O DevMatch é o Tinder dos desenvolvedores da PUC. Conectamos talentos que buscam experiência com projetos reais que precisam de braço técnico.',
        faq: [
          {'question': 'Preciso pagar para usar?', 'answer': 'Não, para alunos da PUC a plataforma é totalmente gratuita.'}
        ],
        videoUrl: null,
        society: [
          {'name': 'Carlos Oliveira', 'role': 'Fundador', 'percentage': 100.0},
        ],
        access: {},
        coverImageUrl: 'assets/images/logos/logotipoDevMatch.png',
      );

  static StartupDetail get healthBitSample => StartupDetail(
        id: '3',
        name: 'HealthBit',
        stage: 'Em expansão',
        shortDescription: 'Monitoramento IoT de postura com alertas no celular.',
        description: 'Dispositivo vestível para saúde.',
        capitalRaisedCents: 3000000,
        totalTokensIssued: 800,
        currentTokenPriceCents: 4500,
        tags: ['Saúde', 'IoT'],
        executiveSummary: 'Utilizamos sensores vestíveis para corrigir a postura de estudantes e trabalhadores em tempo real, prevenindo doenças crônicas na coluna.',
        faq: [
          {'question': 'O sensor é confortável?', 'answer': 'Sim, ele é menor que uma moeda de 1 real e pode ser fixado na roupa.'}
        ],
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        society: [
          {'name': 'Daniela Lima', 'role': 'CPO', 'percentage': 40.0},
          {'name': 'Eduardo Costa', 'role': 'CEO', 'percentage': 60.0},
        ],
        access: {},
        coverImageUrl: 'assets/images/logos/logotipoHealthBit.png',
      );

  static StartupDetail get agriSenseSample => StartupDetail(
        id: '4',
        name: 'AgriSense',
        stage: 'Em operação',
        shortDescription: 'Sensores de umidade de baixo custo para pequenos produtores.',
        description: 'Tecnologia para o campo.',
        capitalRaisedCents: 1500000,
        totalTokensIssued: 300,
        currentTokenPriceCents: 3000,
        tags: ['Agro', 'Sensores'],
        executiveSummary: 'Democratizamos a tecnologia no campo com sensores de umidade de solo acessíveis, integrados via LoRaWAN para longas distâncias.',
        faq: [
          {'question': 'Qual a durabilidade da bateria?', 'answer': 'Nossos sensores operam por até 2 anos com uma única carga.'}
        ],
        videoUrl: null,
        society: [
          {'name': 'Fabio Junior', 'role': 'Agrônomo Chefe', 'percentage': 30.0},
          {'name': 'Gabriel Mello', 'role': 'CEO', 'percentage': 70.0},
        ],
        access: {},
        coverImageUrl: 'assets/images/logos/logotipoAgriSense.png',
      );

  static StartupDetail get smartCampusSample => StartupDetail(
        id: '5',
        name: 'SmartCampus',
        stage: 'Nova',
        shortDescription: 'Reserva de salas e labs via QR Code em tempo real.',
        description: 'Gestão de espaços universitários.',
        capitalRaisedCents: 1000000,
        totalTokensIssued: 200,
        currentTokenPriceCents: 2500,
        tags: ['Educação', 'Gestão'],
        executiveSummary: 'Otimizamos o uso de espaços físicos na universidade através de um sistema inteligente de reservas e ocupação em tempo real.',
        faq: [
          {'question': 'Como faço uma reserva?', 'answer': 'Aponte a câmera para o QR Code na porta da sala ou use o mapa no app.'}
        ],
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        society: [
          {'name': 'Helena Rocha', 'role': 'CEO', 'percentage': 50.0},
          {'name': 'Igor Ramos', 'role': 'CTO', 'percentage': 50.0},
        ],
        access: {},
        coverImageUrl: 'assets/images/logos/logotipoSmartCampus.png',
      );
}
