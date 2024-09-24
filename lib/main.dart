import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Delivery"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
    children: [
    Text("Categories", style: Theme.of(context).textTheme.headlineSmall),
    SizedBox(height: 10),
    buildFoodCategoryCard(context, "Pizza", Icons.local_pizza),
    buildFoodCategoryCard(context, "Burger", Icons.fastfood),
    buildFoodCategoryCard(context, "Salad", Icons.eco),
    buildFoodCategoryCard(context, "Sushi", Icons.rice_bowl),
    buildFoodCategoryCard(context, "Tacos", Icons.restaurant),
    buildFoodCategoryCard(context, "Pasta", Icons.dining),
    buildFoodCategoryCard(context, "Ice Cream", Icons.icecream),
    buildFoodCategoryCard(context, "Steak", Icons.restaurant_menu),
    buildFoodCategoryCard(context, "Smoothie", Icons.local_cafe),
    ],
    )
    );
  }

  Widget buildFoodCategoryCard(BuildContext context, String title, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 50, color: Colors.teal),
        title: Text(title),
        trailing: RatingBar.builder(
          initialRating: 4,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemSize: 20.0,
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {},
        ),
        // Navigate to FoodDetailsPage on tap
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodDetailsPage(title: title)),
          );
        },
      ),
    );
  }
}

class FoodDetailsPage extends StatefulWidget {
  final String title;

  // Constructor to receive the food title
  FoodDetailsPage({required this.title});

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  String _selectedSize = 'Medium';
  bool _extraCheese = false;
  bool _extraSauce = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Details"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.local_pizza, size: 200, color: Colors.teal),
            Text(
              "Delicious Pizza",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 20),

            // RadioButton for Size selection
            Text("Select Size:", style: Theme.of(context).textTheme.titleSmall),
            buildRadioButton("Small"),
            buildRadioButton("Medium"),
            buildRadioButton("Large"),

            // CheckBox for Toppings
            Text("Extra Toppings:", style: Theme.of(context).textTheme.titleSmall),
            buildCheckBox("Extra Cheese", _extraCheese, (value) {
              setState(() {
                _extraCheese = value!;
              });
            }),
            buildCheckBox("Extra Sauce", _extraSauce, (value) {
              setState(() {
                _extraSauce = value!;
              });
            }),

            Spacer(),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${widget.title} added to cart!"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.teal,
                  ),
                );
              },
              child: Text("Add to Cart"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget buildRadioButton(String size) {
    return ListTile(
      title: Text(size),
      leading: Radio(
        value: size,
        groupValue: _selectedSize,
        onChanged: (value) {
          setState(() {
            _selectedSize = value.toString();
          });
        },
      ),
    );
  }

  Widget buildCheckBox(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  double _deliveryTime = 30;
  bool _isDelivery = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Delivery or Pickup", style: Theme.of(context).textTheme.titleSmall),
            SwitchListTile(
              title: Text(_isDelivery ? "Delivery" : "Pickup"),
              value: _isDelivery,
              onChanged: (value) {
                setState(() {
                  _isDelivery = value;
                });
              },
            ),

            SizedBox(height: 20),

            Text("Estimated Delivery Time", style: Theme.of(context).textTheme.titleSmall),
            Slider(
              value: _deliveryTime,
              min: 10,
              max: 60,
              divisions: 5,
              label: "${_deliveryTime.toStringAsFixed(0)} min",
              onChanged: (value) {
                setState(() {
                  _deliveryTime = value;
                });
              },
            ),

            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text("Confirm Order"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            )
          ],
        ),
      ),
    );
  }
}
