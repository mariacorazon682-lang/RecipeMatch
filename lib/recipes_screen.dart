import 'package:flutter/material.dart';
import 'sign_in_profile_screen.dart';
import 'recipe_detail_sheet.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _selectedCategory = 'Breakfast';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Set<String> _bookmarkedTitles = {'Avocado Egg Sourdough Toast'};

  final List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Dessert',
  ];

  final List<Map<String, dynamic>> _allRecipes = [
    {
      'title': 'Fluffy Blueberry Pancakes',
      'category': 'Breakfast',
      'tag': 'WEEKNIGHT',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '15 min',
      'rating': '4.8',
      'imageUrl':
          'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?q=80&w=200&auto=format&fit=crop',
      'ingredients': [
        '1 cup flour',
        '1 tbsp sugar',
        '1 egg',
        '3/4 cup milk',
        '1/2 cup fresh blueberries'
      ],
      'instructions': [
        'Mix dry and wet ingredients in a large bowl.',
        'Gently fold in fresh blueberries.',
        'Cook on medium heat until golden brown on both sides.'
      ],
    },
    {
      'title': 'Avocado Egg Sourdough Toast',
      'category': 'Breakfast',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '10 min',
      'rating': '4.9',
      'imageUrl':
          'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=200&auto=format&fit=crop',
      'ingredients': [
        '2 slices sourdough bread',
        '1 ripe avocado',
        '2 eggs',
        'Chili flakes & sea salt'
      ],
      'instructions': [
        'Toast sourdough bread slices.',
        'Mash avocado with lemon juice, salt, and pepper.',
        'Poach or fry eggs and assemble on top.'
      ],
    },
    {
      'title': 'Berry & Chia Seed Bowl',
      'category': 'Breakfast',
      'tag': 'VEGAN',
      'tagColor': const Color(0xFFE1D5E7),
      'textColor': const Color(0xFF60497A),
      'time': '8 min',
      'rating': '4.8',
      'imageUrl':
          'https://images.unsplash.com/photo-1590301157890-4810ed352733?q=80&w=200&auto=format&fit=crop',
      'ingredients': [
        '3 tbsp chia seeds',
        '1 cup almond milk',
        'Mixed berries & honey'
      ],
      'instructions': [
        'Soak chia seeds in almond milk overnight.',
        'Top with fresh berries, nuts, and a drizzle of honey.'
      ],
    },
    {
      'title': 'Lemony Herb Pasta',
      'category': 'Lunch',
      'tag': 'WEEKNIGHT',
      'tagColor': const Color(0xFFE2F0D9),
      'textColor': const Color(0xFF385723),
      'time': '20 min',
      'rating': '4.9',
      'imageUrl':
          'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?q=80&w=200&auto=format&fit=crop',
      'ingredients': [
        '200g spaghetti pasta',
        'Fresh lemon juice & zest',
        'Extra virgin olive oil',
        'Fresh basil & parmesan'
      ],
      'instructions': [
        'Boil pasta until al dente.',
        'Toss with olive oil, lemon zest, juice, and fresh herbs.',
        'Garnish with grated parmesan.'
      ],
    },
    {
      'title': 'Crispy Chilli Salmon',
      'category': 'Dinner',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.7',
      'imageUrl':
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?q=80&w=200&auto=format&fit=crop',
      'ingredients': [
        '2 salmon fillets',
        '1 tbsp chili oil',
        'Soy sauce & ginger',
        'Steamed jasmine rice'
      ],
      'instructions': [
        'Sear salmon skin-side down until crispy.',
        'Glaze with chili oil, soy sauce, and ginger glaze.',
        'Serve hot over steamed jasmine rice.'
      ],
    },
    {
      'title': 'Garlic Parmesan Chicken',
      'category': 'Dinner',
      'tag': 'HIGH PROTEIN',
      'tagColor': const Color(0xFFFCE4D6),
      'textColor': const Color(0xFFC65911),
      'time': '25 min',
      'rating': '4.8',
      'imageUrl':
          'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?q=80&w=200&auto=format&fit=crop',
      'ingredients': [
        '2 chicken breasts',
        '4 cloves minced garlic',
        '1/2 cup parmesan cheese',
        'Heavy cream & parsley'
      ],
      'instructions': [
        'Pan-fry chicken breasts until golden.',
        'Sauté garlic and stir in heavy cream and parmesan.',
        'Simmer chicken in sauce for 5 minutes.'
      ],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredRecipes {
    return _allRecipes.where((r) {
      final matchesCategory = _selectedCategory == 'All' ||
          r['category'] == _selectedCategory ||
          _selectedCategory == 'Breakfast';
      final matchesSearch = _searchQuery.isEmpty ||
          r['title']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final recipesToShow = _filteredRecipes;

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
                          'Search by category & diet',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Browse Recipes',
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

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search breakfast, snacks, baking...',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.35),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Categories Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Categories Chips
              SizedBox(
                height: 38,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = category == _selectedCategory;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0D3E26)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0D3E26)
                                : Colors.black.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.black.withOpacity(0.7),
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  '$_selectedCategory Recipes',
                  style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Recipes Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  child: recipesToShow.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: Text(
                              'No recipes found matching your search.',
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                        )
                      : Column(
                          children: List.generate(recipesToShow.length, (index) {
                            final r = recipesToShow[index];
                            final title = r['title'] as String;
                            final isBookmarked =
                                _bookmarkedTitles.contains(title);

                            return Column(
                              children: [
                                if (index > 0)
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Divider(color: Color(0xFFF0F0F0)),
                                  ),
                                _buildRecipeItem(
                                  recipeData: r,
                                  isBookmarked: isBookmarked,
                                  onBookmarkTap: () {
                                    setState(() {
                                      if (isBookmarked) {
                                        _bookmarkedTitles.remove(title);
                                      } else {
                                        _bookmarkedTitles.add(title);
                                      }
                                    });
                                  },
                                ),
                              ],
                            );
                          }),
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

  Widget _buildRecipeItem({
    required Map<String, dynamic> recipeData,
    required bool isBookmarked,
    required VoidCallback onBookmarkTap,
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
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                recipe.imageUrl,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
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
              onPressed: onBookmarkTap,
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked ? const Color(0xFFE05A47) : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
