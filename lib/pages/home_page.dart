import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';
import 'package:myapp/pages/home_pageManga.dart'; // Asegúrate de importar tu pantalla

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi crud"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 0, 156),
      ),
      body: Column(
        children: [
          // Botón para ir a home_pageManga
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageManga()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 155, 201, 240), // Color de fondo del botón
                minimumSize: Size(double.infinity, 50), // Ancho completo, altura 50
              ),
              child: Text('Ir a Tabla Manga  >'),
            ),
          ),
          // Resto de tu contenido existente
          Expanded(
            child: FutureBuilder(
              future: getPeople(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        onDismissed: (direction) async {
                          await deletepeople(snapshot.data?[index]['uid']);
                          snapshot.data?.removeAt(index);
                        },
                        confirmDismiss: (direction) async {
                          bool result = false;

                          result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Estas seguro de querer eliminar a ${snapshot.data?[index]['name']}?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      return Navigator.pop(context, false);
                                    },
                                    child: const Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      return Navigator.pop(context, true);
                                    },
                                    child: const Text("Si, estoy seguro"),
                                  ),
                                ],
                              );
                            },
                          );

                          return result;
                        },
                        background: Container(
                          color: const Color.fromARGB(255, 219, 123, 12),
                          child: const Icon(Icons.delete),
                        ),
                        direction: DismissDirection.endToStart,
                        key: Key(snapshot.data?[index]['uid']),
                        child: ListTile(
                          onLongPress: () => print("Borrar"),
                          title: Text(snapshot.data?[index]['name']),
                          onTap: (() async {
                            await Navigator.pushNamed(
                              context,
                              '/edit',
                              arguments: {
                                'name': snapshot.data?[index]['name'],
                                'uid': snapshot.data?[index]['uid'],
                              },
                            );
                            setState(() {});
                          }),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Cargando..."));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}