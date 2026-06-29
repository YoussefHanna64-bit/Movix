import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/cast_entity.dart';

class CastCard extends StatelessWidget{
  final CastEntity cast;

  const CastCard({super.key,required this.cast});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
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
                cast.castImage,
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
            const SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : ${cast.castName}" , style: const TextStyle(fontSize: 14 , fontWeight: FontWeight.w700 , overflow: TextOverflow.ellipsis),),
                const SizedBox(height: 10,),
                Text("Character : ${cast.castCharacter}" , style: const TextStyle(fontSize: 14 , fontWeight: FontWeight.w700 , overflow: TextOverflow.ellipsis),),
              ],
            ),
          ],
        ),
      ),
    );
  }

}