import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Recipe.dart';

class RecipeRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('Recipe_app');

  Stream<List<Recipe>> AllRecipes() {
    return _collection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> addRecipe(Recipe recipe) async {
    final doc = _collection.doc(recipe.id);
    doc.set(recipe.toMap());
  }

  Future<void> updateRecipe(Recipe recipe) async {
    return _collection.doc(recipe.id).update(recipe.toMap());
  }

  Future<void> deleteRecipe(Recipe recipe) {
    return _collection.doc(recipe.id).delete();
  }
}
