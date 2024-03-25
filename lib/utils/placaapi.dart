import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

Future<PlacaApi> licensePlate(String reg, String username, String password) async {
  String basicAuth = 'Basic ${convert.base64Encode(convert.utf8.encode('$username:$password'))}';
  String url = 'https://www.regcheck.org.uk/api/json.aspx/CheckBrazil/$reg';
  http.Response response = await http.get(Uri.parse(url), headers: <String, String>{'authorization': basicAuth});
  return PlacaApi._(convert.jsonDecode(response.body));
}

class PlacaApi {
  final Map<String, dynamic> data;

  PlacaApi._(Map<String, dynamic> data) : data = {...data};

  /*
  {
  "Description": "CHEVROLET Celta Spirit 1.0 MPFI 8V FlexP. 5p",
  "RegistrationYear": "2010",
  "CarMake": {
    "CurrentTextValue": "CHEVROLET"
  },
  "CarModel": {
    "CurrentTextValue": "Celta Spirit 1.0 MPFI 8V FlexP. 5p"
  },
  "MakeDescription": {
    "CurrentTextValue": "CHEVROLET"
  },
  "ModelDescription": {
    "CurrentTextValue": "Celta Spirit 1.0 MPFI 8V FlexP. 5p"
  },
  "ImageUrl": "http://www.placaapi.com/image.aspx/@Q0hFVlJPTEVUIENlbHRhIFNwaXJpdCAxLjAgTVBGSSA4ViBGbGV4UC4gNXA=",
  "Location": "BELO HORIZONTE, MG",
  "Vin": "9BGRX4810AG118335",
  "Fuel": "flex",
  "Colour": "PRATA",
  "Power": "78",
  "EngineCC": "1000",
  "Type": "PASSAGEIRO",
  "Seats": "5",
  "Axles": "",
  "GrossWeight": "140",
  "MaxTraction": "190"
}
  */
  String get description => data['Description'];

  String get registrationYear => data['RegistrationYear'];

  String get carMake => data['CarMake']['CurrentTextValue'];

  String get carModel => data['CarModel']['CurrentTextValue'];

  String get makeDescription => data['MakeDescription']['CurrentTextValue'];

  String get modelDescription => data['ModelDescription']['CurrentTextValue'];

  String get imageUrl => data['ImageUrl'];

  String get location => data['Location'];

  String get uf => location.split(',')[1].trim();

  String get city => location.split(',')[0].trim();

  String get vin => data['Vin'];

  String get fuel => data['Fuel'];

  String get colour => data['Colour'];

  String get power => data['Power'];

  String get engineCC => data['EngineCC'];

  String get type => data['Type'];

  String get seats => data['Seats'];

  String get axles => data['Axles'];

  String get grossWeight => data['GrossWeight'];

  String get maxTraction => data['MaxTraction'];
}
