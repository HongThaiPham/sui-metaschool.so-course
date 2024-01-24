module sui_metaschool::bag {
  use std::string;
  use sui::tx_context::{Self, TxContext};
  use sui::bag::{Bag, Self};
  use sui::transfer;
  use sui::event;
  use sui::object::{Self, UID};

  struct BagContentEvent has copy, drop {
    key: string::String,
    value: string::String,
  }

  struct BagContent has key, store {
    id: UID,
    value: string::String,
  }

  public entry fun create(ctx: &mut TxContext) {
    let bag1 = bag::new(ctx);
    let content = BagContent {
      id: object::new(ctx),
      value: string::utf8(b"Hello"),
    };
    bag::add(&mut bag1, b"A", content);
    event::emit(BagContentEvent{key: string::utf8(b"A"), value: string::utf8(b"Hello")});
    transfer::public_transfer(bag1, tx_context::sender(ctx));
  }

  public entry fun add(bag: &mut Bag, key: vector<u8>, value: vector<u8>, ctx: &mut TxContext) {
    bag::add(bag, key, BagContent {
      id: object::new(ctx),
      value: string::utf8(value),
    });
    event::emit(BagContentEvent{key: string::utf8(key), value: string::utf8(value)});
  }

  public entry fun remove(bag: &mut Bag, key: vector<u8>, _ctx: &mut TxContext) {
    let BagContent {
      id,
      value: _,
    } = bag::remove(bag, key);
    object::delete(id);
  }
}