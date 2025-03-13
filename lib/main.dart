import 'package:col_moda_empresa/domain/dtos/log_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_response.dart';
import 'package:col_moda_empresa/domain/models/result.dart';
import 'package:col_moda_empresa/infraestructure/external_services/configuration/dio.dart';
import 'package:col_moda_empresa/infraestructure/persistence/database/local_database.dart';
import 'package:col_moda_empresa/infraestructure/persistence/repositories/unit_of_work.dart';
import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'package:col_moda_empresa/ui/config/app_router.dart';
import 'package:col_moda_empresa/ui/config/app_theme.dart';
import 'package:col_moda_empresa/application/users_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();
  runApp(const MainApp());
}

/// 📌 Inicializa la aplicación
Future<void> initializeApp() async {
  await _setupDatabase();
  await _configureDio();
  //await _testDio();
  //await _testLogging();
}

/// 🔧 Configura Dio y muestra la base URL
Future<void> _configureDio() async {
  await DioConfig().initialize();
  LoggerUtil.info("Main","🔍 Base URL en Dio: ${DioConfig().dio.options.baseUrl}");

  await DioConfig().refreshBaseUrl();
  LoggerUtil.info( "Main",
      "🔄 Base URL después de actualización: ${DioConfig().dio.options.baseUrl}");
}

/// 🗄 Configura la base de datos
Future<void> _setupDatabase() async {
  await LocalDatabase().resetDatabase();
  await LocalDatabase().initialize();
  await UnitOfWork().databaseOrTransaction;

  final db = await LocalDatabase().database;
  LoggerUtil.info("Main","✅ Base de datos inicializada en: ${db.path}");
}

//📝 Prueba de dio 
Future<void> _testDio() async {
  try {
    var uuc = UsersUseCases();

    var registerRequest = RegisterRequest(
      address: "Calle 123, Bogotá",
      cityId: 5001,
      email: "diego@gmail.com",
      lastName: "Pérez",
      name: "Diego",
      password: "supersegura123",
      phone: "+57 320 123 4567",
    );

    final response = await uuc.register(registerRequest);

    if (response is Success<RegisterResponse>) {
      LoggerUtil.info("Main","✅ Registro exitoso: ${response.data}");
    } else if (response is Failure<RegisterResponse>) {
      LoggerUtil.error("Main", "❌ Error en el registro: ${response.message}");
    }
  } catch (e) {
    LoggerUtil.error("Main","❌ Error inesperado en la petición: $e");
  }
}



/// 📝 Prueba el sistema de logs
Future<void> _testLogging() async {
  await Future.wait([
    LoggerUtil.multiple([
      LogRequestDto.warning("MAIN", "Segundo log de prueba"),
      LogRequestDto.error("MAIN", "Error crítico de prueba"),
    ]).timeout(Duration(seconds: 5)), // Timeout de 5 segundos
  ]);
  LoggerUtil.info("Main", "Prueba super mega pro");
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Col Moda Empresa',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,

      theme: AppTheme.theme,
      locale: const Locale('es'), // Establecer el idioma a español
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
