// Vinícius Panutti Salgado - 25007329
// ── app_typography.dart ────────────────────────────────────────────────
// Camada Core/Theme — Design System: Tokens de Tipografia do app.
//
// Define todos os estilos de texto reutilizáveis da aplicação:
//   heading1, heading2 — títulos de seção
//   body, bodySecondary — texto corrido
//   button — texto de botões
//   link — texto de hyperlinks
//   caption — legendas e textos pequenos
//
// Usa a fonte 'Inter' (Google Fonts) como família tipográfica padrão.
// Inter é uma fonte sans-serif otimizada para interfaces digitais,
// com excelente legibilidade em tamanhos pequenos.
//
// Todas as cores vêm de AppColors, garantindo coerência com a paleta.
// ──────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'app_colors.dart';

// ── AppTypography — Estilos de texto centralizados ───────────────────
// Classe utilitária com constantes TextStyle. Cada estilo define:
//   fontFamily, fontSize, fontWeight e color.
// Para usar: Text('Olá', style: AppTypography.heading1)
class AppTypography {
  // Família tipográfica global — 'Inter' deve estar registrada
  // no pubspec.yaml em flutter > fonts ou via google_fonts package.
  static const String fontFamily = 'Inter';

  // ── Títulos ────────────────────────────────────────────────────────
  // heading1 (24px, bold) — usado em títulos de página e seções principais
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // heading2 (20px, bold) — usado em subtítulos e cabeçalhos de cards
  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // ── Corpo de texto ─────────────────────────────────────────────────
  // body (16px, normal) — texto padrão de parágrafos e descrições
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // bodySecondary (14px, normal, cinza) — texto auxiliar e metadados
  static const TextStyle bodySecondary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // ── Botão ──────────────────────────────────────────────────────────
  // button (16px, semibold, branco) — texto de ElevatedButton/TextButton
  // Cor branca pois os botões primários têm fundo roxo (AppColors.primary)
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // ── Link ───────────────────────────────────────────────────────────
  // link (14px, azul, sublinhado) — texto clicável com underline
  static const TextStyle link = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.link,
    decoration: TextDecoration.underline,
  );

  // ── Caption ────────────────────────────────────────────────────────
  // caption (12px, cinza) — legendas, timestamps e textos muito pequenos
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}

