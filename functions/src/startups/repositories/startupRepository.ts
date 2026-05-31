/* Vinícius Panutti Salgado - 25007329

* * Descrição ->  nossos dados das startups vindo do firestore
*
* ── startupRepository.ts — Camada de Acesso a Dados (Repository Pattern) ──
* Centraliza TODAS as operações de leitura/escrita no Firestore para o
* módulo de startups. Os handlers (Cloud Functions) NUNCA acessam o
* Firestore diretamente — sempre passam por este repositório.
*
* Padrão Repository:
*   Desacopla a lógica de negócio (handlers) da persistência (Firestore).
*   Se no futuro trocarmos o Firestore por outro banco, basta alterar
*   este ficheiro sem tocar nos handlers.
*
* Funções exportadas:
*   • listStartupItems()      — lista todas as startups (versão resumida)
*   • getStartupById(id)      — busca startup completa por ID
*   • userIsInvestor(id, uid) — verifica se user é investidor
*   • listPublicQuestions(id) — lista perguntas públicas da startup
*   • createQuestion(id, doc) — cria pergunta na subcoleção
*   • seedDemoStartups()      — popula catálogo com 5 startups demo
*/

// FieldValue para serverTimestamp, Timestamp para conversão de datas
import { FieldValue, Timestamp } from "firebase-admin/firestore";
// Tipos TypeScript para type-safety nos documentos
import {
  StartupDocument,
  StartupListItem,
  StartupQuestionDocument,
} from "../types";
// Instância singleton do Firestore Admin
import { db } from "../shared/firebase";

// Referência à coleção raiz 'startups' no Firestore
const startupsCollection = db.collection("startups");

