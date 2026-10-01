import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'auth_widgets.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';
import '../../home/presentation/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_emailController.text.trim().toLowerCase() == 'teste' &&
        _passwordController.text == 'teste') {
      Navigator.of(context)
          .pushReplacementNamed(HomeScreen.routeName, arguments: 'Teste');
      return;
    }
    _showMessage('Login ainda não conectado a um serviço de autenticação.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      child: AuthPanel(
        title: 'Bem-vindo de volta',
        subtitle: 'Entre na sua conta para continuar estudando.',
        form: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'voce@exemplo.com',
                  prefixIcon: Icon(Icons.mail_outline),
                ),
                validator: (value) {
                  if (value?.trim().toLowerCase() == 'teste') return null;
                  return validateEmail(value);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                onFieldSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    tooltip: _obscurePassword
                        ? 'Mostrar senha'
                        : 'Ocultar senha',
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == 'teste') return null;
                  return validatePassword(value);
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context)
                          .pushNamed(ForgotPasswordScreen.routeName),
                  style: TextButton.styleFrom(foregroundColor: AppColors.gold),
                  child: const Text('Esqueci minha senha'),
                ),
              ),
              const SizedBox(height: 8),
              AuthPrimaryButton(label: 'Entrar', onPressed: _submit),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Text(
                      'Ainda não tem uma conta?',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.gold,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    child: const Text('Criar conta'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
