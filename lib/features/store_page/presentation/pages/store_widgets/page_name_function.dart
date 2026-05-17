import '../../../../../core/general_models/pages_model.dart';

PageNodeModel? findPageByNumber(int pageNumber, List<PageNodeModel> pages) {
  for (PageNodeModel page in pages) {
    if (page.number == pageNumber) {
      return page;
    }
    if (page.children.isNotEmpty) {
      final foundInChild = findPageByNumber(pageNumber, page.children);
      if (foundInChild != null) {
        return foundInChild;
      }
    }
  }
  return null;
}
