import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/db_product_service/db_product_service.dart';
import 'package:spa_client_app/models/server/store_models/product_model.dart';


class ProductBlocState {
  final List<ProductModel> products;
  final ProductModel? selectedProduct;

  ProductBlocState({
    required this.products,
    this.selectedProduct,
  });

  factory ProductBlocState.initial() {
    return ProductBlocState(products: []);
  }

  ProductBlocState copyWith(
      {List<ProductModel>? products, ProductModel? selectedProduct}) {
    return ProductBlocState(
      products: products ?? this.products,
      selectedProduct: selectedProduct,
    );
  }
}

class ProductBloc extends Cubit<ProductBlocState> {
  ProductBloc() : super(ProductBlocState.initial());
  final scrollController = ScrollController();



  Future<void> getProducts() async {
    final products = await DbProductService.read();
    // products.sort((a, b) => a.id!.compareTo(b.id!));
    emit(state.copyWith(products: products, selectedProduct: null));
  }




  void rest() => emit(ProductBlocState.initial());
}
