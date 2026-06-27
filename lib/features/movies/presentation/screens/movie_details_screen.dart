import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movix/features/movies/presentation/widgets/castCard.dart';
import 'package:movix/features/movies/presentation/widgets/movieBanner.dart';
import 'package:movix/features/movies/presentation/widgets/screenShots.dart';

import '../widgets/statCard.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

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
                  StatCard(icon: Icons.access_time_filled , statName: "90"),
                  StatCard(icon: Icons.star , statName: "7.6"),
                ],
              ),

              SizedBox(height: 10,),
              ///Screenshots
              ///Make ListView
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
              ),

              SizedBox(height: 10,),
              ///Similar Movies
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Similar" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 24),),
                    SizedBox(height: 20,),
                    ///GridView of similar movies
                    Center(child: Text("Coming Soon" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 50),),),

                  ],
                ),
              ),

              SizedBox(height: 10,),
              ///Summary
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Summary" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 24),),
                    SizedBox(height: 20,),

                    Text("Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346"
                    , style: TextStyle(color: Colors.white, fontSize: 18),),

                  ],
                ),
              ),

              SizedBox(height: 10,),
              ///Cast
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cast" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 24),),
                    SizedBox(height: 20,),

                    Text("ListView of Cast Card"
                      , style: TextStyle(color: Colors.white, fontSize: 18),),

                    CastCard(),

                  ],
                ),
              ),


              SizedBox(height: 10,),
              ///Genres
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Genres" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 24),),
                    SizedBox(height: 20,),

                    Container(
                      color: Colors.grey,
                      child: Text("GridView of Genres Card"
                        , style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),

                  ],
                ),
              ),

            ],
          ),
        )
    );
  }
}

