import 'package:flutter/material.dart';
import '../common/color_extenstion.dart';

class RecentlyCell extends StatelessWidget {
  final Map iObj;
  const RecentlyCell({super.key, required this.iObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: media.width * 0.32,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 2),
                      blurRadius: 5
                    )
                  ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    iObj["img"].toString(),
                    width: media.width * 0.32,
                    height: media.width * 0.48, // Slightly reduced from 0.50
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Reduced from 15
              Text(
                iObj["name"].toString(),
                maxLines: 2, // Reduced from 3
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: TColor.text,
                  fontSize: 12, // Slightly reduced from 13
                  fontWeight: FontWeight.w700
                ),
              ),
              Text(
                iObj["author"].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: TColor.subTitle,
                  fontSize: 10, // Slightly reduced from 11
                ),
              )
            ],
          ),
        );
      },
    );
  }
}