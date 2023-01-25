import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:oyt_chef/features/auth/provider/auth_provider.dart';
import 'package:oyt_front_core/constants/lotti_assets.dart';
import 'package:oyt_front_core/validators/text_form_validator.dart';
import 'package:oyt_front_widgets/loading/loading_widget.dart';
import 'package:oyt_front_widgets/widgets/backgrounds/animated_background.dart';
import 'package:oyt_front_widgets/widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const route = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'waiter4@undefined.com');
  final _passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return AnimatedBackground(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              IconButton(
                onPressed: GoRouter.of(context).pop,
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
          const Text(
            '¡Bienvenido!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Te extrañamos',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 18.0,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 180,
            width: 180,
            child: Lottie.asset(
              LottieAssets.login,
              height: 180.0,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: 'Correo',
                  controller: _emailController,
                  validator: TextFormValidator.emailValidator,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Contraseña',
                  obscureText: true,
                  controller: _passwordController,
                  validator: TextFormValidator.passwordValidator,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          authState.authModel.on(
            onData: (u) => FilledButton(
              onPressed: handleOnLogin,
              child: const Text('Ingresar'),
            ),
            onError: (f) => FilledButton(
              onPressed: handleOnLogin,
              child: const Text('Ingresar'),
            ),
            onLoading: () => const LoadingWidget(),
            onInitial: () => FilledButton(
              onPressed: handleOnLogin,
              child: const Text('Ingresar'),
            ),
          ),
        ],
      ),
    );
  }

  void handleOnLogin() {
    if (!_formKey.currentState!.validate()) return;
    ref.read(authProvider.notifier).login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }
}
