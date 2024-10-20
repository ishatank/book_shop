import 'package:flutter/material.dart';

// Mock service to simulate fetching data
class WishlistService {
  Future<List<Product>> getWishlistItems() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));
    return [
      Product(id: '1', name: 'The Disappearance', price: 299.99, imageUrl: 'assets/img/1.jpg'),
      Product(id: '2', name: 'Fatherhood', price: 899.99, imageUrl: 'assets/img/2.jpg'),
      Product(id: '3', name: 'The Time Travellers', price: 99.99, imageUrl: 'assets/img/3.jpg'),
      // Add more products as needed
    ];
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.id, required this.name, required this.price, required this.imageUrl});
}

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistService _wishlistService = WishlistService();
  List<Product> _wishlistItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWishlistItems();
  }

  Future<void> _loadWishlistItems() async {
    setState(() {
      _isLoading = true;
    });
    final items = await _wishlistService.getWishlistItems();
    setState(() {
      _wishlistItems = items;
      _isLoading = false;
    });
  }

  void _removeFromWishlist(Product product) {
    setState(() {
      _wishlistItems.removeWhere((item) => item.id == product.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} removed from wishlist')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist'),
        backgroundColor: Color(0xff5ABD8C),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _wishlistItems.isEmpty
              ? Center(child: Text('Your wishlist is empty'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,  // Adjusted aspect ratio
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _wishlistItems.length,
                    itemBuilder: (context, index) {
                      final product = _wishlistItems[index];
                      return WishlistItem(
                        product: product,
                        onRemove: () => _removeFromWishlist(product),
                      );
                    },
                  ),
                ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  const WishlistItem({Key? key, required this.product, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,  // Adjusted flex value to reduce image height
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 2,  // Adjusted flex value to give more space for text and button
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(  // Added SingleChildScrollView to prevent overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: onRemove,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
