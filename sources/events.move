module sui_metaschool::events {
  use sui::event;
  use sui::object::{Self, UID};
  use sui::tx_context::{Self, TxContext};
  use sui::transfer;

  struct Hero has key, store {
    id: UID, 
    power: u8
  }

  struct Sword has key {
		id: UID
	}

  struct BuySwordEvent has copy, drop {
	  owner: address,
	}

  public entry fun buy_sword (ctx: &mut TxContext) {
    let sword = Sword { id: object::new(ctx) };
    event::emit(BuySwordEvent { owner: tx_context::sender(ctx) });
    transfer::transfer(sword, tx_context::sender(ctx));
  }

}