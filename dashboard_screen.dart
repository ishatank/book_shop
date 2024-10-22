import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(title: 'Work', icon: Icons.work, color: Colors.blue),
    Category(title: 'Personal', icon: Icons.person, color: Colors.green),
    Category(title: 'Shopping', icon: Icons.shopping_cart, color: Colors.red),
    Category(title: 'Fitness', icon: Icons.fitness_center, color: Colors.orange),
    Category(title: 'Travel', icon: Icons.travel_explore, color: Colors.purple),
    Category(title: 'Health', icon: Icons.health_and_safety, color: Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(category: categories[index]);
          },
        ),
      ),
    );
  }
}

class Category {
  final String title;
  final IconData icon;
  final Color color;

  Category({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: category.color.withOpacity(0.2),
      child: InkWell(
        onTap: () {
          // Handle category tap
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              size: 30,  // Smaller icon size
              color: category.color,
            ),
            SizedBox(height: 8.0),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: category.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
