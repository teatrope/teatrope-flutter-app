import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/auth/data/auth_service.dart';
import 'package:teatrope_flutter_app/features/auth/pages/signup_page.dart';
import 'package:teatrope_flutter_app/features/auth/presentation/blocs/signin_bloc.dart';
import 'package:teatrope_flutter_app/features/auth/presentation/blocs/signin_event.dart';
import 'package:teatrope_flutter_app/features/auth/presentation/blocs/signin_state.dart';
import 'package:teatrope_flutter_app/features/main/main_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _remember = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc(authService: AuthService()),
      child: BlocListener<SigninBloc, SigninState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const MainPage()),
              (route) => false,
            );
          } else if (state.status == Status.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'Error al iniciar sesión')),
            );
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: DarkBlurBackground(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'teatrope',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: MaterialTheme.brandRed,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Sign in',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'E-mail',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white.withOpacity(0.9)),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(hintText: 'user@gmail.com'),
                        onChanged: (value) => context
                            .read<SigninBloc>()
                            .add(OnEmailChanged(email: value)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Password',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white.withOpacity(0.9)),
                      ),
                      const SizedBox(height: 8),
                      BlocSelector<SigninBloc, SigninState, bool>(
                        selector: (state) => state.isPasswordVisible,
                        builder: (context, isPasswordVisible) {
                          return TextField(
                            controller: _passwordController,
                            obscureText: !isPasswordVisible,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: '**********',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<SigninBloc>()
                                      .add(const TogglePasswordVisibility());
                                },
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            onChanged: (value) => context
                                .read<SigninBloc>()
                                .add(OnPasswordChanged(password: value)),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Checkbox(
                            value: _remember,
                            onChanged: (v) => setState(() => _remember = v ?? false),
                            side: const BorderSide(color: Colors.white54),
                            checkColor: Colors.white,
                            activeColor: Colors.white24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Remember me?',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      FilledButton.icon(
                        onPressed: () {
                          context.read<SigninBloc>().add(const Signin());
                        },
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text('Sign In'),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account? ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) => const SignUpPage()),
                                );
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
