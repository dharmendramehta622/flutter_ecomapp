import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/Networks/models/product_model.dart';
import 'package:new_project/resources/constants.dart';
import 'package:new_project/resources/routes.dart';
import 'package:new_project/resources/ui_utils.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.e, {super.key});

  final ProductModel e;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.detail, extra: e);
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 12,
        ),
        width: 154,
        height: 350,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          shadows: const [
            BoxShadow(
              color: Color(0x28000000),
              blurRadius: 6,
              offset: Offset(2, 2),
              spreadRadius: 1,
            )
          ],
        ),
        child: Stack(
          children: [
            //product image
            Positioned(
              left: -25,
              top: -5,
              child: Container(
                width: 183,
                height: 188,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(e.image ?? ''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            //add to favourite
            Positioned(
              right: 8,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  // context
                  //     .read<FavouriteBloc>()
                  //     .add(AddToFavourite(item: e.toMap()));
                  showSuccessMessage('Added to favourite successfully.');
                },
                child: const Icon(Icons.favorite, color: kRed600),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 10,
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 24,
                      child: RegularText(e.title ?? '', 16, kBlack),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                right: 0,
                bottom: 10,
                child: BoldText('\$${e.price}', 16, kBlack)),
          ],
        ),
      ),
    );
  }
}
