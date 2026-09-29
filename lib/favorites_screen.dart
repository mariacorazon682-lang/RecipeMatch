import 'package:flutter/material.dart';
import 'pages/sign_in_profile_screen.dart';
import 'recipe_detail_sheet.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Map<String, dynamic>> _savedRecipes = [];

  void _removeFavorite(int index) {
    final removed = _savedRecipes[index];
    setState(() {
      _savedRecipes.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed['title']} removed from favorites.'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _savedRecipes.insert(index, removed);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D3E26),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your curated recipe collection',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Your Favorites',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInProfileScreen(),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white24,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Saved Recipes Card Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Header Row inside Card
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Saved Recipes',
                            style: TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_savedRecipes.length} ${_savedRecipes.length == 1 ? 'item' : 'items'}',
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      if (_savedRecipes.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: Text(
                              'No saved recipes yet.\nExplore and bookmark your favorites!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black45,
                                height: 1.4,
                              ),
                            ),
                          ),
                        )
                      else
                        Column(
                          children: List.generate(_savedRecipes.length, (index) {
                            final r = _savedRecipes[index];
                            return Column(
                              children: [
                                if (index > 0)
                                  const Divider(color: Color(0xFFF0F0F0)),
                                _buildFavoriteItem(
                                  recipeData: r,
                                  onRemove: () => _removeFavorite(index),
                                ),
                              ],
                            );
                          }),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteItem({
    required Map<String, dynamic> recipeData,
    required VoidCallback onRemove,
  }) {
    final recipe = Recipe(
      title: recipeData['title'],
      tag: recipeData['tag'],
      tagColor: recipeData['tagColor'],
      textColor: recipeData['textColor'],
      time: recipeData['time'],
      rating: recipeData['rating'],
      imageUrl: recipeData['imageUrl'],
      ingredients: List<String>.from(recipeData['ingredients']),
      instructions: List<String>.from(recipeData['instructions']),
    );

    return InkWell(
      onTap: () {
        showRecipeDetailSheet(context, recipe);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                recipe.imageUrl,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 76,
                  height: 76,
                  color: const Color(0xFFE2F0D9),
                  child: const Center(
                    child: Icon(Icons.restaurant, size: 28, color: Color(0xFF0D3E26)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: recipe.tagColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      recipe.tag,
                      style: TextStyle(
                        color: recipe.textColor,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 13,
                        color: Colors.black38,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.time}  ·  ${recipe.rating} ★',
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(
                Icons.bookmark,
                color: Color(0xFFE05A47),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
