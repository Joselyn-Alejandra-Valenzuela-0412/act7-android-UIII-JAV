import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_servicesManga.dart';

class EditMangaPage extends StatefulWidget {
  const EditMangaPage({super.key});

  @override
  State<EditMangaPage> createState() => _EditMangaPageState();
}

class _EditMangaPageState extends State<EditMangaPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController volumenController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController sinopsisController = TextEditingController();
  final TextEditingController fechaPubliController = TextEditingController();
  final TextEditingController precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // Asignar valores iniciales
    tituloController.text = arguments['titulo'] ?? '';
    volumenController.text = arguments['volumen'] ?? '';
    generoController.text = arguments['genero'] ?? '';
    sinopsisController.text = arguments['sinopsis'] ?? '';
    fechaPubliController.text = arguments['fecha_publi'] ?? '';
    precioController.text = arguments['precio']?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Manga')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: volumenController,
                decoration: const InputDecoration(labelText: 'Volumen'),
              ),
              TextField(
                controller: generoController,
                decoration: const InputDecoration(labelText: 'Género'),
              ),
              TextField(
                controller: sinopsisController,
                decoration: const InputDecoration(labelText: 'Sinopsis'),
                maxLines: 3,
              ),
              TextField(
                controller: fechaPubliController,
                decoration: const InputDecoration(labelText: 'Fecha de publicación'),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await updatemanga(
                    arguments['uid'],
                    tituloController.text,
                    volumenController.text,
                    generoController.text,
                    sinopsisController.text,
                    fechaPubliController.text,
                    double.tryParse(precioController.text) ?? 0.0,
                  ).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: const Text("Actualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
