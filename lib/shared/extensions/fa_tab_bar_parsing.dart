enum FATabBar {
  // personality,
  attributes,
  recommendations,
}

extension FATabBarParsing on FATabBar {
  String get title {
    switch (this) {
      // case FATabBar.personality:
      //   return 'Personality';
      case FATabBar.attributes:
        return 'Attributes';
      case FATabBar.recommendations:
        return 'Recommendations';
    }
  }
}
