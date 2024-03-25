enum EnumErrorCode {
  // 01000 - General errors
  // 01100 - From map error

  e01102,

  // 02500 - Cubit errors
  // 02510 - Cubit device
  e02511,
  // 02700 - Usecase errors
  // 02710 - Usecase create device
  e02711,

  // 04000 - Flespi Platform errors
  // 04100 - Flespi token
  // 04200 - Flespi device
  e04210,
  e04211,
  e04220,
  // 04300 - Flespi channel
  e04301,
  // 04400 - Flespi command
  e04410,
  e04420,
  // 04450 - Flespi SMS
  e04450,

  // 04500 - Flespi service
  e04501,
  e04502,
  e04503,
  e04504,
  e04505,
  e04510,
  e04520,
  // 04600 - Flespi calculator
  e04602,
  e04610,
  // 05000 - Firebase errors
  // 05100 - Firebase device
  e05101,
  e05102,
  e05103,
  e05104,
  // 05200 - Firebase user
  // 05205 - Firebase user already exists
  e05205,

  // 06100 - Google auth
  e06101,

  unknown,
  empty,
}

extension EnumErrorCodeExtension on EnumErrorCode {
  String get description {
    switch (this) {
      case EnumErrorCode.e01102:
        return 'Erro ao converter dados';
      case EnumErrorCode.e02511:
        return 'Dispositivo não encontrado - (cubit)';
      case EnumErrorCode.e02711:
        return 'Não foi possível criar o dispositivo - (usecase)';
      case EnumErrorCode.e04210:
        return 'Dispositivo não encontrado - (flespi)';
      case EnumErrorCode.e04211:
        return 'Canal não encontrado - (flespi)';
      case EnumErrorCode.e04220:
        return 'Não foi possível excluir o dispositivo - (flespi)';
      case EnumErrorCode.e04301:
        return 'Não foi possível excluir o canal - (flespi)';
      case EnumErrorCode.e04410:
        return 'ID do comando desconhecido - (flespsi)';
      case EnumErrorCode.e04420:
        return 'Comando desconhecido - (flespsi)';
      case EnumErrorCode.e04450:
        return 'SMS não enviado - (flespsi)';
      case EnumErrorCode.e04501:
        return 'Erro no método GET - (flespsi)';
      case EnumErrorCode.e04502:
        return 'Erro no método POST - (flespsi)';
      case EnumErrorCode.e04503:
        return 'Erro no método PUT - (flespsi)';
      case EnumErrorCode.e04504:
        return 'Erro no método DELETE - (flespsi)';
      case EnumErrorCode.e04505:
        return 'Erro no método PATCH - (flespsi)';
      case EnumErrorCode.e04510:
        return 'Erro no serviço flespi - (flespsi)';
      case EnumErrorCode.e04520:
        return 'Erro ao fazer conversão dos arquivos - (flespsi)';
      case EnumErrorCode.e04602:
        return 'Calculadora não atribuída - (flespsi)';
      case EnumErrorCode.e04610:
        return 'Caluladora não encontrada - (flespsi)';
      case EnumErrorCode.e05101:
        return 'Erro ao criar dispositivo - (firebase)';
      case EnumErrorCode.e05102:
        return 'Erro ao atualizar dispositivo - (firebase)';
      case EnumErrorCode.e05103:
        return 'Erro ao excluir dispositivo - (firebase)';
      case EnumErrorCode.e05104:
        return 'Erro ao buscar dispositivo - (firebase)';
      case EnumErrorCode.e05205:
        return 'Usuário já existe - (firebase)';
      case EnumErrorCode.e06101:
        return 'Erro ao fazer login com o Google - (google)';
      case EnumErrorCode.unknown:
        return 'erro desconhecido';
      default:
        return 'erro desconhecido';
    }
  }
}

class ErrorEntity {
  EnumErrorCode code;
  String message;
  ErrorEntity({
    required this.code,
    required this.message,
  });

  ErrorEntity.empty()
      : code = EnumErrorCode.empty,
        message = 'empty';

  bool get isEmpty => code == EnumErrorCode.empty;
}
