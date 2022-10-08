import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

int convertMonthlyFee(PaymentCycle paymentCycle, int fee) {
  int monthlyFee = 0;
  switch (paymentCycle) {
    case PaymentCycle.oneMonth:
      monthlyFee = fee;
      break;
    case PaymentCycle.twoMonths:
      monthlyFee = (fee / 2).round();
      break;
    case PaymentCycle.threeMonths:
      monthlyFee = (fee / 3).round();
      break;
    case PaymentCycle.sixMonths:
      monthlyFee = (fee / 6).round();
      break;
    case PaymentCycle.year:
      monthlyFee = (fee / 12).round();
      break;
  }
  return monthlyFee;
}
