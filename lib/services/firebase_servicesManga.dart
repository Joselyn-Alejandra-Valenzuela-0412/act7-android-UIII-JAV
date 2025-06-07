import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Obtener la lista de mangas
Future<List> getmanga() async {
  List manga = [];
  CollectionReference collectionReferencemanga = db.collection("manga");
  QuerySnapshot querymanga = await collectionReferencemanga.get();

  for (var doc in querymanga.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final comic = {
      "uid": doc.id,
      "titulo": data["titulo"],
      "volumen": data["volumen"],
      "genero": data["genero"],
      "sinopsis": data["sinopsis"],
      "fecha_publi": data["fecha_publi"],
      "precio": data["precio"],
    };
    manga.add(comic);
  }

  return manga;
}

// Agregar un nuevo manga a la base de datos
Future<void> addmanga(
  String titulo,
  String volumen,
  String genero,
  String sinopsis,
  String fechaPubli,
  double precio,
) async {
  await db.collection("manga").add({
    "titulo": titulo,
    "volumen": volumen,
    "genero": genero,
    "sinopsis": sinopsis,
    "fecha_publi": fechaPubli,
    "precio": precio,
  });
}

// Actualizar un manga existente
Future<void> updatemanga(
  String uid,
  String titulo,
  String volumen,
  String genero,
  String sinopsis,
  String fechaPubli,
  double precio,
) async {
  await db.collection("manga").doc(uid).update({
    "titulo": titulo,
    "volumen": volumen,
    "genero": genero,
    "sinopsis": sinopsis,
    "fecha_publi": fechaPubli,
    "precio": precio,
  });
}

// Eliminar un manga
Future<void> deletemanga(String uid) async {
  await db.collection("manga").doc(uid).delete();
}
