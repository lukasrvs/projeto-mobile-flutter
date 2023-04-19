import 'package:flutter/material.dart';
import 'package:starter/views/food_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
        ElevatedButton(onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context){
              return const FoodView();
            }),
          );
        }, 
        child: const Text("Alimentos"),
      ),
    );
  }
}
