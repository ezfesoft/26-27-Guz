import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/activities/presentation/screens/activity_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/courses/presentation/screens/course_list_screen.dart';
import '../../features/courses/presentation/screens/week_map_screen.dart';
import '../../features/courses/presentation/screens/week_slide_screen.dart';
import '../../features/gamification/presentation/screens/leaderboard_screen.dart';
import '../../features/teacher/presentation/screens/json_editor_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(currentUserProvider);

  return GoRouter(
    initialLocation: user == null ? '/login' : '/',
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isLoggedIn = user != null;

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const CourseListScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            },
          ),
          GoRoute(
            path: 'leaderboard',
            builder: (BuildContext context, GoRouterState state) {
              return const LeaderboardScreen();
            },
          ),
          GoRoute(
            path: 'courses/:courseId',
            builder: (BuildContext context, GoRouterState state) {
              final courseId = state.pathParameters['courseId'] ?? '';
              return WeekMapScreen(courseId: courseId);
            },
            routes: [
              GoRoute(
                path: 'weeks/:weekId/slides',
                builder: (BuildContext context, GoRouterState state) {
                  final courseId = state.pathParameters['courseId'] ?? '';
                  final weekId = state.pathParameters['weekId'] ?? '';
                  return WeekSlideScreen(
                    courseId: courseId,
                    weekId: weekId,
                  );
                },
              ),
              GoRoute(
                path: 'weeks/:weekId/activities/:activityId',
                builder: (BuildContext context, GoRouterState state) {
                  final courseId = state.pathParameters['courseId'] ?? '';
                  final weekId = state.pathParameters['weekId'] ?? '';
                  final activityId = state.pathParameters['activityId'] ?? '';
                  return ActivityScreen(
                    courseId: courseId,
                    weekId: weekId,
                    activityId: activityId,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'teacher/editor',
            builder: (BuildContext context, GoRouterState state) {
              return const JsonEditorScreen();
            },
          ),
        ],
      ),
    ],
  );
});

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const CourseListScreen(),
    ),
  ],
);
