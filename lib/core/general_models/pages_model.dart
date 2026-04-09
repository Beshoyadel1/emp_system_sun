import 'package:flutter/material.dart';

class PageNodeModel {
  final String name;
  final int number;
  final String? image;
  final Widget? page;
  final List<PageNodeModel> children;

  const PageNodeModel({
    required this.name,
    required this.number,
    this.image,
    this.page,
    this.children = const [],
  });
}

class PageNodeWithIDModel {
  final String name;
  final int number;
  final Widget? page;
  final int id;

  const PageNodeWithIDModel({
    required this.name,
    required this.number,
    this.page,
    required this.id,
  });
}
