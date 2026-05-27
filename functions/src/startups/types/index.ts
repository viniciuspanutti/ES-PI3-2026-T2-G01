import {FieldValue, Timestamp} from "firebase-admin/firestore";

/**
 * Representa os estágios de maturidade aceitos para uma startup.
 */
export type StartupStage = "nova" | "em_operacao" | "em_expansao";

/**
 * Define o nivel de visibilidade de uma pergunta enviada à startup.
 */
export type QuestionVisibility = "publica" | "privada";

/**
 * Dados mínimos do usuário autenticado necessários para regras de negócio.
 */
export type AuthenticatedUser = {
  uid: string;
  email?: string;
};

/**
 * Representa um sócio, fundador ou participação societária da startup.
 */
export type Founder = {
  name: string;
  role: string;
  equityPercent: number;
  bio?: string;
};

/**
 * Representa conselheiros, mentores ou participantes externos.
 */
export type ExternalMember = {
  name: string;
  role: string;
  organization?: string;
};

/**
 * Documento completo de uma startup no Firestore.
 */
export type StartupDocument = {
  name: string;
  stage: StartupStage;
  shortDescription: string;
  description: string;
  executiveSummary: string;
  capitalRaisedCents: number;
  totalTokensIssued: number;
  currentTokenPriceCents: number;
  founders: Founder[];
  externalMembers: ExternalMember[];
  demoVideos: string[];
  pitchDeckUrl?: string;
  coverImageUrl?: string;
  headerImageUrl?: string;
  tags: string[];
  faq?: { text: string; answer: string }[];
  createdAt?: Timestamp;
  updatedAt?: Timestamp;
};

/**
 * Documento de pergunta armazenado na subcoleção da startup.
 */
export type StartupQuestionDocument = {
  authorUid: string;
  authorEmail?: string;
  text: string;
  visibility: QuestionVisibility;
  answer?: string;
  answeredAt?: Timestamp;
  createdAt: FieldValue;
};

/**
 * Versão resumida de startup usada na listagem do catálogo.
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
