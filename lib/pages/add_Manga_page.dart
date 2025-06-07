import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_servicesManga.dart';

class AddMangaPage extends StatefulWidget {
  const AddMangaPage({super.key});

  @override
  State<AddMangaPage> createState() => _AddMangaPageState();
}

class _AddMangaPageState extends State<AddMangaPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController volumenController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController sinopsisController = TextEditingController();
  final TextEditingController fechaPubliController = TextEditingController();
  final TextEditingController precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Manga')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  hintText: 'Ingrese el título',
                ),
              ),
              TextField(
                controller: volumenController,
                decoration: const InputDecoration(
                  labelText: 'Volumen',
                  hintText: 'Ingrese el número de volumen',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: generoController,
                decoration: const InputDecoration(
                  labelText: 'Género',
                  hintText: 'Ingrese el género',
                ),
              ),
              TextField(
                controller: sinopsisController,
                decoration: const InputDecoration(
                  labelText: 'Sinopsis',
                  hintText: 'Ingrese la sinopsis',
                ),
                maxLines: 3,
              ),
              TextField(
                controller: fechaPubliController,
                decoration: const InputDecoration(
                  labelText: 'Fecha de publicación',
                  hintText: 'YYYY-MM-DD',
                ),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  hintText: 'Ingrese el precio',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await addmanga(
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
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
