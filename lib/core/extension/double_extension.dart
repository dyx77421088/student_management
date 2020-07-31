import 'package:student_management/ui/shared/size_fit.dart';

extension intFit on double {
  double get px {
    return DYXSizeFit.setPx(this);
  }

  double get rpx {
    return DYXSizeFit.setRpx(this);
  }
}