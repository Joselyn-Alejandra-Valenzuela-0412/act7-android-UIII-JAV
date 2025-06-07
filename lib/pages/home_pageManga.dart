import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_servicesManga.dart';

class HomePageManga extends StatefulWidget {
  const HomePageManga({super.key});

  @override
  State<HomePageManga> createState() => _HomePageMangaState();
}

class _HomePageMangaState extends State<HomePageManga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabla Manga"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 0, 156),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getmanga(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay mangas disponibles'));
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final manga = snapshot.data?[index];
              return Dismissible(
                key: Key(manga?['uid'] ?? UniqueKey().toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar'),
                      content: Text(
                          '¿Eliminar ${manga?['titulo'] ?? 'este manga'}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) async {
                  await deletemanga(manga?['uid']);
                  setState(() {});
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        '/editManga',
                        arguments: {
                          'uid': manga?['uid'],
                          'titulo': manga?['titulo'],
                          'volumen': manga?['volumen'],
                          'genero': manga?['genero'],
                          'sinopsis': manga?['sinopsis'],
                          'fecha_publi': manga?['fecha_publi'],
                          'precio': manga?['precio'],
                        },
                      );
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildField('Título', manga?['titulo']),
                          buildField('Volumen', manga?['volumen']),
                          buildField('Género', manga?['genero']),
                          buildField('Fecha de publicación', manga?['fecha_publi']),
                          buildField(
                            'Precio',
                            '\$${double.tryParse(manga?['precio']?.toString() ?? '0')?.toStringAsFixed(2) ?? '0.00'}',
                          ),
                          buildField('Sinopsis', manga?['sinopsis']),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/addManga');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildField(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? 'No disponible',
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
