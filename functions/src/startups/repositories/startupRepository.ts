/**Vinicius
* * Descrição ->  nossos dados das startups vindo do firestore
*/

import { FieldValue } from "firebase-admin/firestore";
import {
  StartupDocument,
  StartupListItem,
  StartupQuestionDocument,
} from "../types";
import { db } from "../shared/firebase";

const startupsCollection = db.collection("startups");

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

/**Esta segunda parte faz o seguinte: Ela define o objeto StartupListItem, que é uma interface
 * yque define os campos que serão usados na lista de startups */

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
export async function listStartupItems(): Promise<StartupListItem[]> {
  const snapshot = await startupsCollection.limit(100).get();
  return snapshot.docs.map((doc) =>
    toListItem(doc.id, doc.data() as StartupDocument)
  );
}
export async function getStartupById(
  startupId: string
): Promise<StartupDocument | undefined> {
  const startupSnapshot = await startupsCollection.doc(startupId).get();
  if (!startupSnapshot.exists) {
    return undefined;
  }
  return startupSnapshot.data() as StartupDocument;
}
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
      answeredAt: doc.get("answeredAt")?.toDate?.()?.toISOString?.() ?? null,
      createdAt: doc.get("createdAt")?.toDate?.()?.toISOString?.() ?? null,
    }))
    .sort((left, right) => String(right.createdAt ?? "").localeCompare(String(left.createdAt ?? "")));
}
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
export async function seedDemoStartups(): Promise<string[]> {
  const batch = db.batch();
  for (const startup of demoStartups) {
    const startupRef = startupsCollection.doc(startup.id);
    const { id, ...data } = startup;
    batch.set(startupRef, {
      ...data,
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
    }, { merge: true });
  }
  await batch.commit();
  return demoStartups.map((startup) => startup.id);
}