
class ProductModel
{
  String? name,cate,desc,img,id;
  int? price,item_count;
  bool? like=false;

  ProductModel({this.name, this.price, this.cate, this.desc,this.img,this.id,this.like,this.item_count});
}

class AddressModel
{
  String? street,city,state,zipcod,cno;

  AddressModel({this.street, this.city, this.state, this.zipcod, this.cno});
}

class CouponModel
{
  String? img,title,desc;

  CouponModel({this.img, this.title, this.desc});
}