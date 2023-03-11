import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse_lab3/Model/Recipe.dart';
import 'package:ctse_lab3/Repository/RecipeRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRecipe_page extends StatefulWidget {
  const AddRecipe_page({super.key});

  @override
  State<AddRecipe_page> createState() => _AddRecipe_pageState();
}

class _AddRecipe_pageState extends State<AddRecipe_page> {
  late Recipe newRecipe;
  var listof_Ingredients = ["chicken", "meal", "Cream"];
  var RecipeRepo = RecipeRepository();
  List<String> Ingredients = [];
  void _addRecipeClick() {}
  void deletelist(String id) {
    setState(() {
      Ingredients.removeWhere((recipe) => recipe == id);
    });
  }

  void _addToDoItem() async {
    newRecipe = Recipe(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        Ingredients: Ingredients);

    RecipeRepo.addRecipe(newRecipe);
    print("sayanthan");
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      // Fluttertoast.showToast(
      //     msg: "This is Center Short Toast",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    });
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _Ingredients = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AddRecipe")),
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
                            subtitle: Text(Ingredients[index]),
                            leading: const Icon(Icons.edit),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deletelist(Ingredients[index]);
                              },
                            ),
                            title: Text(Ingredients[index]));
                      }),
                      itemCount: Ingredients.length,
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
                                      Ingredients.add(_Ingredients.text);
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
                        child: const Text('Add recipe'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
