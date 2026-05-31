// Vinícius Panutti Salgado - 25007329
// ── app_colors.dart ────────────────────────────────────────────────────
// Camada Core/Theme — Design System: Tokens de Cor da aplicação.
//
// Todas as cores utilizadas na interface devem ser referenciadas a
// partir desta classe. Isto garante consistência visual em todo o app
// e facilita futuras alterações de marca (basta alterar os valores aqui).
//
// Convenção de nomenclatura:
//   • primary — cor principal da marca (roxa MesclaInvest)
//   • white/grey — cores neutras para fundos e bordas
//   • link — cor de links clicáveis (azul padrão)
//   • background — cor de fundo padrão das telas
//   • textPrimary/textSecondary — cores para texto principal e auxiliar
// ──────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

// ── AppColors — Paleta de cores centralizada ─────────────────────────
// Classe utilitária com constantes estáticas. Não deve ser instanciada.
class AppColors {
  // Primária — roxo escuro que identifica a marca MesclaInvest.
  // Usado em botões, AppBars, ícones de destaque e elementos de ação.
  static const Color primary = Color(0xFF4B2C82);

  // Neutras — branco puro e cinza médio para fundos, bordas e divisores.
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9F9F9F);

  // Ação / Link — azul padrão para textos clicáveis e hyperlinks.
  // Segue a convenção web de azul para elementos interativos.
  static const Color link = Color(0xFF0066FF);

  // Background — cor de fundo padrão das telas (branco).
  // Separado do `white` para permitir alterar fundos sem afetar outros usos.
  static const Color background = Color(0xFFFFFFFF);

  // Texto — preto para conteúdo principal, cinza para conteúdo secundário.
  // textSecondary é usado em legendas, subtítulos e labels auxiliares.
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF9F9F9F);
}

