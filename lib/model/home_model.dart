import 'dart:convert';

class HomeMo {
  HomeMo({
    this.items,
    this.totalCount,
  });

  List<HomeTabsMo?>? items;
  int? totalCount;

  factory HomeMo.fromRawJson(String str) => HomeMo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeMo.fromJson(Map<String, dynamic> json) => HomeMo(
        items: json["items"] == null
            ? []
            : List<HomeTabsMo>.from(
                json["items"].map((x) => HomeTabsMo.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x!.toJson())),
        "totalCount": totalCount,
      };
}

///Blue.Logistics.ContentManagement.Categories.Dtos.CmsCategoryDto
class HomeTabsMo {
  HomeTabsMo({
    this.articleIds,
    this.children,
    this.content,
    this.creationTime,
    this.creatorId,
    this.deleterId,
    this.deletionTime,
    this.description,
    this.displayContent,
    this.displayDescription,
    this.displayName,
    this.displayPageDescription,
    this.displayPageKeywords,
    this.displayPageTitle,
    this.displayTitle,
    this.id,
    this.isDeleted,
    this.isLeaf,
    this.lastModificationTime,
    this.lastModifierId,
    this.name,
    this.navId,
    this.pageDescription,
    this.pageKeywords,
    this.pageTitle,
    this.parentId,
    this.parentIdList,
    this.sortNum,
    this.title,
  });

  List<String?>? articleIds;
  List<HomeTabsMo?>? children;

  ///文章内容
  String? content;
  String? creationTime;
  String? creatorId;
  String? deleterId;
  String? deletionTime;

  ///文章摘要
  String? description;
  String? displayContent;
  String? displayDescription;
  String? displayName;
  String? displayPageDescription;
  String? displayPageKeywords;
  String? displayPageTitle;
  String? displayTitle;
  String? id;
  bool? isDeleted;
  bool? isLeaf;
  String? lastModificationTime;
  String? lastModifierId;

  ///分类名称
  String? name;

  ///栏目ID
  String? navId;

  ///SEO相关 页面描述
  String? pageDescription;

  ///SEO相关 页面关键词
  String? pageKeywords;

  ///SEO相关 页面标题
  String? pageTitle;

  ///父级ID
  String? parentId;
  List<String?>? parentIdList;

  ///分类排序
  int? sortNum;

  ///文章标题
  String? title;

  factory HomeTabsMo.fromRawJson(String str) =>
      HomeTabsMo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeTabsMo.fromJson(Map<String, dynamic> json) => HomeTabsMo(
        articleIds: json["articleIds"] == null
            ? []
            : List<String>.from(json["articleIds"].map((x) => x)),
        children: json["children"] == null
            ? []
            : List<HomeTabsMo>.from(
                json["children"].map((x) => HomeTabsMo.fromJson(x))),
        content: json["content"],
        creationTime: json[DateTime.parse(json["creationTime"])],
        creatorId: json["creatorId"],
        deleterId: json["deleterId"],
        deletionTime: json["deletionTime"],
        description: json["description"],
        displayContent: json["displayContent"],
        displayDescription: json["displayDescription"],
        displayName: json["displayName"],
        displayPageDescription: json["displayPageDescription"],
        displayPageKeywords: json["displayPageKeywords"],
        displayPageTitle: json["displayPageTitle"],
        displayTitle: json["displayTitle"],
        id: json["id"],
        isDeleted: json["isDeleted"],
        isLeaf: json["isLeaf"],
        lastModificationTime: json["lastModificationTime"],
        lastModifierId: json["lastModifierId"],
        name: json["name"],
        navId: json["navId"],
        pageDescription: json["pageDescription"],
        pageKeywords: json["pageKeywords"],
        pageTitle: json["pageTitle"],
        parentId: json["parentId"],
        parentIdList: json["parentIdList"] == null
            ? []
            : List<String>.from(json["parentIdList"].map((x) => x)),
        sortNum: json["sortNum"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "articleIds": articleIds == null
            ? []
            : List<dynamic>.from(articleIds!.map((x) => x)),
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x!.toJson())),
        "content": content,
        "creationTime": creationTime,
        "creatorId": creatorId,
        "deleterId": deleterId,
        "deletionTime": deletionTime,
        "description": description,
        "displayContent": displayContent,
        "displayDescription": displayDescription,
        "displayName": displayName,
        "displayPageDescription": displayPageDescription,
        "displayPageKeywords": displayPageKeywords,
        "displayPageTitle": displayPageTitle,
        "displayTitle": displayTitle,
        "id": id,
        "isDeleted": isDeleted,
        "isLeaf": isLeaf,
        "lastModificationTime": lastModificationTime,
        "lastModifierId": lastModifierId,
        "name": name,
        "navId": navId,
        "pageDescription": pageDescription,
        "pageKeywords": pageKeywords,
        "pageTitle": pageTitle,
        "parentId": parentId,
        "parentIdList": parentIdList == null
            ? []
            : List<dynamic>.from(parentIdList!.map((x) => x)),
        "sortNum": sortNum,
        "title": title,
      };
}
