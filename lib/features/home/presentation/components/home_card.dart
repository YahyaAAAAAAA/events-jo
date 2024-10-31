import 'package:events_jo/config/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomeCard extends StatelessWidget {
  final AnimatedMeshGradientController controller;
  final List<Color> colors;
  final IconData icon;
  final String text;
  final String subText;
  final int index;
  final void Function()? onPressed;
  const HomeCard({
    super.key,
    required this.controller,
    required this.colors,
    required this.icon,
    required this.text,
    required this.subText,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: colors[0].withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 0),
        )
      ]),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 10,
          top: 5,
          left: index % 2 == 0 ? 10 : 0,
          right: index % 2 != 0 ? 10 : 0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GridTile(
            // header: Container(
            //   color: Colors.white.withOpacity(0.2),
            //   child: const Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(''),
            //     ],
            //   ),
            // ),
            footer: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: MyColors.white,
                ),
              ),
            ),
            child: AnimatedMeshGradient(
              colors: colors,
              controller: controller,
              options: AnimatedMeshGradientOptions(
                speed: 15,
              ),
              child: Container(
                decoration: const BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 3,
                          color: MyColors.white,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: MyColors.white,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      text,
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
