import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CastCard extends StatelessWidget{
  // final Movie movie;

  const CastCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(15),
        color: Colors.grey,
    
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                "https://i.insider.com/679a5f41196626c40985a100?width=1200&format=jpeg",
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.grey[800],
                    child: const Icon(Icons.person, color: Colors.white , size: 50,),
                  );
                },
              ),
            ),
            SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : Name" , style: TextStyle(fontSize: 20),),
                Text("Character : Char" , style: TextStyle(fontSize: 20),),
              ],
            ),
          ],
        ),
      ),
    );
  }

}