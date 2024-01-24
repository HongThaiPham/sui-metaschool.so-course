module sui_metaschool::table {
  use std::string;
  use sui::object::{Self, UID};
  use sui::transfer;
  use sui::table;
  use sui::tx_context::{Self, TxContext};

  struct ContentObject has key, store {
    id: UID,
    value: string::String,
  } 

  public entry fun create(ctx: &mut TxContext) {
    let tbl = table::new(ctx);
    table::add(&mut tbl, string::utf8(b"A"), ContentObject {
      id: object::new(ctx),
      value: string::utf8(b"Leo Pham"),
    });
    transfer::public_transfer(tbl, tx_context::sender(ctx));
  }
}