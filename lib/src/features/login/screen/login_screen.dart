import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';


Future<String?> getGoogleAuthorizeLink() async {
  final url = Uri.parse('http://192.168.2.15:8000/auth/google/authorize');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Парсим ответ сервера, предполагая, что сервер возвращает JSON
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String googleAuthorizeLink = responseData['google_authorize_link'];

      return googleAuthorizeLink;
    } else {
      // Обработка ошибки при получении ссылки
      print('Failed to get Google authorize link');
      return null;
    }
  } catch (e) {
    // Обработка других ошибок
    print('Error: $e');
    return null;
  }
}

Future<UserInfo?> getUserInfoFromGoogle(String accessToken) async {
  try {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/oauth2/v1/userinfo?access_token=$accessToken'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      final String? email = userData['email'];
      final String? account_id = userData['id'];
      final String? name = userData['name'];
      final String? pictureUrl = userData['picture'];

      if (email != null) {
        // Создайте объект UserInfo с полученными данными о пользователе
        return UserInfo(email: email, name: name, account_id: account_id, pictureUrl: pictureUrl);
      }
    }
  } catch (error) {
    print('Error getting user info from Google: $error');
  }

  return null;
}

class UserInfo {
  final String email;
  final String? account_id;
  final String? name;
  final String? pictureUrl;

  UserInfo({required this.email,  this.account_id, this.name, this.pictureUrl});
}

class GoogleSignInService {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();
}

class LoginScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> loginUser(String email, String password) async {
    // Выполните аутентификацию на вашем сервере
    // Здесь вы можете использовать email и password

    try {
      // Вместо фиктивного токена, вызовите ваш сервер и получите действительный accessToken
      final String accessToken = await authenticateOnYourServer(email, password);

      // Вызов функции для доступа к защищенному маршруту с использованием полученного accessToken
      await protectedRoute(accessToken);
    } catch (error) {
      print('Error during login: $error');
    }
  }

  Future<String> authenticateOnYourServer(String email, String password) async {
    // Здесь вы можете отправить запрос на ваш сервер для аутентификации
    // и получить accessToken в ответе
    // Пример запроса с использованием пакета http:
    /*
    final response = await http.post(
      Uri.parse('https://your-auth-server.com/authenticate'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String accessToken = responseData['access_token'];
      return accessToken;
    } else {
      throw Exception('Failed to authenticate');
    }
    */

    // Возвращайте accessToken или обрабатывайте ошибку аутентификации
    // в зависимости от вашей реализации сервера
    return 'your_access_token';
  }

  Future<void> protectedRoute(String accessToken) async {
    // Ваш код для доступа к защищенному маршруту на сервере
    // ...

    // При успешном доступе к защищенному маршруту
    // ...

    // Сохраните токен доступа в Flutter Secure Storage
    await saveAccessToken(accessToken);
  }

  Future<void> saveAccessToken(String accessToken) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'access_token', value: accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Application'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Login'),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        loginUser(emailController.text, passwordController.text);
                        Navigator.of(context).pushNamed('/main');
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 20,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Image.asset(
                        'lib/src/ui/images/logo/google.png',
                        width: 48,
                        height: 48,
                      ),
                      onPressed: () async {
                        // Вызов функции для входа через Google
                        await signInWithGoogle();
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'lib/src/ui/images/logo/google.png',
                        width: 48,
                        height: 48,
                      ),
                      onPressed: () async {
                        // Вызов функции для входа через Google
                        await GoogleSignInService.logout();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: Text(
                      'Sign up now',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignInService.login();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final String? accessToken = googleAuth.accessToken;

        if (accessToken != null) {
          print(accessToken);
          final UserInfo? userInfo = await getUserInfoFromGoogle(accessToken);
          if (userInfo != null) {
            print('ID: ${userInfo.account_id}');
            print('Name: ${userInfo.name}');
            print('Email: ${userInfo.email}');
            print('Picture URL: ${userInfo.pictureUrl}');
          }
        } else {
          print('Access token is null');
        }
      } else {
        print('Google sign-in canceled');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }
}
