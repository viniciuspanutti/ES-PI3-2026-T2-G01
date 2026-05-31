/* Vinícius Panutti Salgado - 25007329

 * Explicação do código ->
 *
 * ── index.ts — Entrypoint principal das Firebase Cloud Functions ─────
 * Este é o ficheiro raiz que o Firebase Functions SDK procura ao fazer
 * deploy. Todas as Cloud Functions exportadas aqui ficam disponíveis
 * como endpoints HTTPS ou triggers no projeto Firebase.
 *
 * Módulos exportados:
 *   • exchange — buyTokens e sellTokens (AMM de tokens)
 *   • carteira — criarCarteira, buscarSaldo, depositar, sacar
 *   • startups — CRUD de startups, perguntas e seed do catálogo
 *   • sendMfaEmail — envio de códigos OTP via Nodemailer (definido inline)
 *
 * Configuração global:
 *   maxInstances: 10 — limita o número máximo de instâncias simultâneas
 *   de TODAS as functions, prevenindo gastos excessivos no plano Blaze.
 */


// setGlobalOptions aplica configurações a TODAS as functions do projeto
import { setGlobalOptions } from "firebase-functions";
// Exporta o módulo de exchange como namespace (exchange.buyTokens, exchange.sellTokens)
export * as exchange from "./exchange";
// Exporta as functions da carteira diretamente (criarCarteira, buscarSaldo, etc.)
export * from "./carteira";

// Limita a 10 instâncias simultâneas para controle de custos no Firebase
setGlobalOptions({ maxInstances: 10 });

// Exporta as functions de startups (listStartups, getStartupDetails, etc.)
export * from "./startups";

// SDK do Firebase Functions para onCall e HttpsError
import * as functions from "firebase-functions";
// Nodemailer — biblioteca Node.js para envio de e-mails via SMTP
import * as nodemailer from "nodemailer";

// ── sendMfaEmail — Cloud Function para envio de código OTP ───────────
// Chamada pelo EmailService do Flutter quando o MFA está ativado.
// Recebe {email, code} e envia um e-mail com o código de verificação.
//
// Fluxo completo:
//   1. login_screen.dart gera código aleatório de 6 dígitos
//   2. Flutter chama EmailService.sendOTP(email, code)
//   3. Esta function recebe os dados e configura o Nodemailer
//   4. Nodemailer usa SMTP do Gmail para enviar o e-mail
//   5. Utilizador insere o código na MfaVerificationScreen
export const sendMfaEmail = functions.https.onCall(async (request) => {
    // Extrai e-mail destino e código OTP do payload enviado pelo Flutter
    // Agora acessamos o 'data' de dentro do 'request'
    const email = request.data.email;
    const code = request.data.code;

    // Configura o transporter SMTP usando credenciais do Gmail.
    // NOTA: Em produção, estas credenciais deveriam estar em
    // environment variables (functions.config()) e não hardcoded.
    // Para o MVP acadêmico, estão inline por simplicidade.
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'viniciuspanutti@gmail.com',
            pass: 'rirwsbqwiqsdzqnc'
        }
    });

    // Monta o objeto de opções do e-mail
    const mailOptions = {
        from: 'viniciuspanutti@gmail.com',  // Remetente
        to: email,                           // Destinatário (e-mail do utilizador)
        subject: 'Código de Verificação MFA', // Assunto
        text: `Seu código de acesso é: ${code}` // Corpo em texto plano
    };

    try {
        // Envia o e-mail via SMTP Gmail
        await transporter.sendMail(mailOptions);
        // Retorna sucesso ao Flutter
        return { success: true };
    } catch (error) {
        // Em caso de falha (SMTP down, credenciais inválidas, etc.)
        throw new functions.https.HttpsError('internal', 'Erro ao enviar email');
    }
});