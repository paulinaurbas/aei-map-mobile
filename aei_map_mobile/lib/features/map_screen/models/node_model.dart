class Node {
  int order;
  int x;
  int y;

  Node.fromJson(Map<dynamic, dynamic> json)
      :  x = json["x"],
         order = json["order"],
         y = json["y"];

  Node(this.x, this.y, this.order);

}

