import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/dummy.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_button.dart';
import 'package:events_jo/features/admin/presentation/cubits/problem_report/admin_problem_report_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/problem_report/admin_problem_report_states.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/support/domain/models/problem_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProblemsPage extends StatefulWidget {
  const ProblemsPage({super.key});

  @override
  State<ProblemsPage> createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {
  @override
  void initState() {
    super.initState();

    context.read<AdminProblemReportCubit>().getProblems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Manage App Problems',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child:
                BlocConsumer<AdminProblemReportCubit, AdminProblemReportStates>(
              listener: (context, state) {
                if (state is AdminProblemReportError) {
                  context.showSnackBar(state.message);
                }
              },
              builder: (context, state) {
                if (state is AdminProblemReportLoaded) {
                  final problems = state.problems;
                  return buildProblems(problems);
                }
                return Skeletonizer(
                  enabled: true,
                  containersColor: GColors.white,
                  child: buildProblems(
                    [
                      Dummy.problem,
                      Dummy.problem,
                      Dummy.problem,
                      Dummy.problem,
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  ListView buildProblems(List<ProblemReport> problems) {
    return ListView.separated(
      itemCount: problems.length,
      separatorBuilder: (context, index) => 10.height,
      itemBuilder: (context, index) => IconButton(
        onPressed: () => context
            .read<AdminProblemReportCubit>()
            .checkProblem(problems[index]),
        icon: Row(
          children: [
            IconButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  GColors.cyanShade6.shade300.withValues(alpha: 0.2),
                ),
              ),
              icon: Text(
                (index + 1).toString(),
                style: TextStyle(
                  color: GColors.cyanShade6,
                  fontSize: kSmallFontSize,
                ),
              ),
            ),
            10.width,
            SizedBox(
              width: 250,
              child: Text(
                problems[index].problem,
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                  overflow: TextOverflow.ellipsis,
                  decoration: problems[index].isDone
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            const Spacer(),
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                activeColor: GColors.cyanShade6,
                side: BorderSide(
                  color: GColors.cyan,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: problems[index].isDone,
                onChanged: (value) => context
                    .read<AdminProblemReportCubit>()
                    .checkProblem(problems[index]),
              ),
            ),
            Transform.scale(
              scale: 0.57,
              child: AdminButton(
                onPressed: () => context.dialog(
                  pageBuilder: (p0, p1, p2) {
                    return AlertDialog(
                      title: Text('Reported By ${problems[index].userName}'),
                      content: Text(problems[index].problem),
                    );
                  },
                ),
                icon: Icons.info_outline_rounded,
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
