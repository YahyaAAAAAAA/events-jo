import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/unique.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/support/domain/models/problem_report.dart';
import 'package:events_jo/features/support/representation/cubits/problem_report/problem_report_cubit.dart';
import 'package:events_jo/features/support/representation/cubits/problem_report/problem_report_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProblemReportDialog extends StatelessWidget {
  const ProblemReportDialog({
    super.key,
    required this.onPressed,
    required this.controller,
  });

  final void Function()? onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Report Problem',
        style: TextStyle(
          color: GColors.black,
          fontSize: kNormalFontSize,
        ),
      ),
      content: TextField(controller: controller),
      actions: [
        IconButton(
          onPressed: () async {
            if (controller.text.trim().isEmpty) {
              return;
            }

            await context.read<ProblemReportCubit>().addProblem(
                  ProblemReport(
                    id: Unique.generateUniqueId(),
                    problem: controller.text,
                    userId: UserManager().currentUser!.uid,
                    userName: UserManager().currentUser!.name,
                    isDone: false,
                  ),
                );

            controller.clear();
            context.pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              GColors.royalBlue,
            ),
          ),
          icon: BlocConsumer<ProblemReportCubit, ProblemReportStates>(
            listener: (context, state) {
              if (state is ProblemReportError) {
                context.showSnackBar(state.message);
              }
            },
            builder: (context, state) => state is ProblemReportLoading
                ? const SizedBox(
                    width: 20, height: 20, child: CircularProgressIndicator())
                : Text(
                    'Send to Supprot',
                    style: TextStyle(
                      color: GColors.white,
                      fontSize: kSmallFontSize,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
