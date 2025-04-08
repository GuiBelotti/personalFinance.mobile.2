import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/about_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/add_income_screen.dart';
import 'screens/transaction_list_screen.dart';
import 'screens/report_screen.dart';

void main() {
  runApp(const ControleGastosApp());
}

class ControleGastosApp extends StatelessWidget {
  const ControleGastosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Gastos',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/about': (context) => const AboutScreen(),
        '/home': (context) => const HomeScreen(),
        '/add-expense': (context) => const AddExpenseScreen(),
        '/add-income': (context) => const AddIncomeScreen(),
        '/transactions': (context) => const TransactionListScreen(),
        '/report': (context) => const ReportScreen(),
      },
    );
  }
}