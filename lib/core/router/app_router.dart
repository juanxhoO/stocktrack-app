import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/products/presentation/pages/product_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/products/presentation/pages/list_products.page.dart';
import '../../features/products/presentation/pages/create_product_page.dart';
import '../../features/auth/presentation/pages/forgot_password.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/inventory/presentation/pages/list_inventory.page.dart';
import '../../features/dashboard/presentation/pages/dashboard.dart';
import '../../features/warehouses/presentation/pages/list_warehouses.page.dart';
import '../../features/warehouses/presentation/pages/warehouse_page.dart';
import '../../features/warehouses/presentation/pages/create_warehouse_page.dart';
import '../../features/category/presentation/pages/list_categories.page.dart';
import '../../features/category/presentation/pages/category_page.dart';
import '../../features/category/presentation/pages/create_category_page.dart';

final appRouter = GoRouter(
  initialLocation: '/profile',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),

    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
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
          builder: (context, state) => const WarehouseCreatePage(),
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
    GoRoute(path: '/home', builder: (context, state) => const DashboardPage()),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductListPage(),
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) => const ProductCreatePage(),
        ),
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProductPage(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/warehouses',
      builder: (context, state) => const WarehouseListPage(),
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) => const WarehouseCreatePage(),
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
  ],
);
