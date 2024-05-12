import 'package:firebase_assignment/repositories/authentication_repository.dart';
import 'package:firebase_assignment/widgets/bottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/SearchTextFormField.dart';

class HomeScreen extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  const HomeScreen({super.key,required this.authenticationRepository});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    User? currentUser = widget.authenticationRepository.getCurrentUser();
    String? username = widget.authenticationRepository.getUserDisplayName(currentUser!);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom:   PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Row(
                  children: [
                    const Text(
                      'Hey ',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      username ?? "",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 8),
                child: Text(
                  'Start exploring resources',
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.fromLTRB(0,0,80,0),
                child: SearchTextFormField(),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
