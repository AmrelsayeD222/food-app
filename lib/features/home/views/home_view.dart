import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/network/services/api_service.dart';
import 'package:foods_app/features/home/data/manager/cubit/home_product_cubit.dart';
import 'package:foods_app/features/home/data/repo/home_repo_impl.dart';

import '../widgets/home_appbar.dart';
import '../widgets/home_card_field.dart';
import '../widgets/home_categoy_list.dart';
import '../widgets/search_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeProductCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = HomeProductCubit(HomeRepoImpl(ApiServices(Dio())));
    _cubit.fetchProduct();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    verticalSpace(50),
                    const HomeAppBar(),
                    verticalSpace(20),
                    const SearchField(),
                    verticalSpace(40),
                    const HomeCategoyList(),
                    verticalSpace(20),
                  ],
                ),
              ),
              const HomeCardBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
