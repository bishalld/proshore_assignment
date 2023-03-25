import 'package:meta/meta.dart';

@immutable
abstract class OrderListEvent {}

class GetOrderList extends OrderListEvent {}
