// Vinícius Panutti Salgado - 25007329
// ── startups/shared/validation.ts ──────────────────────────────────────
// Módulo utilitário de validação e sanitização de strings.
//
// normalizeString() é chamada em TODOS os handlers antes de processar
// os parâmetros recebidos do Flutter. Garante que:
//   1. Valores não-string (null, undefined, number) retornam undefined
//   2. Strings com apenas espaços retornam undefined
//   3. Strings válidas são trimadas (espaços removidos nas bordas)
//
// Isto previne erros de "invalid argument" e ataques de injeção de
// espaços em branco que poderiam criar documentos fantasma no Firestore.
// ──────────────────────────────────────────────────────────────────────

// ── normalizeString — Sanitiza e valida entrada string ───────────────
// Retorna a string trimada se válida, ou undefined se inválida/vazia.
// O tipo de retorno `string | undefined` permite uso com optional chaining.
export function normalizeString(value: unknown): string | undefined {
  // Rejeita qualquer valor que não seja string (null, number, boolean, etc.)
  if (typeof value !== "string") {
    return undefined;
  }
  // Remove espaços em branco no início e fim
  const trimmed = value.trim();
  // Retorna undefined para strings vazias (apenas espaços)
  return trimmed.length > 0 ? trimmed : undefined;
}
