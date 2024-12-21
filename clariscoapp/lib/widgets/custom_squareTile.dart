import 'package:clariscoapp/core/utils/globle_colors.dart';
import 'package:flutter/material.dart';

class Customsquaretile extends StatelessWidget {
  final String titleContent;

  final String subContentTitle1;
  final String subContent1;
  final String subContentTilte2;
  final String subContent2;
  const Customsquaretile({
    super.key,
    required this.titleContent,
    required this.subContentTitle1,
    required this.subContent1,
    required this.subContentTilte2,
    required this.subContent2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: GlobalColors.getRandomBrightColor(),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
              )),
          Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  titleContent,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(subContentTitle1,
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                      Text(subContent1, style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(subContentTilte2,
                          style: const TextStyle(fontSize: 12)),
                      Text(
                        subContent2,
                        overflow: TextOverflow.visible,
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          color:    subContent2== "Over due"?Colors.red: Colors.green,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
