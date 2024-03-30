import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:health_plans/drift/database/database.dart';
import 'package:health_plans/exercise/view/screen/exercise_list_screen.dart';
import 'package:health_plans/routine/view/screen/routine_screen.dart';
import '../../exercise/view/screen/add_exercise_screen.dart';
import '../../exercise/view/screen/add_part_screen.dart';
import '../../exercise/view/screen/update_exercise_screen.dart';
import '../../exercise/view/screen/update_part_screen.dart';
import '../../routine/view/screen/add_routine_screen.dart';
import '../../routine/view/screen/update_routine_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return goRouter;
});

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const RoutineScreen(),
      routes: [
        GoRoute(
          path: "add_routine_screen",
          builder: (context, state) => const AddRoutineScreen(),
        ),
        GoRoute(
          path: "update_routine_screen",
          builder: (context, state) => const UpdateRoutineScreen(),
        ),
        GoRoute(
          path: "exercise_screen",
          builder: (context, state) => const ExerciseListScreen(),
          routes: [
            GoRoute(
              path: "add_part_screen",
              builder: (context, state) => AddPartScreen(),
            ),
            GoRoute(
              path: "update_part_screen",
              builder: (context, state) {
                return UpdatePartScreen(partData: state.extra as PartData);
              },
            ),
            GoRoute(
              path: "add_exercise_screen",
              builder: (context, state) {
                return AddExerciseScreen(
                  part: state.extra as String,
                );
              },
            ),
            GoRoute(
              path: "update_exercise_screen",
              builder: (context, state) => UpdateExerciseScreen(
                exerciseData: state.extra as ExerciseData,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
