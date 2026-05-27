/**Vinícius
 * Explicação do código ->
 */


import { setGlobalOptions } from "firebase-functions";
export * as exchange from "./exchange";
export * from "./carteira";

setGlobalOptions({ maxInstances: 10 });

export * from "./startups";

import * as functions from "firebase-functions";
import * as nodemailer from "nodemailer";

export const sendMfaEmail = functions.https.onCall(async (request) => {
    // Agora acessamos o 'data' de dentro do 'request'
    const email = request.data.email;
    const code = request.data.code;

    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'viniciuspanutti@gmail.com',
            pass: 'rirwsbqwiqsdzqnc'
        }
    });

    const mailOptions = {
        from: 'viniciuspanutti@gmail.com',
        to: email,
        subject: 'Código de Verificação MFA',
        text: `Seu código de acesso é: ${code}`
    };

    try {
        await transporter.sendMail(mailOptions);
        return { success: true };
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'Erro ao enviar email');
    }
});