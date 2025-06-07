import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/edit_name_page.dart';
import 'package:myapp/pages/home_pageManga.dart';
import 'firebase_options.dart';
import 'package:myapp/pages/edit_Manga_page.dart';
//pages
import 'package:myapp/pages/add_name_page.dart';
import 'package:myapp/pages/add_Manga_page.dart';
import 'package:myapp/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi CRUD',
      initialRoute: '/',
      routes: {
        // Rutas para el CRUD de personas
        '/': (context) => const Home(),
        '/add': (context) => const AddNamePage(),
        '/edit': (context) => const EditNamePage(),
        
        // Rutas para el CRUD de mangas
        '/manga': (context) => const HomePageManga(),
        '/addManga': (context) => const AddMangaPage(),
        '/editManga': (context) => const EditMangaPage(),
      },
    );
  }
}