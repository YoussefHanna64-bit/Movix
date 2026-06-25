import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieBanner extends StatelessWidget{
  const MovieBanner({super.key});

  // final Movie movieData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.75,
      width: MediaQuery
          .of(context)
          .size
          .width,

      child: Stack(
        fit: StackFit.expand,
        children: [

          // Image
          Image.network(
            "https://m.media-amazon.com/images/M/MV5BN2YxZGRjMzYtZjE1ZC00MDI0LThjZmQtZTZmMzVmMmQ2NzBmXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
            fit: BoxFit.cover,
          ),

          // Top + Bottom smooth shadow
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

                colors: [
                  Colors.black.withOpacity(0.9), // above
                  Colors.transparent, // middle
                  Colors.transparent,
                  Colors.black, // below
                ],

                stops: [
                  0.02,
                  0.25,
                  0.55,
                  0.85,
                ],
              ),
            ),
          ),

          Center(
            child: GestureDetector(
              onTap: () {
                //Play video
              },

              child: Container(
                width: 95,
                height: 95,

                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 5,
                        color: Colors.yellow
                    )
                ),

                child: Center(
                  child: Container(
                    width: 72,
                    height: 72,

                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107),
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            right: 0,
            top: 5,
            child: IconButton(onPressed: () {
              //add id to firestore
            },
                icon: Icon(
                    Icons.bookmark, color: Colors.white, size: 45)),
          ),
          Positioned(
            bottom: 35,
            right: 0,
            left: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Movie Name", style: TextStyle(color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("2002", style: TextStyle(color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),),
              ],
            ),
          ),


        ],
      ),
    );
  }
}