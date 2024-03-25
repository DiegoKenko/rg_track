import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';

class Validator {
  final String? valueToTest;
  final String? field;
  final RegExp? regex;
  final List<String> _errors = [];
  final RegExp _regexName = RegExp(r"^['Á-ü\w]{2,} ['Á-ü\w]+['Á-ü \w]+$");
  final RegExp _regexHour =
      RegExp(r"^([01][0-9]|2[0-3]):?([0-5][0-9])(:?([0-5][0-9]))?$");
  final RegExp _regexPhone = RegExp(
      r"^(\+?\d{0,3}) ?(\(?\d{1,3}\)?) ?((\d{5}[ \-]?\d{4})|(\d{3}[ \-]?\d{3}[ \-]?\d{3}))$");
  final RegExp _regexDateDMY =
      RegExp(r"^([0,12]?[1-9]|[1,2]0|3[0,1])/([0]?[1-9]|1[0-2])/(\d{4})$");
  final RegExp _notNumber = RegExp(r"\D");
  final RegExp _placa = RegExp(r"^[A-Z]{3}[0-9][0-9A-Z][0-9]{2}$");

  bool _isRequired = false;

  Validator(this.valueToTest, {this.field, this.regex});

  Validator get isCnpjValid {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && !CNPJValidator.isValid(valueToTest!)) {
      _errors.add("Não é um CNPJ válido.");
    }
    return this;
  }

  Validator get isCpfOrCnpjValid {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull) {
      if (valueToTest!.replaceAll(_notNumber, '').length == 11) {
        if (CPFValidator.isValid(valueToTest)) return this;
      }
      if (valueToTest!.replaceAll(_notNumber, '').length == 14) {
        if (CNPJValidator.isValid(valueToTest)) return this;
      }
      _errors.add("Não é um CPF/CNPJ válido.");
    }
    return this;
  }

  Validator get isCpfValid {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && !CPFValidator.isValid(valueToTest!)) {
      _errors.add("Não é um CPF válido.");
    }
    return this;
  }

  Validator get isDateDMY {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && !_regexDateDMY.hasMatch(valueToTest!)) {
      _errors.add("Não é um data valida.");
    }
    return this;
  }

  Validator get isEmailValid {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && !EmailValidator.validate(valueToTest!)) {
      _errors.add("Não é um email válido.");
    }
    return this;
  }

  Validator get isName {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && !_regexName.hasMatch(valueToTest!)) {
      _errors.add("Não é um nome valido.");
    }
    return this;
  }

  Validator get isNull {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueIsNull) {
      _errors.add(
          "O campo ${field == null ? '' : ("'$field' ")}não pode ser em nulo.");
    }
    return this;
  }

  Validator get isPhone {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && !_regexPhone.hasMatch(valueToTest!)) {
      _errors.add("Não é um numero de telefone valido.");
    }
    return this;
  }

  Validator get isRequired {
    _isRequired = true;
    if (valueIsNull || valueToTest!.trim().isEmpty) {
      _errors.add("O campo ${field == null ? '' : ("'$field' ")}é requerido.");
    }
    return this;
  }

  Validator isEquals(String mirror) {
    if (valueToTest != mirror) {
      _errors
          .add("O   campo ${field == null ? '' : ("'$field' ")}é requerido.");
    }
    return this;
  }

  Validator get isPlate {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && valueToTest!.length != 7) {
      _errors.add("Não é uma placa válida.");
      return this;
    }
    if (valueNotNull && _placa.hasMatch(valueToTest!)) {
      _errors.add("Não é uma placa válida.");
      return this;
    }
    return this;
  }

  Validator isRequiredConditional(bool Function() validator) {
    if (validator()) {
      return isRequired;
    }
    _isRequired = false;
    return this;
  }

  Validator get isTime {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && !_regexHour.hasMatch(valueToTest!)) {
      _errors.add("Não é um hora valida.");
    }
    return this;
  }

  Validator get validRegex {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    assert(regex == null, 'Você tem que declarar regex no construtor');
    if (valueNotNull && !regex!.hasMatch(valueToTest!)) {
      _errors.add("${field == null ? '' : ("'$field' ")}não é válido.");
    }
    return this;
  }

  bool get valueNotNull => valueToTest != null;

  bool get valueIsNull => valueToTest == null;

  String? call() {
    return resultFirst();
  }

  Validator maxLength(int max) {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && valueToTest!.length > max) {
      _errors.add(
          "${field == null ? 'E' : ("'$field' e")}xcede o tamanho max($max).");
    }
    return this;
  }

  Validator minLength(int min) {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && valueToTest!.length <= min) {
      _errors.add(
          "${field == null ? 'M' : ("'$field' m")}enor que o tamanho min($min).");
    }
    return this;
  }

  Validator max(int max) {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && (int.tryParse(valueToTest!) ?? 0) > max) {
      _errors.add(
          "${field == null ? 'E' : ("'$field' e")}xcede o tamanho maximo $max.");
    }
    return this;
  }

  Validator min(int min) {
    if (!_isRequired && (valueToTest?.isEmpty ?? false)) return this;
    if (valueNotNull && (int.tryParse(valueToTest!) ?? 0) < min) {
      _errors.add(
          "${field == null ? 'M' : ("'$field' m")}enor que o tamanho minimo $min.");
    }
    return this;
  }

  String? resultAll([String join = ', ']) =>
      _errors.isEmpty ? null : _errors.join(join);

  List<String> resultAllAsList([String join = ', ']) => _errors;

  String? resultFirst() => _errors.isEmpty ? null : _errors.first;

  String? resultLast() => _errors.isEmpty ? null : _errors.last;
}
