import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movix/features/movies/presentation/widgets/movieBanner.dart';
import 'package:movix/features/movies/presentation/widgets/screenShots.dart';

import '../widgets/statCard.dart';

class MovieDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [

              ///image banner
              MovieBanner(),

              ///Watch button
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(onPressed: () {
                  //play video
                }, style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10),
                  )
                ), child: Text("Watch" , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),) ,

                    ),
              ),

              ///Data buttons (Horizontal)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatCard(icon: Icons.favorite , statName: "15"),
                  StatCard(icon: Icons.favorite , statName: "15"),
                  StatCard(icon: Icons.favorite , statName: "15"),
                ],
              ),

              SizedBox(height: 10,),
              ///Screenshots
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Screen Shots" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 24),),
                    SizedBox(height: 20,),
                    ScreenShots(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsyJw2CoHmM_60-6oe2MU93wf-xJ4eHkVDvEG99W6sltKkOg_yrvJoBnA&s=10"),

                    SizedBox(height: 20,),

                    ScreenShots(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR5AkuKw0uIBoEvnTW1-jJ04sVhH6qVYclDXIqBXypYWNYmtXz_DoAsT-V&s=10"),

                    SizedBox(height: 20,),
                    ScreenShots(image: "https://m.media-amazon.com/images/M/MV5BN2YxZGRjMzYtZjE1ZC00MDI0LThjZmQtZTZmMzVmMmQ2NzBmXkEyXkFqcGc@._V1")

                  ],
                ),
              )

            ],
          ),
        )
    );
  }
}

