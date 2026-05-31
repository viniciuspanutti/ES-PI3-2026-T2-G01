// feito por camila fernandes costacurta RA:25012949 
 
 /** 
   * DASHBOARD DA CARTEIRA (Wallet Dashboard) 
   * 
   * Funcionalidades implementadas: 
   * - Exibição do Patrimônio Estimado total do usuário. 
   * - Listagem dinâmica de investimentos atuais (posições que o usuário já possui). 
   * - Gestão de saldo com atalhos para funções de 'Depositar' e 'Sacar'. 
   * - Integração com Firebase para carregamento de dados do perfil (nome e foto). 
   * - Controle de visibilidade do saldo (ocultar/exibir valores sensíveis). 
   */ 
  
  import 'dart:async'; // Biblioteca para operações assíncronas (permite usar Future, unawaited). 
  
  import 'package:firebase_auth/firebase_auth.dart'; // Biblioteca de Autenticação (permite usar FirebaseAuth, currentUser). 
  import 'package:firebase_core/firebase_core.dart'; // Biblioteca base do Firebase (permite usar Firebase.initializeApp). 
  import 'package:flutter/material.dart'; // Biblioteca base do Flutter (permite usar widgets como Scaffold, SafeArea, LayoutBuilder). 
  import 'package:flutter/services.dart'; // Biblioteca de serviços do sistema (permite usar SystemUiOverlayStyle). 
  import 'package:mobile/core/routes/app_routes.dart'; // Importa as rotas do app (permite usar AppRoutes). 
  import 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart'; // Importa seções de investimento (permite usar FirestoreInvestmentSections). 
  import 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart'; // Importa widgets de navegação (permite usar HomeHeader, WalletCard, QuickActions). 
  import 'package:mobile/features/startups/domain/startup.dart'; // Importa o domínio de startup (permite usar o tipo StartupDetail). 
  import 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart'; // Importa a tela de detalhes (permite usar StartupDetailScreen). 
  
  Future<bool> _initializeFirebaseIfConfigured() async { 
    //o future é um tipo de retorno, ele espera um retorno do servidor para retornar um bool, que diz se inicializou ou nao 
    //aqui começamos com future pois estamos definindo uma tarefa, um serviço rapido que a tela vai usar 
    try { 
      //try= tratamento de exceção 
      if (Firebase.apps.isEmpty) { 
        //firebase é uma classe, apps é uma lista e verificamos se esta vazia 
        await Firebase.initializeApp(); 
        //pausa a função para inicializar o app 
      } 
      return Firebase.apps.isNotEmpty; 
      //se a lista nao estiver vazia, retorna true pois ja inicializou o firebase que colocou dentro da lista um objeto 
      //se estiver vazia, retorna false 
    } catch (_) { 
      //aqui usamos um PARAMETRO DE DESCARTE, nao importa qual os dados do erro, se der qualquer um, é false 
      return false; 
    } 
  } 
  
  String? _firstString(Map<dynamic, dynamic> values, List<String> keys) { 
    // por que list? 
    //porque lista serve para dar várias chances de encontrar a informação, caso o banco de dados mude o nome das chaves. 
    //Se não tivesse a lista, 
    //você teria que chamar a função três vezes manualmente. Com a lista, o for faz esse trabalho sujo para você 
    for (final key in keys) { 
      //aqui é usado um final porque queremos que o valor nao seja alterado durante o loop 
      final value = values[key]; 
      //procuramos por um valor que esteja atribuido a uma chave 
      if (value is String && value.trim().isNotEmpty) return value.trim(); 
      //se esse valor for uma string e sem espaços e nao vazia, retorna o valor sem espaços 
    } 
    return null; 
  } 
  /**String? _firstString(Map<dynamic, dynamic> values, List<String> keys) { 
    for (int i = 0; i < keys.length; i++) { // Percorre a lista usando a posição (índice) 
      final key = keys[i]; 
      final value = values[key]; 
      
      if (value is String && value.trim().isNotEmpty) { 
        return value.trim(); 
      } 
    } 
    return null; 
  }**/ 
  /**String? _firstString(Map<dynamic, dynamic> values, List<String> keys) { 
    int i = 0; 
    while (i < keys.length) { 
      final key = keys[i]; 
      final value = values[key]; 
  
      if (value is String && value.trim().isNotEmpty) { 
        return value.trim(); 
      } 
      i++; // Não esqueça de aumentar o i, senão o app trava em loop infinito! 
    } 
    return null; 
  }**/ 
  
  String? _normalizeUserName(String? value) { 
    //aqui pega o que a funcao anterior entregou e verifica se o valor ainda existe depois de remover os espaços 
    //sim , faz o mesmo que a linha da funcao anterior, mas essa função usamos outras vezes no codigo 
    final trimmed = value?.trim(); 
    //se o valor for nulo ou vazio, retorna null 
    if (trimmed == null || trimmed.isEmpty) return null; 
    return trimmed; 
  } 
  
  String? _nameFromEmail(String? email) { 
    //o email parametro nao vem de um lugar especifico, mas sim de oned chamarmos a função 
    final rawName = email?.split('@').first.trim(); 
    //split('@') divide o email em duas partes, a primeira parte é o nome do usuario, a segunda parte é o dominio 
    if (rawName == null || rawName.isEmpty) return null; 
  
    return rawName 
    // 
        .replaceAll(RegExp(r'[._-]+'), ' ') 
        //acessamos diferentes metodos, por ex, esse troca ._- por espacos 
        //regexp é uma expressao regular, que serve para encontrar padrões em strings 
        //r = raw string Diz ao Dart para ler o que está dentro das aspas exatamente como está escrito. 
        .split(RegExp(r'\s+')) 
        //\s: É o código para "qualquer espaço em branco" (espaço simples, tabulação ou quebra de linha)., susbstiuti por nao espaço 
        .where((word) => word.isNotEmpty) 
        //o word é a variavel que demos pra cada palavra dentro da lista que o SPLIT criou 
        //verifica se nao esta vazia 
        .map((word) { 
          if (word.length == 1) return word.toUpperCase(); 
          //Vamos imaginar que você está limpando os dados e o e-mail do usuário é "a.silva@email.com". 
          //Depois que o código faz o split, ele tem uma lista com as palavras: ['a', 'silva']. 
          //pega esse a e transforma em A para que o nome do usuario seja A 
          //para a palavra silva, transforma em silva para que o nome do usuario seja Silva 
          return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'; 
        }) 
        .join(' '); 
        //cola de volta as coisas com um ESPAÇO 
        /**Entrada: "joao.vitor@email.com" 
  
  split('@').first: "joao.vitor" 
  
  replaceAll(RegExp(r'[._-]+'), ' '): "joao vitor" (trocou o ponto por espaço). 
  
  split(RegExp(r'\s+')): ['joao', 'vitor'] (virou uma lista). 
  
  where: (garantiu que não tem item vazio na lista). 
  
  map: ['Joao', 'Vitor'] (deixou as primeiras letras maiúsculas). 
  
  join(' '): "Joao Vitor" (colou tudo de volta com um espaço). 
  **/ 
  } 
  
  class WalletDashboardScreen extends StatefulWidget { 
    //essa classe ee para mostrar o dashboard do usuario 
    //ele mostra o saldo do usuario, as investimentos do usuario, e as informações do usuario 
    const WalletDashboardScreen({super.key}); 
    //ara que serve? O Flutter usa a key para identificar qual Widget é qual quando algo muda na tela. 
    // Se você tem uma lista de itens e deleta um, 
    // a key ajuda o Flutter a não se confundir e acabar deletando o item errado ou perdendo o estado da animação. 
  
    @override 
    State<WalletDashboardScreen> createState() => _WalletDashboardScreenState(); 
  } 
  
  class _WalletDashboardScreenState extends State<WalletDashboardScreen> { 
    //variaveis de estado 
    //para mostrar ou não o saldo do usuario 
    bool _showBalance = true; 
    //para mostrar ou não o nome do usuario 
    bool _showUserName = true; 
    //para mostrar ou não a foto do usuario 
    bool _didReadRouteUser = false; 
    //para armazenar o nome do usuario 
    String _userName = 'Usu\u00e1rio'; 
    //para armazenar a url da foto do usuario 
    String? _userPhotoUrl; 
  
    static const _screenBackground = Color(0xFFF5F5F5); 
    static const _primaryPurple = Color(0xFF5A2D91); 
    static const _statusBlue = Color(0xFF4169FF); 
    static const _positiveGreen = Color(0xFF18A71B); 
    static const _softCard = Color(0xFFF7F7FA); 
  
    @override 
    void didChangeDependencies() { 
      //No Flutter, quando você pula 
      //de uma tela para outra passando dados (ex: o nome do usuário), esses dados ficam guardados no ModalRoute. 
  //Para pegar esses dados, você usa: ModalRoute.of(context). 
  //O problema: Você não pode usar esse comando no initState, 
  //porque o context ainda não está "ligado" totalmente à árvore de widgets. O app daria erro. 
  //A solução: O Flutter criou o didChangeDependencies. 
  // Ele roda logo após o initState e garante que o context já está pronto para você buscar esses dados externos 
      super.didChangeDependencies(); 
      if (_didReadRouteUser) return; 
      _didReadRouteUser = true; 
      /**Primeira vez que a tela abre: _didReadRouteUser é false. O if deixa o código passar. 
  Logo em seguida: Você define _didReadRouteUser = true;. 
  O código continua: Ele lê os dados do usuário e termina. 
  Segunda vez (ex: girou o celular): O Flutter chama o didChangeDependencies de novo. 
  O bloqueio: O código bate no if (_didReadRouteUser). Como agora é true, 
  ele executa o return (que significa "sai fora daqui") e não gasta processamento repetindo o que já foi feito. */ 
      _applyRouteUserData(ModalRoute.of(context)?.settings.arguments); 
    
      //modal route e uma classe que gerencia para qual tela vai 
      //O que é: É um método estático que busca na "árvore" do Flutter a rota atual em que este Widget está vivendo. 
      //settings: É um objeto dentro da rota que guarda as configurações daquela tela, a anterior (como o nome da rota e os argumentos). 
      //arguments: Tudo o que você enviou da tela anterior via Navigator.push(..., arguments: seuMapaDeDados) está guardado aqui dentro. 
  
      unawaited(_loadFirebaseUserData()); 
      //unawaited: O app dá o "tiro de partida" na função e 
      // pula imediatamente para a próxima linha. A função fica rodando em segundo plano (background). 
      /**Conecta no Firebase. 
  
  Pega o nome e a foto do usuário logado. 
  
  Chama um setState(() { ... }). 
  
  O milagre: No momento em que o setState é chamado (mesmo que seja 3 segundos depois), 
  o Flutter redesenha a tela e o nome do usuário aparece magicamente onde antes estava escrito "Usuário". */ 
    } 
  
    void _toggleBalanceVisibility() { 
      //toogle: Alterna entre mostrar e não mostrar o saldo do usuário. 
      /**2. A lógica do !_showBalance 
  O ponto de exclamação ! em Dart é o operador de negação (ou "NOT"). 
  Se _showBalance for true, o !_showBalance vira false. 
  Se _showBalance for false, o !_showBalance vira true. 
  Então, a linha _showBalance = !_showBalance diz basicamente: "Defina o valor como o oposto do que ele é agora". */ 
      setState(() => _showBalance = !_showBalance); 
    } 
  
    void _showMessage(String message) { 
      //para mostrar mensagens como "Operação realizada com sucesso!" 
      ScaffoldMessenger.of(context) 
        ..clearSnackBars() 
        ..showSnackBar( 
          SnackBar( 
            content: Text(message), 
            behavior: SnackBarBehavior.floating, 
            duration: const Duration(milliseconds: 1600), 
            shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(14), 
            ), 
          ), 
        ); 
    } 
  
    void _openRoute(String routeName) { 
      //usamos essa função para um codigo mais limpo  e legibilidade 
      Navigator.of(context).pushNamed(routeName); 
    } 
    /**Essa função é um atalho de navegação. Ela serve para tirar o usuário da tela atual 
     (o Dashboard) e levá-lo para outra tela do aplicativo (como "Configurações", "Extrato" ou "Perfil"). 
     : O comando "push" (empurrar) coloca uma nova tela por cima da atual. Imagine que você está colocando uma folha de papel 
      nova sobre a que você estava lendo. Quando o usuário clica em "voltar", 
      o Flutter apenas "puxa" a folha de cima e a tela anterior (o Dashboard) já está lá embaixo esperando.*/ 
  
    void _openStartupDetails(StartupDetail startup) { 
      Navigator.of(context).push( 
        MaterialPageRoute<void>( 
          /**Isso é o que define a transição da tela. 
  No Android, a tela sobe de baixo para cima. 
  No iOS, ela desliza da direita para a esquerda. 
  O MaterialPageRoute cuida para que essa animação siga o padrão do sistema operacional do celular do usuário. */ 
          builder: (_) => StartupDetailScreen(startup: startup), 
          /**builder: É uma função que o Flutter chama para construir a nova tela. 
  (_): Esse "underline" é apenas um padrão para dizer que o context é passado ali, mas como você não vai usá-lo, você o ignora 
  StartupDetailScreen(startup: startup): Você está instanciando a nova tela e já "injetando" nela o objeto startup que recebeu no início. */ 
        ), 
      ); 
    }/**Essa função é bem parecida com a anterior (_openRoute), mas com uma diferença crucial: em vez de usar um "apelido" 
    (rota nomeada), ela cria a tela na hora e passa um objeto inteiro para ela. 
  Imagine que a função anterior era como mandar alguém para um endereço fixo */ 
  
    void _reloadInvestments() { 
      //O _reloadInvestments()  é uma função que sera chamada sempre depois que o usuário volta de uma tela de ação. 
      setState(() {}); 
    } 
  
    void _applyRouteUserData(Object? arguments) { 
      //Ela serve para garantir que, 
      //não importa como a tela anterior enviou os dados, o seu Dashboard consiga encontrar o nome e a foto do usuário. 
      if (arguments is! Map) return; 
      //Verifica se os dados que chegaram são um Map (um conjunto de chave e valor, tipo um dicionário). 
  
      final name = _firstString(arguments, const [ 
        //é aqui que passamos pra funcao _firstString() as chaves que devem ser procuradas. 
        //Se não tivermos uma das chaves, a função _firstString() retornará null. 
        'name', 
        'displayName', 
        'userName', 
        'nome', 
      ]); 
      final photoUrl = _firstString(arguments, const [ 
        'photoUrl', 
        'photoURL', 
        'avatarUrl', 
        'profilePhotoUrl', 
        'foto', 
      ]); 
  
      if (name == null && photoUrl == null) return; 
      _userName = _normalizeUserName(name) ?? _userName; 
      //se normalizeusername retornar null, _userName não será alterado. 
      //se normalizeusername retornar um valor, _userName será alterado para esse valor. 
      _userPhotoUrl = photoUrl ?? _userPhotoUrl; 
    } 
  
    Future<void> _loadFirebaseUserData() async { 
      //<void> nós não estamos esperando um "valor", estamos esperando um "acontecimento". 
      final initialized = await _initializeFirebaseIfConfigured().timeout( 
        //aqui estamos tentando ligar o servidor,em tum tempo de ate 6 segondos 
        const Duration(seconds: 6), 
        onTimeout: () => false, 
      ); 
      if (!initialized) return; 
  
      final user = FirebaseAuth.instance.currentUser; 
      //se não tivermos um usuário atual, retornamos null. 
      if (user == null) return; 
  
      final resolvedName = 
          _normalizeUserName(user.displayName) ?? 
          //O user.displayName é uma propriedade padrão que já vem dentro do objeto de usuário do Firebase (FirebaseAuth). 
          //Se o usuário não tiver um nome definido, ele irá usar o email como nome. 
          //se normalizeusername retornar null, _namefromemail será chamado. 
          //se _namefromemail retornar null, _normalizeusername será chamado. 
          //se _normalizeusername retornar null, _userName não será alterado. 
          //se _normalizeusername retornar um valor, _userName será alterado para esse valor. 
          _nameFromEmail(user.email) ?? 
          _normalizeUserName(user.email); 
  
      if (!mounted) return; 
      /**O problema: Quando você usa await (para esperar o Firebase, por exemplo), o tempo passa. 
      O usuário pode ter clicado no botão "Voltar" e saído da tela de Investimentos enquanto o Firebase ainda estava "pensando". */ 
      setState(() { 
        //agora que tenho os dados oficiais do Firebase, redesenhe a tela para o usuário ver!". 
        _userName = resolvedName ?? _userName; 
        //se resolvedname retornar null, _userName não será alterado. 
        //se resolvedname retornar um valor, _userName será alterado para esse valor. 
        _userPhotoUrl = user.photoURL ?? _userPhotoUrl; 
      }); 
    } 
  
  
  
    @override 
    //agora organiza tudo o que o usuário vê na tela e conecta as peças que discutimos antes (nome, foto, saldo e investimentos). 
    Widget build(BuildContext context) { 
      return AnnotatedRegion<SystemUiOverlayStyle>( 
        //annotatedregion é uma classe que permite que você configure o estilo da barra de status do dispositivo. 
        //aqui estamos configurando o estilo da barra de status do dispositivo. 
        //SystemUiOverlayStyle.dark significa que a barra de status será preta. 
        value: SystemUiOverlayStyle.dark, 
        child: Scaffold( 
          backgroundColor: _screenBackground, 
          body: SafeArea( 
            child: LayoutBuilder( 
              builder: (context, constraints) { 
                final screenWidth = constraints.maxWidth < 390 
                    ? constraints.maxWidth 
                    : 390.0; 
  
                return Align( 
                  alignment: Alignment.topCenter, 
                  child: SizedBox( 
                    width: screenWidth, 
                    height: constraints.maxHeight, 
                    child: SingleChildScrollView( 
                      physics: const BouncingScrollPhysics(), 
                      //aqui estamos configurando a física do scroll da tela. 
                      //BouncingScrollPhysics significa que o scroll será "bougu" ao chegar ao fim da tela. 
                      //Isso é uma boa prática para evitar que o usuário tenha problemas com o scroll na tela. 
                      //Se você não quiser que o scroll "bougu", você pode usar const AlwaysScrollableScrollPhysics(). 
                      //Isso fará com o que o scroll não "bougu" e o usuário não consiga chegar ao fim da tela. 
                      //Isso pode ser útil se você quiser que o usuário não consiga chegar ao fim da tela. 
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24), 
                      child: Column( 
                        crossAxisAlignment: CrossAxisAlignment.stretch, 
                        children: [ 
                          HomeHeader(//homeheader é uma classe que representa o cabeçalho da tela de carteira. 
                          //aqui estamos configurando o cabeçalho da tela de carteira. 
                            primaryPurple: _primaryPurple, 
                            userName: _userName, 
                            userPhotoUrl: _userPhotoUrl, 
                            showBalance: _showBalance, 
                            onToggleVisibility: _toggleBalanceVisibility, 
                            onNotificationsTap: () => 
                                _openRoute(AppRoutes.notificacoes), 
                                //quando o usuário clicar no botão de notificações, ele irá abrir a tela de notificações. 
                          ), 
                          const SizedBox(height: 24), 
                          WalletCard( 
                            primaryPurple: _primaryPurple, 
                            showBalance: _showBalance, 
                            onCardTap: () => _openRoute(AppRoutes.carteira), 
                            //approutes é uma classe que representa as rotas do aplicativo. 
                            //aqui estamos configurando a rota da tela de carteira. 
                            //quando o usuário clicar na cartão da carteira, ele irá abrir a tela de carteira. 
                            //carteira é 
                            onMoreTap: () => _showMessage( 
                              'Op\u00e7\u00f5es da carteira', 
                              //quando o usuário clicar no botão de mais, ele irá abrir uma mensagem com as opções da carteira. 
                            ), 
                          ), 
                          const SizedBox(height: 26), 
                          QuickActions(onRouteTap: _openRoute), 
                          const SizedBox(height: 24), 
                          FirestoreInvestmentSections( 
                            //firestoreinvestmentsections é uma classe que representa as seções de investimentos da tela de carteira. 
                            //aqui estamos configurando as seções de investimentos da tela de carteira. 
                            userId: FirebaseAuth.instance.currentUser?.uid, 
                            //userId é o ID do usuário atual. 
                            //Nós estamos usando o FirebaseAuth.instance.currentUser?.uid para obter o ID do usuário atual. 
                            backgroundColor: _softCard, 
                            statusColor: _statusBlue, 
                            growthColor: _positiveGreen, 
                            onRetry: _reloadInvestments, 
                            onViewAllTap: () => 
                                _openRoute(AppRoutes.catalogo), 
                            onStartupTap: _openStartupDetails, 
                            onMoreTap: () => _showMessage( 
                              'Op\u00e7\u00f5es dos investimentos', 
                              //quando o usuário clicar no botão de mais, ele irá abrir uma mensagem com as opções dos investimentos. 
                            ), 
                          ), 
                        ], 
                      ), 
                    ), 
                  ), 
                ); 
              }, 
            ), 
          ), 
        ), 
      ), 
    ); 
  } 
 } 

