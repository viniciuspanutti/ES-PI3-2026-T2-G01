const functions = require('firebase-functions');
const nodemailer = require('nodemailer');

exports.sendMfaEmail = functions.https.onCall(async (data, context) => {
    const email = data.email;
    const code = data.code;

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
