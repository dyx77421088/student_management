import 'package:student_management/ui/shared/size_fit.dart';

extension intFit on int {
  double get px {
    return DYXSizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return DYXSizeFit.setRpx(this.toDouble());
  }
}