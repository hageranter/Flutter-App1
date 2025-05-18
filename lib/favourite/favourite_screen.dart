import 'package:flutter/material.dart';
import 'package:myapp/favourite/favourite_model.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Consumer<FavoriteModel>(
      builder: (context, favModel, _) {
      return badges.Badge(
        badgeContent: Text(
          '${favModel.fav.length}',
          style: const TextStyle(color: Colors.white),
        ),
        position: badges.BadgePosition.topEnd(top: -12, end: -12),
        child: const Icon(Icons.favorite),
        badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.red,
        ),
      );
    },
  ),
        centerTitle: true,
      ),
      body: Consumer<FavoriteModel>(
        child: const Center(child: Text("No favourites")),
        builder: (context, favModel, child) {
          final favList = favModel.fav;
          return favList.isEmpty
              ? child!
              : GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: favList.length,
                  itemBuilder: (context, index) {
                    final item = favList[index];

                    return Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          if (item.images.isNotEmpty)
                            Image.memory(
                              item.images.first,
                              height: 125,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          else
                            Container(
                              height: 125,
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    favModel.removeItem(item);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Removed from favourites"),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.favorite),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
