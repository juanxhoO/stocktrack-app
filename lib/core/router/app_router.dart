import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stocktrack_app/features/users/presentation/pages/list_users.page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/forgot_password.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/inventory/presentation/pages/list_inventory.page.dart';
import '../../features/dashboard/presentation/pages/dashboard.dart';
import '../../features/warehouses/presentation/pages/list_warehouses.page.dart';
import '../../features/warehouses/presentation/pages/warehouse_page.dart';
import '../../features/warehouses/presentation/pages/create_warehouse_page.dart';
import '../../features/warehouses/domain/entities/warehouse.dart';
import '../../features/category/presentation/pages/list_categories.page.dart';
import '../../features/category/presentation/pages/category_page.dart';
import '../../features/category/presentation/pages/create_category_page.dart';
import '../../features/supplier/presentation/pages/list_suppliers.page.dart';
import '../../features/supplier/presentation/pages/supplier_page.dart';
import '../../features/supplier/presentation/pages/create_supplier_page.dart';
import '../../shared/providers/dependencies.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // 1. Read your token storage
  final tokenStorage = ref.watch(tokenStorageProvider);
  return GoRouter(
    initialLocation: '/home', // Default page when opening the app
    // 2. Add the Redirect Logic
    redirect: (context, state) {
      // Check if the user has a valid token
      final token = tokenStorage.getToken();
      final isLoggedIn = token != null && token.isNotEmpty;
      // Define your public routes
      final isGoingToPublicRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password';
      // SCENARIO 1: Not logged in & trying to access a private page -> send to login
      if (!isLoggedIn && !isGoingToPublicRoute) {
        return '/login';
      }
      // SCENARIO 2: Logged in & trying to access login/signup -> send to home
      if (isLoggedIn && isGoingToPublicRoute) {
        return '/home';
      }
      // SCENARIO 3: Let them proceed normally
      return null;
    },
    // 3. Keep all your existing routes exactly the same!
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/inventory',
        builder: (context, state) => const InventoryListPage(),
      ),
      GoRoute(
        path: '/warehouses',
        builder: (context, state) => const WarehouseListPage(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const WarehouseFormPage(),
          ),
          GoRoute(
            path: 'edit/:id',
            builder: (context, state) {
              // The list page passes the full Warehouse object via `extra`
              // so we don't need an extra network round-trip.
              final warehouse = state.extra as Warehouse?;
              return WarehouseFormPage(warehouse: warehouse);
            },
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return WarehousePage(id: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoryListPage(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const CategoryCreatePage(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return CategoryPage(id: id);
            },
          ),
        ],
      ),

      GoRoute(
        path: '/suppliers',
        builder: (context, state) => const SupplierListPage(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const SupplierCreatePage(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return SupplierPage(id: id);
            },
          ),
        ],
      ),
    ],
  );
});
