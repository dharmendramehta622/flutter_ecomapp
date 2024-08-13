import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/blocs/product_bloc/product_bloc.dart';
import 'package:new_project/resources/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            actions: const [
              Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.shopping_cart, color: kWhite),
              ),
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              print(state.status);
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final e = state.products[index];
                      return RegularText(e.title ?? '', 16, kBlack);
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
