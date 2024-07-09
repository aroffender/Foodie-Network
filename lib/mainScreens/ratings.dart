// Declare necessary TextEditingControllers and variables for review submission

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<Review> reviews = []; // List to store all reviews
  TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reviews')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: txtSearch,
              decoration: InputDecoration(
                labelText: 'Search Reviews',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  searchReviews(query);
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  Review review = reviews[index];
                  return ListTile(
                    title: Text(
                        "${review.userName} reviewed ${review.restaurantName}"),
                    subtitle: Text("${review.reviewText} \nRating: ${review.rating}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteReview(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
}




TextEditingController txtReview = TextEditingController();
TextEditingController txtUserName = TextEditingController();
TextEditingController txtRestaurantName = TextEditingController();
double userRating = 0.0;

void submitReview() {
  if (txtUserName.text.isEmpty
  txtReview.text.isEmpty
  txtRestaurantName.text.isEmpty ||
  userRating == 0.0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill all fields and provide a rating')),
    );
    return;
  }

  setState(() {
    // Assuming you have a reviews list
    reviews.add(Review(
      txtRestaurantName.text,
      txtUserName.text,
      txtReview.text,
      userRating,
    ));
  });

  // Clear inputs after submission
  txtReview.clear();
  txtUserName.clear();
  txtRestaurantName.clear();
  userRating = 0.0;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Review submitted successfully')),
  );
}



void deleteReview(int index) {
  setState(() {
    reviews.removeAt(index);
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Review deleted')),
  );
}



List<Review> searchReviews(String query) {
  return reviews
      .where((review) =>
      review.restaurantName.toLowerCase().contains(query.toLowerCase())
      review.reviewText.toLowerCase().contains(query.toLowerCase())
  review.userName.toLowerCase().contains(query.toLowerCase()))
  .toList();
}
