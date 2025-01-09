
import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/db_discount_service/db_discount_service.dart';
import 'package:spa_client_app/models/server/store_models/discount_model.dart';


class DiscountBlocState {
  final DiscountModel? discount;
  final List<DiscountModel> discountList;
  final bool loading;

  DiscountBlocState({
    this.discount,
    required this.discountList,
    required this.loading,
  });

  factory DiscountBlocState.initial() {
    return DiscountBlocState(discountList: [], loading: false);
  }

  DiscountBlocState copyWith({
    DiscountModel? discount,
    List<DiscountModel>? discountList,
    bool? loading,
  }) {
    return DiscountBlocState(
      discount: discount,
      discountList: discountList ?? this.discountList,
      loading: loading ?? this.loading,
    );
  }
}

class DiscountBloc extends Cubit<DiscountBlocState> {
  DiscountBloc() : super(DiscountBlocState.initial());
  final ScrollController scrollController = ScrollController();

  



  Future<void> getDiscounts() async {
    emit(state.copyWith(loading: true));
    final discounts = await DbDiscountService.read();
    emit(state.copyWith(discountList: discounts, loading: false));
  }



  // void _selectDiscount(DiscountModel discount) =>
  //     emit(state.copyWith(discount: discount));

  // Future<void> update(DiscountModel discount) async {
  //   if (discount.bgImageUrl.isNotEmpty) {
  //     discount.bgImageUrl = await UploadFilesService.ensureValidUrlTopUpload(
  //       localPath: discount.bgImageUrl,
  //       serverPath: 'discount_images/${discount.id}',
  //       createdAt: DateTime.now().toIso8601String(),
  //     );
  //   }
  //   _selectDiscount(discount);
  //   await _updateDiscount();
  // }

  // Future<void> _updateDiscount() async {
  //   await DbDiscountService.update(state.discount!);
  // }



  void reset() => emit(DiscountBlocState.initial());

  
}
