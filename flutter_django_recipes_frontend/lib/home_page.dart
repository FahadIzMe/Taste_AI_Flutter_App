import 'package:flutter/material.dart';
import 'package:flutter_django_recipes_frontend/add_edit_recipe_page.dart';
import 'package:flutter_django_recipes_frontend/login_page.dart';
import 'package:flutter_django_recipes_frontend/recipe_detail_page.dart';
import 'package:flutter_django_recipes_frontend/services/recipe_service.dart';
import 'package:flutter_django_recipes_frontend/ingredients_list.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> recipes = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final loadedRecipes = await RecipeService.getRecipes();
      setState(() {
        recipes = loadedRecipes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = e.toString();
      });
      _showErrorSnackbar('Failed to load recipes: $e');
    }
  }

  Future<void> _handleAddRecipe() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => const AddEditRecipePage(
              availableIngredients: availableIngredients,
            ),
      ),
    );

    if (result != null) {
      try {
        setState(() => isLoading = true);
        final newRecipe = await RecipeService.addRecipe(
          name: result['name'],
          description: result['description'],
          ingredients: result['ingredients'],
        );
        setState(() {
          recipes.add(newRecipe);
          isLoading = false;
        });
      } catch (e) {
        setState(() => isLoading = false);
        _showErrorSnackbar('Failed to add recipe: $e');
      }
    }
  }

  Future<void> _handleEditRecipe(Map<String, dynamic> recipe, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AddEditRecipePage(
              recipe: recipe,
              availableIngredients: availableIngredients,
            ),
      ),
    );

    if (result != null) {
      try {
        setState(() => isLoading = true);
        final updatedRecipe = await RecipeService.updateRecipe(
          id: recipe['id'],
          name: result['name'],
          description: result['description'],
          ingredients: result['ingredients'],
        );
        setState(() {
          recipes[index] = updatedRecipe;
          isLoading = false;
        });
      } catch (e) {
        setState(() => isLoading = false);
        _showErrorSnackbar('Failed to update recipe: $e');
      }
    }
  }

  Future<void> _handleDeleteRecipe(int index) async {
    final recipe = recipes[index];
    try {
      setState(() => isLoading = true);
      await RecipeService.deleteRecipe(recipe['id']);
      setState(() {
        recipes.removeAt(index);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackbar('Failed to delete recipe: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _viewRecipeDetails(Map<String, dynamic> recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe)),
    );
  }

  void _logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Widget _buildRecipeList() {
    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadRecipes, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (recipes.isEmpty) {
      return const Center(
        child: Text('No recipes found. Add your first recipe!'),
      );
    }

    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        final ingredients = (recipe['ingredients'] as List<dynamic>)
            .map<String>((i) => i['name'] as String)
            .join(', ');

        return Card(
          margin: const EdgeInsets.all(8),
          color: const Color.fromARGB(255, 245, 241, 241),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(
              recipe['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe['description']),
                const SizedBox(height: 4),
                Text(
                  'Ingredients: $ingredients',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            onTap: () => _viewRecipeDetails(recipe),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') _handleEditRecipe(recipe, index);
                if (value == 'delete') _handleDeleteRecipe(index);
              },
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255,247, 241, 230),
      drawer: Drawer(
        //backgroundColor: const Color.fromARGB(255, 126, 164, 196),
        child: Column(
          children: [
            Image.asset(
              "assets/Logo.png",
              width:
                  double.infinity, // Makes the image expand to the full width
              fit: BoxFit.cover, // Ensures the image fills the space properly
            ),
            //const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Extends to max width
              child: Card(
                elevation: 5, // Adds shadow effect
                shape: LinearBorder(),
                margin:
                    EdgeInsets.zero, // Removes extra spacing around the Card
                child: ListTile(
                  title: Text(
                    "About",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  trailing: Icon(Icons.info_sharp, color: const Color.fromARGB(255, 73, 170, 187)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AboutPage(),))
                ),
              ),
            ),
            SizedBox(
              width: double.infinity, // Extends to max width
              child: Card(
                elevation: 5, // Adds shadow effect
                shape: LinearBorder(),
                margin:
                    EdgeInsets.zero, // Removes extra spacing around the Card
                child: ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  trailing: Icon(Icons.power_settings_new_outlined, color: const Color.fromARGB(255, 73, 170, 187)),
                  onTap: _logout,
                ),
              ),
            ),
          ],
        ),
      ),
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,247, 241, 230),
        title: const Text('Your Recipes'),
        //backgroundColor: const Color.fromARGB(255, 115, 156, 189),
        actions: [
          /* IconButton(
            icon: const Icon(Icons.power_settings_new_outlined),
            onPressed: _logout,
            tooltip: 'Logout',
          ), */
          IconButton(
            icon: const Icon(Icons.insert_drive_file),
            onPressed: _handleAddRecipe,
            tooltip: 'Add Recipe',
          ),
        ],
      ),
      
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _loadRecipes,
                child: _buildRecipeList(),
              ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: _handleAddRecipe,
        child: const Icon(Icons.add),
      ), */
    );
  }
}
