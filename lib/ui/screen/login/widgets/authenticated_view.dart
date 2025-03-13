import 'package:col_moda_empresa/ui/screen/products/products_screen.dart';
import 'package:col_moda_empresa/ui/widgets/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthenticatedView extends StatefulWidget {
  const AuthenticatedView({super.key});

  @override
  State<AuthenticatedView> createState() => _AuthenticatedViewState();
}

class _AuthenticatedViewState extends State<AuthenticatedView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(ProductsScreen.link);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView();
  }
}
