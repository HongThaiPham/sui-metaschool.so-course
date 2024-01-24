module sui_metaschool::animal {
  use std::string;
  use sui::object::{Self, UID};
  use sui::tx_context::{Self, TxContext};
  use sui::transfer;

  struct AnimeObject has key, store {
    id: UID,
    name: string::String,
    no_of_leg: u8,
    favorite_food: string::String
  }

  public entry fun construct(name: vector<u8>, no_of_leg: u8, favorite_food: vector<u8>, ctx: &mut TxContext) {
    let animal = AnimeObject {
      id: object::new(ctx),
      name: string::utf8(name),
      no_of_leg: no_of_leg,
      favorite_food: string::utf8(favorite_food)
    };

    transfer::transfer(animal, tx_context::sender(ctx));
  }
}