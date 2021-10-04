part of 'services.dart';

class UserAuthService {
  static Future<ApiReturnValue<User>> signIn(
    String email,
    String password,
  ) async {
    String url = baseUrl + login;

    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Please try again");
    }

    var data = jsonDecode(response.body);
    User value = User.fromJson(data);
    if (value.userId == null) {
      return ApiReturnValue(message: "Perikasa email dan password anda");
    }
    return ApiReturnValue(value: value);
  }

  //if have a return value like login change varaibale bool with your model
  static Future<ApiReturnValue<bool>> signUp(
    RegisterEntry user,
  ) async {
    String url = baseUrl + register;
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "name": user.userName,
          "email": user.email,
          "password": user.password,
          "country_name": 1,
          "language": 1
        }));
    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Please try again");
    }

    return ApiReturnValue(value: true);
  }

  static Future<ApiReturnValue<bool>> forgotPasswor(
    String email,
    String password,
  ) async {
    String url = baseUrl + forgorPassword;
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          "email": email,
          "new_pass": password,
        },
      ),
    );
    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        return ApiReturnValue(message: "Email tidak ditemukan");
      }
      return ApiReturnValue(message: "Please try again");
    }

    return ApiReturnValue(value: true);
  }
}
