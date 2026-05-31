// Vinícius Panutti Salgado - 25007329
// ── startups/types/index.ts ────────────────────────────────────────────
// Definições de tipos TypeScript para o módulo de startups.
//
// Tipos definidos:
//   • StartupStage          — enum de estágios (nova, em_operacao, em_expansao)
//   • QuestionVisibility    — enum de visibilidade (publica, privada)
//   • AuthenticatedUser     — subset de dados do user autenticado
//   • Founder               — dados de um fundador/sócio
//   • ExternalMember        — dados de conselheiro/mentor externo
//   • StartupDocument       — documento completo no Firestore
//   • StartupQuestionDocument — documento de pergunta na subcoleção
//   • StartupListItem       — versão resumida para listagem no catálogo
//
// Estes tipos são usados em TODOS os ficheiros do módulo startups
// para garantir type-safety e autocompletar no editor.
// ──────────────────────────────────────────────────────────────────────

import {FieldValue, Timestamp} from "firebase-admin/firestore";

/**
 * Representa os estágios de maturidade aceitos para uma startup.
 * Usados como filtro na listagem e validados contra allowedStages.
 */
export type StartupStage = "nova" | "em_operacao" | "em_expansao";

/**
 * Define o nivel de visibilidade de uma pergunta enviada à startup.
 * "publica" → visível para todos; "privada" → apenas investidores.
 */
export type QuestionVisibility = "publica" | "privada";

/**
 * Dados mínimos do usuário autenticado necessários para regras de negócio.
 * Extraídos do token JWT pelo requireAuthenticatedUser().
 */
export type AuthenticatedUser = {
  uid: string;
  email?: string;
};

/**
 * Representa um sócio, fundador ou participação societária da startup.
 * Exibido na seção "Quadro Societário" da tela de detalhes.
 */
export type Founder = {
  name: string;
  role: string;
  equityPercent: number;
  bio?: string;
};

/**
 * Representa conselheiros, mentores ou participantes externos.
 * Diferem dos Founders por não possuírem participação societária.
 */
export type ExternalMember = {
  name: string;
  role: string;
  organization?: string;
};

/**
 * Documento completo de uma startup no Firestore (coleção: startups/{id}).
 * Contém TODOS os campos necessários para a tela de detalhes,
 * incluindo founders, FAQ, vídeos demo e imagens.
 */
export type StartupDocument = {
  name: string;
  stage: StartupStage;
  shortDescription: string;
  description: string;
  executiveSummary: string;
  capitalRaisedCents: number;        // Capital em centavos (evita float)
  totalTokensIssued: number;          // Total de tokens emitidos
  currentTokenPriceCents: number;     // Preço do token em centavos
  founders: Founder[];
  externalMembers: ExternalMember[];
  demoVideos: string[];               // URLs de vídeos YouTube
  pitchDeckUrl?: string;              // URL do pitch deck (PDF/Slides)
  coverImageUrl?: string;             // Logo/ícone da startup
  headerImageUrl?: string;            // Imagem de cabeçalho
  tags: string[];                     // Tags para filtro e busca
  faq?: { text: string; answer: string }[]; // Perguntas frequentes
  createdAt?: Timestamp;              // Timestamp de criação
  updatedAt?: Timestamp;              // Timestamp de última atualização
};

/**
 * Documento de pergunta armazenado na subcoleção startups/{id}/questions.
 * Perguntas públicas aparecem na tela de detalhes.
 * Perguntas privadas aparecem no chat exclusivo de investidores.
 */
export type StartupQuestionDocument = {
  authorUid: string;                  // UID do autor da pergunta
  authorEmail?: string;               // E-mail do autor (para exibição)
  text: string;                       // Texto da pergunta
  visibility: QuestionVisibility;     // "publica" ou "privada"
  answer?: string;                    // Resposta dos fundadores (opcional)
  answeredAt?: Timestamp;             // Quando foi respondida
  createdAt: FieldValue;              // serverTimestamp() na criação
};

/**
 * Versão resumida de startup usada na listagem do catálogo.
 * Contém apenas os campos necessários para renderizar o card na lista.
 * Função toListItem() no startupRepository faz o mapeamento.
 */
export type StartupListItem = {
  id: string;
  name: string;
  stage: StartupStage;
  shortDescription: string;
  capitalRaisedCents: number;
  totalTokensIssued: number;
  currentTokenPriceCents: number;
  coverImageUrl?: string;
  tags: string[];
};
