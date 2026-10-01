import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'auth_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const routeName = '/recuperar-senha';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'A recuperação ainda não está conectada a um serviço de autenticação.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      child: AuthPanel(
        title: 'Recuperar acesso',
        subtitle: 'Informe o e-mail da sua conta para receber as instruções.',
        form: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.email],
                onFieldSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'voce@exemplo.com',
                  prefixIcon: Icon(Icons.mail_outline),
                ),
                validator: validateEmail,
              ),
              const SizedBox(height: 22),
              AuthPrimaryButton(label: 'Enviar instruções', onPressed: _submit),
              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Voltar para o login'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.gold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
