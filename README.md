# ES-PI3-2026-T2-G01

## MesclaInvest — Ecossistema Digital de Investimentos
### Repositório do Projeto Integrador III - Engenharia de Software (Turma 102)

O projeto consiste no desenvolvimento de parte de um ecossistema digital de investimentos, baseado na negociação simulada de tokens que representam startups vinculadas ao Mescla — aceleradora de startups da PUC-Campinas.

Nosso objetivo é criar uma plataforma com características de uma rede social corporativa, combinando um ambiente informativo e interativo voltado para investidores.

A fase de ideação da interface, mapeamento do projeto e desenvolvimento da experiência do usuário (UX), com foco no público-alvo, teve início em 13/03/2026, durante as aulas práticas da disciplina de Experiência do Usuário para Dispositivos Móveis. Atualmente, o projeto encontra-se na transição entre a finalização do design e o início da estruturação do código.

O MesclaInvest será uma plataforma desenvolvida para o ecossistema de aceleração de startups da PUC-Campinas (Mescla). O sistema permite a navegação por um catálogo de startups, visualização de teses de investimento, vídeos de demonstração e interação via fórum de perguntas e respostas. O objetivo principal é simular um ambiente de rede social corporativa voltado para o mercado de capitais e inovação.


## Integrantes — Grupo 01

- Camila Fernandes Costacurta  
- Gabriel Aparecido Bubula  
- Guilherme Preventi Correia  
- Tom Hewtson Bean  
- Vinícius Panutti Salgado (Líder)


## Tecnologias Utilizadas

- Frontend: Flutter & Dart (Desenvolvimento Multiplataforma)
- Backend: Node.js & TypeScript (Firebase Cloud Functions)
- Banco de Dados: Firebase Firestore (NoSQL)
- Autenticação: Firebase Auth
- Versionamento: GitHub

---

## Como rodar o projeto?

Siga os passos abaixo para configurar os ambientes de Backend e Frontend e executar o sistema localmente (na sua máquina).

### 1. Clonagem e Preparação
```bash
# Clone o repositório
git clone https://github.com/viniciuspanutti/ES-PI3-2026-T2-G01.git

# Acesse a pasta do projeto
cd ES-PI3-2026-T2-G01

# Certifique-se de estar na branch de desenvolvimento
git checkout develop
```

### 2. Configuração Backend (Firebase Functions)
É necessário compilar o backend e popular o banco de dados para que as startups apareçam no aplicativo.
```bash
cd functions

# Instale as dependências do Node.js
npm install

# Compile o código TypeScript
npm run build

# Inicie o shell do Firebase para popular o banco (Seed)
firebase functions:shell

# Dentro do shell (firebase >), execute o comando de injeção:
seedStartupCatalog({ data: {} })
``` 

### 3. Execução do Frontend (Flutter)
Retorne à raiz do projeto para iniciar a interface mobile.
```bash
cd ..

# Instale as dependências do Flutter
flutter pub get

# Verifique a integridade do ambiente
flutter doctor

# Inicie o aplicativo (certifique-se de ter um emulador ou dispositivo conectado)
flutter run
```
_Este projeto é um artefato acadêmico desenvolvido para a disciplina de Projeto Integrador III da PUC-Campinas._
