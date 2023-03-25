import 'package:bloc/bloc.dart';
import '../../../repositories/products/myorders/my_orders_repo.dart';
import './bloc.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc() : super(InitialOrderListState()) {
    on<GetOrderList>(_getOrderList);
  }
}

void _getOrderList(GetOrderList event, Emitter<OrderListState> emit) async {
  //ApiProvider _apiProvider = ApiProvider();

  emit(OrderListWaiting());
  try {
    var data = await MyOrdersRepositories().myOrdersData();
    emit(GetOrderListSuccess(orderListData: data.orderhistory));
    print(data.message);
  } catch (ex) {
    if (ex != 'cancel') {
      emit(OrderListError(errorMessage: ex.toString()));
    }
  }
}
