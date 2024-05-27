import 'package:firebase_assignment/providers/authentication_provider.dart';
import 'package:firebase_assignment/repositories/authentication_repository.dart';
import 'package:firebase_assignment/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_assignment/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final AuthenticationService authenticationService = AuthenticationService();
  final AuthenticationRepository authenticationRepository = AuthenticationRepository(authenticationService);

  runApp(
    ProviderScope(
      overrides: [
        authenticationRepositoryProvider.overrideWithValue(authenticationRepository),
      ],
      child: MyApp(authenticationRepository: authenticationRepository,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const MyApp({super.key, required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authenticationNotifierProvider.notifier);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/firebase.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Firebase Assignment', style: TextStyle(fontSize: 50), textAlign: TextAlign.center),
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                child: FloatingActionButton(
                  onPressed: () async {
                    try {
                      await authNotifier.signInWithGoogle();
                      final currentUser = ref.watch(authenticationNotifierProvider).user;
                      if (currentUser != null) {
                        if(context.mounted) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      } else {
                        if(context.mounted) {
                          _showAlertDialog(context, 'Error', 'Failed to sign in with Google');
                        }
                      }
                    } catch (e) {
                      // Handle any exceptions that occur during sign-in
                      print('Error signing in with Google: $e');
                      if(context.mounted) {
                        _showAlertDialog(context, 'Error', 'Failed to sign in with Google: $e');
                      }
                    }
                  },
                  child: const Text('Gmail Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}



