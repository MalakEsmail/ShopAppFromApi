import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/shop_app_cubit/shop_app_cubit.dart';

import '../../cubit/shop_app_cubit/shop_app_states.dart';
import '../../models/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) => ConditionalBuilder(
              condition: state is! ShopLoadingGetFavoriteState,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildFavItem(
                      ShopCubit.get(context).favoritesModel.data.data[index],
                      context),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount:
                      ShopCubit.get(context).favoritesModel.data.data.length),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
        listener: (context, state) {});
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Container(
                height: 120.0,
                width: 120.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      height: 120.0,
                      image: NetworkImage(model.product.image),
                      width: 120.0,
                     
                    ),
                    if (model.product.discount != 0)
                      Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'DISCOUNT',
                              style:
                                  TextStyle(fontSize: 8.0, color: Colors.white),
                            ),
                          ))
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product.price.round()}',
                          style: TextStyle(fontSize: 12.0, color: Colors.blue),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (model.product.discount != 0)
                          Text('${model.product.oldPrice.round()}',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough)),
                        Spacer(),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.product.id]
                                  ? Colors.red
                                  : Colors.grey,
                          child: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                size: 14.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorites(model.product.id);
                              }),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
