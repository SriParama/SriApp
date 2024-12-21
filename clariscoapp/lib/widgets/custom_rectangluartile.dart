import 'package:clariscoapp/core/utils/globle_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customrectangluartile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData trailingIcon;

  const Customrectangluartile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.color, required this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 15,
            child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(title,style: TextStyle(fontSize: 16,height: -0.2,fontWeight: FontWeight.bold),),
                ),
                const Icon(
                  
                  CupertinoIcons.info_circle,
                  size: 18,
                  color: GlobalColors.appPrimaryButtonColor,
                ),
                const Expanded(child: Text("")),
                const Text("Last 7 Days")
              ],
            ),
          ),
          Expanded(
            flex: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex:5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subtitle,style: TextStyle(fontSize:15),),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(color)),
                          onPressed: () {},
                          child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "See all",
                                
                                style: TextStyle(
                                  height: -0.2,
                                  letterSpacing: 0.6,
                                  fontSize: 15,
                                  color: GlobalColors.appPrimaryButtonColor),
                              )))
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Icon(
                      color: color,
                     trailingIcon,
                      size: 55,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
