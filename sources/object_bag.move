module sui_metaschool::object_bag {
  use std::string;
  use sui::object::{Self, UID};
  use sui::object_bag::{Self, ObjectBag};
  use sui::tx_context::{Self, TxContext};
  use sui::transfer;

  struct BagContent has key, store {
    id: UID,
    value: string::String,
  } 

  public entry fun create(ctx: &mut TxContext) {
    let obj_bag: ObjectBag = object_bag::new(ctx);
    let bag_content = BagContent {
      id: object::new(ctx),
      value: string::utf8(b"Leo Pham")
    };
    object_bag::add(&mut obj_bag, string::utf8(b"A"), bag_content);
    
    transfer::public_transfer(obj_bag, tx_context::sender(ctx));
  }

  public entry fun add(obj_bag: &mut ObjectBag, key: vector<u8>, value: vector<u8>, ctx: &mut TxContext) {
    object_bag::add(obj_bag, string::utf8(key) , BagContent {
      id: object::new(ctx),
      value: string::utf8(value)
    });
  }
}