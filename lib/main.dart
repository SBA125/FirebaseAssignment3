import 'package:firebase_assignment/repositories/authentication_repository.dart';
import 'package:firebase_assignment/screens/home_screen.dart';
import 'package:firebase_assignment/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final AuthenticationService authenticationService = AuthenticationService();
  final AuthenticationRepository authenticationRepository = AuthenticationRepository(authenticationService);
  runApp(MyApp(authenticationRepository: authenticationRepository));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const MyApp({super.key, required this.authenticationRepository});

  // This widget is the root of your application.
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
        '/home': (context) => HomeScreen(authenticationRepository: authenticationRepository,),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthenticationService authenticationService = AuthenticationService();

  void _navigateToHomeScreen() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
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
                    // Sign in with Google when the button is pressed
                    final user = await authenticationService.signInWithGoogle();
                    if (user != null) {
                      // Navigate to the home screen upon successful login
                      _navigateToHomeScreen();
                    } else {
                      // Handle login failure
                      _showAlertDialog('Error', 'Failed to sign in with Google.');
                    }
                  },
                  child: const Text('Start'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
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