// ── Dados demo das 5 startups do MVP ─────────────────────────────────
// Array com os documentos completos que serão inseridos no Firestore
// pela função seedDemoStartups(). Cada objeto contém todos os campos
// necessários para renderizar a tela de detalhes no Flutter.
const demoStartups: any[] = [
  {
    id: "ecocycle",
    name: "EcoCycle",
    stage: "nova",
    shortDescription: "Reciclagem inteligente recompensada por tokens.",
    description: "A EcoCycle transforma a logística reversa através de lixeiras IoT inteligentes. " +
      "Cada resíduo depositado gera um crédito tokenizado para o usuário.",
    executiveSummary: "Nossa missão é democratizar a sustentabilidad . A EcoCycle possui lixeira" +
      "inteligentes que identificam e separam recicláveis automaticamente usando visão computacio" +
      "O modelo de negócio baseia-se no licenciamento das lixeiras para condomínios e empr" +
      "gerando receita recorrente, além da comercialização do lixo limpo diretamente com a indústria de reciclagem.",
    capitalRaisedCents: 250000000,
    totalTokensIssued: 5000000,
    currentTokenPriceCents: 50,
    founders: [
      { name: "Lucas Mendes", role: "CEO", equityPercent: 40, bio: "Engenheiro Ambiental" },
      { name: "Mariana Costa", role: "CTO", equityPercent: 35, bio: "Especialista em Visão Computacional" }
    ],
    externalMembers: [
      { name: "Rafael Souza", role: "Conselheiro de Inovação", organization: "TechCorp" },
      { name: "Sônia Alves", role: "Advisor de Mercado", organization: "Green Ventures" }
    ],
    demoVideos: ["https://www.youtube.com/watch?v=fbRFauzAjOM"],
    coverImageUrl: "logotipoEcoCycle.png",
    headerImageUrl: "https://plus.unsplash.com/premium_photo-1683133531613-6a7db8847c72?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8UmVjaWNsYWdlbSUyMGludGVsaWdlbnRlfGVufDB8fDB8fHww",
    tags: ["cleantech", "iot", "sustentabilidade"],
    faq: [
      { text: "Como a lixeira reconhece o lixo?", answer: "Usamos sensores infravermelhos e uma câmera ligada a um modelo de IA treinado para mais de 5.000 tipos de embalagens." },
      { text: "Os tokens podem ser trocados por dinheiro?", answer: "Sim, os EcoTokens podem ser trocados por descontos em parceiros ou liquidados na nossa plataforma." }
    ]
  },
  {
    id: "devmatch",
    name: "DevMatch",
    stage: "em_operacao",
    shortDescription: "Recrutamento de TI impulsionado por IA e testes práticos.",
    description: "A DevMatch conecta empresas aos melhores talentos de tecnologia. Não usamos " +
      "currículos, mas sim a validação de habilidades reais em ambientes de código seguros.",
    executiveSummary: "A DevMatch revoluciona o RH tech. Nosso modelo analisa a qualidade do código, " +
      "o tempo de resolução e as melhores práticas aplicadas pelo candidato em desafios reais do dia a dia.\n\n" +
      "Monetizamos através de assinaturas SaaS para empresas contratantes e oferecemos a plataforma gratuitamente para os desenvolvedores.",
    capitalRaisedCents: 580000000,
    totalTokensIssued: 10000000,
    currentTokenPriceCents: 120,
    founders: [
      { name: "Roberto Alves", role: "CEO", equityPercent: 45 },
      { name: "Camila Rocha", role: "CTO", equityPercent: 40 }
    ],
    externalMembers: [],
    demoVideos: ["https://www.youtube.com/watch?v=0sJVvYuw-bo"],
    coverImageUrl: "logotipoDevMatch.png",
    headerImageUrl: "https://images.unsplash.com/photo-1733826544839-2282050204e6?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    tags: ["hrtech", "ia", "recrutamento"],
    faq: [
      { text: "Quais linguagens são suportadas?", answer: "Atualmente suportamos testes em Python, JavaScript, Java, C#, Go, Rust e Dart." },
      { text: "A IA avalia soft skills?", answer: "Ainda não, nosso foco atual é 100% na precisão da avaliação de hard skills e arquitetura de software." }
    ]
  },
  {
    id: "healthbit",
    name: "HealthBit",
    stage: "em_expansao",
    shortDescription: "Wearables de baixo custo para monitoramento cardíaco.",
    description: "HealthBit produz anéis inteligentes capazes de detectar arritmias e anomalias " +
      "cardíacas antes que se tornem problemas graves.",
    executiveSummary: "O HealthBit democratiza a saúde preventiva. Nossos wearables custam uma fração do preço " +
      "dos smartwatches premium, focando exclusivamente na precisão dos dados biométricos vitais.\n\n" +
      "Atendemos o cliente final (B2C) e vendemos pacotes corporativos (B2B) para planos de saúde que desejam reduzir sinistros através da prevenção.",
    capitalRaisedCents: 1250000000,
    totalTokensIssued: 25000000,
    currentTokenPriceCents: 215,
    founders: [
      { name: "Dra. Julia Ramos", role: "CEO", equityPercent: 30 },
      { name: "Felipe Nunes", role: "CTO", equityPercent: 30 },
      { name: "Carlos Eduardo", role: "COO", equityPercent: 20 }
    ],
    externalMembers: [
      { name: "Luis Gonzalez", role: "Ortopedista", organization: "Hospital Sírio-Libanês" }
    ],
    demoVideos: ["https://www.youtube.com/watch?v=uMQX1sCtfa0"],
    coverImageUrl: "logotipoHealthBit.png",
    headerImageUrl: "https://plus.unsplash.com/premium_photo-1726869610210-de13ad4cf226?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    tags: ["healthtech", "hardware", "medicina"],
    faq: [
      { text: "O anel é à prova d'água?", answer: "Sim, possui certificação IP68, podendo ser usado no banho e na piscina." },
      { text: "Possui aprovação da Anvisa?", answer: "Nossos produtos estão em fase final de certificação pela Anvisa e pelo FDA." }
    ]
  },
  {
    id: "smartcampus",
    name: "SmartCampus",
    stage: "nova",
    shortDescription: "Gestão inteligente de eficiência energética para universidades.",
    description: "Sistema IoT de ponta a ponta que automatiza o uso de ar condicionado, " +
      "iluminação e equipamentos laboratoriais de acordo com a ocupação do ambiente.",
    executiveSummary: "A SmartCampus visa zerar o desperdício de energia em instituições de ensino. " +
      "O sistema cruza a grade curricular com os sensores de presença para desligar equipamentos em salas vazias.\n\n" +
      "Nosso lucro vem de uma taxa fixa mensal somada a um percentual do valor de energia economizado pela instituição (modelo de performance).",
    capitalRaisedCents: 120000000,
    totalTokensIssued: 2000000,
    currentTokenPriceCents: 85,
    founders: [
      { name: "Tiago Pereira", role: "CEO", equityPercent: 60 },
      { name: "Amanda Silva", role: "CFO", equityPercent: 30 }
    ],
    externalMembers: [],
    demoVideos: ["https://www.youtube.com/watch?v=ErkxOEXa3YY"],
    coverImageUrl: "logotipoSmartCampus.png",
    headerImageUrl: "https://media.istockphoto.com/id/2261443769/pt/foto/women-searching-for-information-on-their-smartphones-women-exchanging-information.webp?a=1&b=1&s=612x612&w=0&k=20&c=KocsZOIzt8k90gPhKm3q3xcMLHY-5lMhqeAqF65A1hA=",
    tags: ["edtech", "iot", "greentech"],
    faq: [
      { text: "Funciona em prédios antigos?", answer: "Sim, usamos redes sem fio (LoRaWAN) que não exigem quebra de paredes para instalação." },
      { text: "Qual a economia média?", answer: "Nossos pilotos mostraram uma redução de 22% a 35% na conta de luz." }
    ]
  },
  {
    id: "agrisense",
    name: "AgriSense",
    stage: "em_operacao",
    shortDescription: "Drones autônomos para pulverização de precisão.",
    description: "Nós usamos enxames de drones para identificar pragas através de imagem " +
      "multiespectral e aplicar defensivos apenas onde é necessário.",
    executiveSummary: "A AgriSense une o agronegócio à robótica avançada. Nossa frota de drones mapeia a fazenda de manhã " +
      "e atua a tarde com pulverização cirúrgica, reduzindo em até 70% o uso de produtos químicos.\n\n" +
      "Oferecemos o serviço sob demanda (Drone-as-a-Service) e também vendemos o software de IA em regime de licenciamento para grandes produtores.",
    capitalRaisedCents: 890000000,
    totalTokensIssued: 15000000,
    currentTokenPriceCents: 175,
    founders: [
      { name: "Henrique Faria", role: "CEO", equityPercent: 50 },
      { name: "Sofia Martins", role: "Engenheira Chefe", equityPercent: 35 }
    ],
    externalMembers: [
      { name: "Roberto Carlos", role: "Consultor Agronômico", organization: "Agronegócio" }
    ],
    demoVideos: ["https://www.youtube.com/watch?v=_xRyePvaMqU&t=79s"],
    coverImageUrl: "logotipoAgriSense.png",
    headerImageUrl: "https://media.istockphoto.com/id/1364083209/pt/foto/technology-in-the-field-digital-tablet.webp?a=1&b=1&s=612x612&w=0&k=20&c=NKzwPezghp4QdL2dJ3x5pbg_A0mxkzBV4Xuf6vIba5M=",
    tags: ["agrotech", "drones", "ia"],
    faq: [
      { text: "Os drones precisam de piloto?", answer: "Não, o voo é 100% autônomo baseado no mapeamento prévio da área." },
      { text: "Como lidam com ventos fortes?", answer: "Nosso sistema aborta missões automaticamente caso o vento ultrapasse a margem segura de aplicação." }
    ]
  }
];

