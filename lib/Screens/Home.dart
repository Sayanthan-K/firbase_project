import 'dart:ffi';

import 'package:ctse_lab3/Screens/EditRecipe_page.dart';

import '../Model/Recipe.dart';
import '../Repository/RecipeRepository.dart';
import '../Screens/AddRecipe_page.dart';
import '../Widgets/Build_Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../constants/Colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<List<Recipe>> Recipe_list;
  var RecipeRepo = RecipeRepository();

  void loaddata() {
    Recipe_list = RecipeRepo.AllRecipes();
  }

  void deletelist(Recipe id) {
    setState(() {
      RecipeRepo.deleteRecipe(id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
    print("sayanthan");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tdBGColor,
        appBar: buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: StreamBuilder(
                        stream: Recipe_list,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  child: ListTile(
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data![index].description,
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Ingredients for recipe",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 100,
                                            child: ListView.builder(
                                              itemBuilder: ((context, index2) {
                                                return Text(snapshot
                                                    .data![index]
                                                    .Ingredients[index2]);
                                              }),
                                              itemCount: snapshot.data![index]
                                                  .Ingredients.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                      leading: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              Color.fromARGB(255, 26, 25, 25),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                EditRecipe_page(
                                                    RecipeEdit:
                                                        snapshot.data![index]),
                                          ));
                                        },
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          deletelist(snapshot.data![index]);
                                          // deletelist(Ingredients[index]);
                                        },
                                      ),
                                      title: Text(snapshot.data![index].title)),
                                );
                              }),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return Center(
                              child: const CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddRecipe_page(),
                      ));
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
