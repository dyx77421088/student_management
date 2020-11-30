import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DYXImageNetwork {
  static Widget network({@required String url,
    PlaceholderWidgetBuilder placeholder,
    LoadingErrorWidgetBuilder errorWidget,
    ImageWidgetBuilder imageBuilder
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: placeholder ?? _defaultPlaceholder,
      imageBuilder: imageBuilder,
      errorWidget: errorWidget ?? _defaultError,

    );

  }

  /// 默认无图片时显示的
  static Widget _defaultPlaceholder(BuildContext context, String url) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  /// 默认错误时显示的
  static Widget _defaultError(BuildContext context, String url, dynamic error) {
    print(error);

    return const Center(child: Icon(Icons.error));
  }

  /// 头像
  static Widget _avatarImg(ctx, image) => CircleAvatar(
    backgroundImage: image
  );

  static Widget avatarNetwork({@required String url,
    PlaceholderWidgetBuilder placeholder,
    LoadingErrorWidgetBuilder errorWidget,
  }) {
    return network(url: url, imageBuilder: _avatarImg, placeholder: placeholder, errorWidget: errorWidget);
  }
}