// ── toListItem — Mapeia documento completo para versão resumida ──────
// Extrai apenas os campos necessários para o card na lista do catálogo.
// Isto reduz o payload enviado ao Flutter (não envia FAQ, founders, etc.)
function toListItem(id: string, startup: StartupDocument): StartupListItem {
  return {
    id,
    name: startup.name,
    stage: startup.stage,
    shortDescription: startup.shortDescription,
    capitalRaisedCents: startup.capitalRaisedCents,
    totalTokensIssued: startup.totalTokensIssued,
    currentTokenPriceCents: startup.currentTokenPriceCents,
    coverImageUrl: startup.coverImageUrl,
    tags: startup.tags,
  };
}
// ── listStartupItems — Lista todas as startups (versão card) ─────────
// Busca até 100 documentos da coleção startups e mapeia cada um
// para StartupListItem via toListItem(). Usado pela Cloud Function listStartups.
export async function listStartupItems(): Promise<StartupListItem[]> {
  const snapshot = await startupsCollection.limit(100).get();
  return snapshot.docs.map((doc) =>
    toListItem(doc.id, doc.data() as StartupDocument)
  );
}
// ── getStartupById — Busca startup completa por ID ──────────────────
// Retorna o documento completo (StartupDocument) ou undefined se não existir.
// Usado pelo getStartupDetails handler para a tela de detalhes.
export async function getStartupById(
  startupId: string
): Promise<StartupDocument | undefined> {
  const startupSnapshot = await startupsCollection.doc(startupId).get();
  if (!startupSnapshot.exists) {
    return undefined;
  }
  return startupSnapshot.data() as StartupDocument;
}
// ── userIsInvestor — Verifica se o user é investidor da startup ──────
// Consulta a subcoleção investors/{uid} da startup.
// Retorna true se o documento existir (o user investiu nesta startup).
// Usado para controle de acesso a perguntas privadas e chat exclusivo.
export async function userIsInvestor(
  startupId: string,
  uid: string
): Promise<boolean> {
  const investorSnapshot = await startupsCollection
    .doc(startupId)
    .collection("investors")
    .doc(uid)
    .get();
  return investorSnapshot.exists;
}
// ── listPublicQuestions — Lista perguntas públicas de uma startup ────
// Query Firestore com filtro visibility == "publica" e limit 50.
// Converte Timestamps para ISO strings e ordena por data descendente
// (mais recentes primeiro) em memória.
export async function listPublicQuestions(startupId: string) {
  const questionsSnapshot = await startupsCollection
    .doc(startupId)
    .collection("questions")
    .where("visibility", "==", "publica")
    .limit(50)
    .get();
  return questionsSnapshot.docs
    .map((doc) => ({
      id: doc.id,
      text: doc.get("text"),
      answer: doc.get("answer") ?? null,
      // Conversão segura de Timestamp → ISO string (com optional chaining)
      answeredAt: doc.get("answeredAt")?.toDate?.()?.toISOString?.() ?? null,
      createdAt: doc.get("createdAt")?.toDate?.()?.toISOString?.() ?? null,
    }))
    // Ordena por data descendente (mais recentes primeiro)
    .sort((left, right) => String(right.createdAt ?? "").localeCompare(String(left.createdAt ?? "")));
}
// ── createQuestion — Cria uma nova pergunta na subcoleção ────────────
// Adiciona um documento na subcoleção questions da startup.
// .add() gera um ID automático e retorna a referência do documento.
// Retorna o ID gerado para confirmação ao Flutter.
export async function createQuestion(
  startupId: string,
  question: StartupQuestionDocument
): Promise<string> {
  const questionRef = await startupsCollection
    .doc(startupId)
    .collection("questions")
    .add(question);
  return questionRef.id;
}
// ── Dados iniciais do pool de Exchange (AMM) ────────────────────────
// Cada startup tem um pool de liquidez com:
//   tokensDisponiveis  — tokens iniciais disponíveis para compra
//   capitalArrecadado  — capital inicial no pool (R$)
//   precoAtual         — preço calculado (capital / tokens)
//   variacao           — variação percentual (0% no seed)
//
// Deploy:
//   npm run build && firebase deploy --only functions
//   curl -X POST https://seedstartupcatalog-sc2mrqrvtq-uc.a.run.app \
//     -H "Content-Type: application/json" -d '{"data": {}}'
const exchangeSeedData: Record<string, { tokensDisponiveis: number; capitalArrecadado: number; precoAtual: number; variacao: number }> = {
  agrisense: { tokensDisponiveis: 10000, capitalArrecadado: 50000.0, precoAtual: 5.0, variacao: 0 },
  devmatch: { tokensDisponiveis: 50000, capitalArrecadado: 75000.0, precoAtual: 11.5, variacao: 0 },
  ecocycle: { tokensDisponiveis: 20000, capitalArrecadado: 60000.0, precoAtual: 7.5, variacao: 0 },
  healthbit: { tokensDisponiveis: 5000, capitalArrecadado: 40000.0, precoAtual: 8.0, variacao: 0 },
  smartcampus: { tokensDisponiveis: 100000, capitalArrecadado: 100000.0, precoAtual: 10.0, variacao: 0 }
};

