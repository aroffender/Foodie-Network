import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class reviewp extends StatefulWidget {
    final String restaurantID;
    const reviewp({super.key, required this.restaurantID});

  @override
  _reviewpState createState() => _reviewpState();
}

class _reviewpState extends State<reviewp> {
  TextEditingController reviewController = TextEditingController();
  int selectedRating = 5;

  // Function to submit a new review to Firestore
  Future<void> submitReview() async {
    if (reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review cannot be empty!')),
      );
      return;
    }

    // Add review to Firestore
    CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');

    await reviews.add({
      'restaurantID': widget.restaurantID,
      'reviewText': reviewController.text,
      'rating': selectedRating,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted!')),
      );
      reviewController.clear();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $error')),
      );
    });
  }

  // Function to delete a review from Firestore
  Future<void> deleteReview(String reviewID) async {
    CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');

    await reviews.doc(reviewID).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review deleted!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete review: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews for Restaurant ${widget.restaurantID}'),
      ),
      body: Column(
        children: [
          // Section to submit a new review
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: reviewController,
                  decoration: const InputDecoration(
                    labelText: "Write your review",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                DropdownButton<int>(
                  value: selectedRating,
                  items: List.generate(5, (index) => index + 1)
                      .map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text("$value Stars"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRating = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: submitReview,
                  child: const Text("Submit Review"),
                ),
              ],
            ),
          ),
          const Divider(),

          // Section to display the reviews from Firestore
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('reviews')
                  .where('restaurantID', isEqualTo: widget.restaurantID)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs.map((review) {
                    return ListTile(
                      title: Text(review['reviewText']),
                      subtitle: Text("${review['rating']} Stars"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteReview(review.id);
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
