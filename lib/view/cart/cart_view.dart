import 'package:flutter/material.dart';
import './payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _spaghettiCount = 0;
  int _pizzaCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Color(0xff5ABD8C),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Spaghetti Item
            CartItem(
              itemName: 'The Disappearance of Emila Zola',
              itemPrice: 32.50,
              itemCount: _spaghettiCount,
              onIncrement: () {
                setState(() {
                  _spaghettiCount++;
                });
              },
              onDecrement: () {
                setState(() {
                  if (_spaghettiCount > 0) {
                    _spaghettiCount--;
                  }
                });
              },
              imageUrl: 'assets/img/1.jpg',
            ),
            // Pizza Item
            CartItem(
              itemName: 'Fatherhood',
              itemPrice: 32.50,
              itemCount: _pizzaCount,
              onIncrement: () {
                setState(() {
                  _pizzaCount++;
                });
              },
              onDecrement: () {
                setState(() {
                  if (_pizzaCount > 0) {
                    _pizzaCount--;
                  }
                });
              },
              imageUrl: 'assets/img/2.jpg',
            ),
            // Promo Code
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Promo Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(primary: Color(0xff5ABD8C)),
                    child: Text('Apply'),
                  ),
                ],
              ),
            ),
            // Cart Summary
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subtotal: \$${(_spaghettiCount * 32.50 + _pizzaCount * 32.50).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Tax (10%): \$${((_spaghettiCount * 32.50 + _pizzaCount * 32.50) * 0.1).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Total: \$${((_spaghettiCount * 32.50 + _pizzaCount * 32.50) * 1.1).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            // Checkout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        totalAmount: ((_spaghettiCount * 32.50 + _pizzaCount * 32.50) * 1.1),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Color(0xff5ABD8C)),
                child: Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final int itemCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final String imageUrl;

  CartItem({
    required this.itemName,
    required this.itemPrice,
    required this.itemCount,
    required this.onIncrement,
    required this.onDecrement,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book image
          Image.asset(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          // Book details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '\$${itemPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Quantity controls
          Row(
            children: [
              InkWell(
                onTap: onDecrement,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xff5ABD8C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.remove, color: Colors.white, size: 20),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  '$itemCount',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: onIncrement,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xff5ABD8C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}