// ── seedDemoStartups — Popula Firestore com dados demo ──────────────
// Usa Firestore Batch Write para inserir atomicamente:
//   • 5 documentos na coleção startups (dados completos)
//   • 5 documentos na coleção exchange (pools de liquidez AMM)
//   • 365 × 5 = 1825 documentos de histórico de preços
//
// O histórico de preços é simulado usando Movimento Browniano
// Geométrico (GBM), o mesmo modelo matemático usado para simular
// preços de ações no mercado financeiro.
export async function seedDemoStartups(): Promise<string[]> {
  // Batch write: todas as operações são executadas atomicamente
  const batch = db.batch();
  const exchangeCollection = db.collection("exchange");

  for (const startup of demoStartups) {
    // Referência ao documento da startup (ID definido pelo array)
    const startupRef = startupsCollection.doc(startup.id);
    // Desestrutura para separar o ID dos dados (ID já está no doc path)
    const { id, ...data } = startup;

    // Insere dados da startup com timestamps de servidor
    // merge: true preserva dados existentes se o documento já existir
    batch.set(startupRef, {
      ...data,
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
    }, { merge: true });

    // Insere dados do pool de liquidez na coleção exchange
    const exchangeData = exchangeSeedData[startup.id];
    if (exchangeData) {
      const exchangeRef = exchangeCollection.doc(startup.id);
      batch.set(exchangeRef, {
        ...exchangeData,
        createdAt: FieldValue.serverTimestamp(),
        updatedAt: FieldValue.serverTimestamp(),
      }, { merge: true });

      // ── Geração de 365 dias de histórico de preços ─────────────────
      // Cria um documento por dia na subcoleção historicoPrecos,
      // permitindo que o frontend renderize gráficos de evolução de preço.
      const historicoCollection = exchangeRef.collection("historicoPrecos");
      const today = new Date();
      let precoSimulado = 5.0; // Preço base inicial de R$ 5.00
      // Seed determinístico baseado no comprimento do ID da startup
      // (garante que cada startup tenha uma curva de preço diferente)
      const seedVal = startup.id.length + 10;

      for (let i = 0; i <= 365; i++) {
        // Calcula a data retroativa (hoje - i dias)
        const d = new Date(today.getTime() - i * 24 * 60 * 60 * 1000);
        const yyyy = d.getFullYear();
        const mm = String(d.getMonth() + 1).padStart(2, '0');
        const dd = String(d.getDate()).padStart(2, '0');
        // ID do documento = data formatada (ex: "2026-05-31")
        const dataDoc = `${yyyy}-${mm}-${dd}`;

        batch.set(historicoCollection.doc(dataDoc), {
          data: Timestamp.fromDate(d),
          preco: Number(precoSimulado.toFixed(4))
        });

        // ── Movimento Browniano Geométrico (GBM) reverso ─────────────
        // Simula variações diárias de preço usando uma função
        // pseudo-aleatória determinística baseada em sin().
        // Math.sin(seed + i) gera valores entre -1 e 1 de forma
        // determinística (mesmo seed = mesma curva sempre).
        const rand = Math.sin(seedVal + i) * 10000;
        // Extrai a parte fracionária para obter um valor uniforme [0,1)
        const uniform = rand - Math.floor(rand);
        // Converte para um "choque" de -5% a +5% no preço
        const shock = (uniform - 0.5) * 0.1; // variação de -5% a +5%

        // Aplica o choque ao preço (multiplicativo, como no mercado real)
        precoSimulado = precoSimulado * (1 - shock);
        // Garante que o preço nunca fique negativo ou zero
        if (precoSimulado <= 0) precoSimulado = 0.01;
      }
    }
  }
  // Executa todas as escritas atomicamente
  await batch.commit();
  // Retorna os IDs das startups criadas para confirmação
  return demoStartups.map((startup) => startup.id);
}