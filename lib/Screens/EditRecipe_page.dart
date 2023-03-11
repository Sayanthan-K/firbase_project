// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:ctse_lab3/Model/Recipe.dart';
import 'package:ctse_lab3/Repository/RecipeRepository.dart';

class EditRecipe_page extends StatefulWidget {
  final Recipe RecipeEdit;
  const EditRecipe_page({
    Key? key,
    required this.RecipeEdit,
  }) : super(key: key);

  @override
  State<EditRecipe_page> createState() => _EditRecipe_pageState();
}

class _EditRecipe_pageState extends State<EditRecipe_page> {
  late Recipe newRecipe;
  List<dynamic> EditRecipe = [];
  var listof_Ingredients = ["chicken", "meal", "Cream"];
  var RecipeRepo = RecipeRepository();
  List<dynamic> Ingredients = [];
  void _addRecipeClick() {}
  void deletelist(String id) {
    setState(() {
      Ingredients.removeWhere((recipe) => recipe == id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.RecipeEdit.title;
    _descriptionController.text = widget.RecipeEdit.description;
    for (var element in widget.RecipeEdit.Ingredients) {
      EditRecipe.add(element);
    }
  }

  void _addToDoItem() {
    newRecipe = Recipe(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        Ingredients: Ingredients);

    RecipeRepo.addRecipe(newRecipe);

    _titleController.clear();
    _descriptionController.clear();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _Ingredients = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Recipe"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'description'),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return ListTile(
                            subtitle: Text(EditRecipe[index]),
                            leading: const Icon(Icons.edit),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deletelist(
                                    widget.RecipeEdit.Ingredients[index]);
                              },
                            ),
                            title: Text(EditRecipe[index]));
                      }),
                      itemCount: EditRecipe.length,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: (() {
                    showDialog(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Ingredients'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Add Ingredients'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextFormField(
                                  controller: _Ingredients,
                                  decoration: const InputDecoration(
                                      labelText: 'Ingredients')),
                              TextButton(
                                child: const Text('Add Ingredients'),
                                onPressed: () {
                                  setState(
                                    () {
                                      EditRecipe.add(_Ingredients.text);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }),
                ),
                const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _addToDoItem,
                        child: const Text('Edit recipe'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
