import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/blocs/product_bloc/product_bloc.dart';
import 'package:new_project/resources/constants.dart';
import 'package:new_project/resources/routes.dart';
import 'package:new_project/widgets/custom_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      bool isBottom = _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent;
      if (isBottom) {
        context.read<ProductBloc>().add(ProductFetched());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimary600,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kWhite,
          // drawer: const Icon(Icons.menu, color: kWhite),
          appBar: AppBar(
            backgroundColor: kPrimary600,
            title: RegularText('Ecommerce ', 16, kWhite),
            actions: [
              GestureDetector(
                onTap: () {
                  context.go(Routes.favourites);
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.favorite, color: kWhite),
                ),
              ),
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              switch (state.status) {
                case PostStatus.initial:
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                case PostStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                case PostStatus.failure:
                  return Center(
                      child: RegularText(state.status.toString(), 16, kBlack));
                case PostStatus.success:
                  return GridView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .7,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final e = state.products[index];
                      return ProductCard(e);
                    },
                  );
                default:
                  throw UnimplementedError('Not a valid state');
              }
            },
          ),
        ),
      ),
    );
  }
}
