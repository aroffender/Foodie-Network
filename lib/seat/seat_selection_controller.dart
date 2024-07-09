import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_text_field.dart';
import 'package:myapp/widgets/menu_item_row.dart';
import 'package:myapp/widgets/popular_restaurant_row.dart';
import 'package:myapp/widgets/most_popular_restaurant.dart';
import 'package:myapp/widgets/recent_item_row.dart';
import 'package:myapp/widgets/RoundTextField.dart';

import '../widgets/category_cell.dart';
import '../widgets/view_all_title_row.dart';

// Define your colors here
class TColor {
  static const Color primaryText = Color(0xFF333333);
  static const Color secondaryText = Color(0xFF777777);
  static const Color primary = Color(0xFFFFD700);
  static const Color white = Color(0xFFFFFFFF);
}

// Reservation Model
class Reservation {
  final String name;
  final DateTime date;
  final int numberOfSeats;

  Reservation(this.name, this.date, this.numberOfSeats);
}

// Seat Model
class Seat {
  final int id;
  bool isBooked;

  Seat(this.id, this.isBooked);
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtSearch = TextEditingController();
  TextEditingController txtName = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int selectedSeats = 1;
  List<Reservation> reservations = [];
  List<Seat> seats = List.generate(20, (index) => Seat(index + 1, false));

  List catArr = [
    {"image": "assets/img/cat_offer.png", "name": "Offers"},
    {"image": "assets/img/cat_sri.png", "name": "Sri Lankan"},
    {"image": "assets/img/cat_3.png", "name": "Italian"},
    {"image": "assets/img/cat_4.png", "name": "Indian"},
  ];

  List popArr = [
    {
      "image": "assets/img/res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafe",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/res_2.png",
      "name": "Café de Noir",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafe",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/res_3.png",
      "name": "Bakes by Tella",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafe",
      "food_type": "Western Food"
    },
  ];

  List mostPopArr = [
    {
      "image": "assets/img/m_res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafe",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/m_res_2.png",
      "name": "Café de Noir",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafe",
      "food_type": "Western Food"
    },
  ];

  List recentArr = [
    {
      "image": "assets/img/item_1.png",
      "name": "Mulberry Pizza by Josh",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafe",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/item_2.png",
      "name": "Barita",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafe",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/item_3.png",
      "name": "Pizza Rush Hour",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafe",
      "food_type": "Western Food"
    },
  ];

  void bookSeats() {
    if (txtName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your name')),
      );
      return;
    }
    if (seats.where((seat) => !seat.isBooked).length < selectedSeats) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Not enough available seats')),
      );
      return;
    }

    setState(() {
      seats.where((seat) => !seat.isBooked).take(selectedSeats).forEach((seat) {
        seat.isBooked = true;
      });
      reservations.add(Reservation(txtName.text, selectedDate, selectedSeats));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Seats booked successfully')),
    );
  }

  void cancelReservation(int index) {
    setState(() {
      Reservation reservation = reservations.removeAt(index);
      seats.where((seat) => seat.isBooked).take(reservation.numberOfSeats).forEach((seat) {
        seat.isBooked = false;
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reservation canceled')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Good morning!",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle cart button press
                      },
                      icon: Image.asset(
                        "assets/img/shopping_cart.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivering to",
                      style: TextStyle(color: TColor.secondaryText, fontSize: 11),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Current Location",
                          style: TextStyle(
                              color: TColor.secondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Image.asset(
                          "assets/img/dropdown.png",
                          width: 12,
                          height: 12,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  hintText: "Search Food",
                  controller: txtSearch,
                  left: Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Image.asset(
                      "assets/img/search.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: catArr.length,
                  itemBuilder: ((context, index) {
                    var cObj = catArr[index] as Map? ?? {};
                    return CategoryCell(
                      cObj: cObj,
                      onTap: () {},
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Popular Restaurants",
                  onView: () {},
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: popArr.length,
                itemBuilder: ((context, index) {
                  var pObj = popArr[index] as Map? ?? {};
                  return PopularRestaurantRow(
                    pObj: pObj,
                    onTap: () {},
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Most Popular",
                  onView: () {},
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: mostPopArr.length,
                  itemBuilder: ((context, index) {
                    var mObj = mostPopArr[index] as Map? ?? {};
                    return MostPopularCell(
                      mObj: mObj,
                      onTap: () {},
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Recent Items",
                  onView: () {},
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: recentArr.length,
                itemBuilder: ((context, index) {
                  var rObj = recentArr[index] as Map? ?? {};
                  return RecentItemRow(
                    rObj: rObj,
                    onTap: () {},
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Make a Reservation",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: "Enter your name",
                      controller: txtName,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Select Date",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: TColor.secondaryText),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(color: TColor.primaryText, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Select Number of Seats",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<int>(
                      value: selectedSeats,
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedSeats = newValue!;
                        });
                      },
                      items: List.generate(10, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: bookSeats,
                      child: Text("Book Seats"),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Reservations",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        Reservation reservation = reservations[index];
                        return ListTile(
                          title: Text(
                              "${reservation.name} - ${reservation.date.toLocal()} - ${reservation.numberOfSeats} seats"),
                          trailing: IconButton(
                            icon: Icon(Icons.cancel, color: Colors.red),
                            onPressed: () => cancelReservation(index),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Seat Availability",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: seats.length,
                      itemBuilder: (context, index) {
                        Seat seat = seats[index];
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: seat.isBooked ? Colors.red : Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Seat ${seat.id}",
                            style: TextStyle(color: TColor.white),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
