import 'package:events_jo/config/my_colors.dart';
import 'package:flutter/material.dart';

//dev delete later
class HomeCardTemp extends StatelessWidget {
  final String text;
  final String subText;
  final String image;
  final double width;
  final double leftPadding;
  final void Function()? onPressed;

  const HomeCardTemp({
    super.key,
    required this.text,
    required this.subText,
    required this.image,
    required this.width,
    required this.onPressed,
    this.leftPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    //stack to overflow image
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        //* main card
        ListTile(
          tileColor: MyColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          minVerticalPadding: 20,
          titleAlignment: ListTileTitleAlignment.center,
          //* title text
          title: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: MyColors.black,
            ),
          ),
          //* spacing for image
          leading: const SizedBox(width: 100),
          //* subtext
          subtitle: Text(
            subText,
            style: TextStyle(
              fontSize: 15,
              color: MyColors.black,
            ),
          ),
          //* button to given page
          trailing: IconButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(
                MyColors.royalBlue,
              ),
            ),
            padding: const EdgeInsets.all(10),
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 30,
            ),
          ),
        ),
        //* cast png shadow
        Padding(
          padding: EdgeInsets.only(left: leftPadding + 10),
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              image,
              width: width,
              color: Colors.black,
            ),
          ),
        ),
        //* image
        Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: Image.asset(
            image,
            width: width,
          ),
        ),
      ],
    );
  }
}
