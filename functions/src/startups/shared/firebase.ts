// Vinícius Panutti Salgado - 25007329
// ── startups/shared/firebase.ts ────────────────────────────────────────
// Módulo de inicialização do Firebase Admin SDK para as Cloud Functions.
//
// Padrão Singleton:
//   Verifica se já existe um app Firebase inicializado (getApps().length)
//   antes de chamar initializeApp(). Isto previne o erro
//   "Firebase App already exists" que ocorre quando múltiplos módulos
//   tentam inicializar o mesmo app.
//
// Exporta instâncias reutilizáveis de:
//   • auth — Firebase Authentication Admin (verificação de tokens)
//   • db   — Firestore Admin (leitura/escrita privilegiada de dados)
// ──────────────────────────────────────────────────────────────────────

// Imports do Admin SDK modular (tree-shakeable)
import {getAuth} from "firebase-admin/auth";
import {getApps, initializeApp} from "firebase-admin/app";
import {getFirestore} from "firebase-admin/firestore";

// Verifica se já existe um app inicializado para evitar erros de duplicidade
// Isto é necessário porque o index.ts raiz também pode inicializar o app
if (getApps().length === 0) {
  initializeApp();
}

// Instância do Auth Admin — usada em requireAuthenticatedUser()
export const auth = getAuth();
// Instância do Firestore Admin — usada no startupRepository para queries
export const db = getFirestore();
