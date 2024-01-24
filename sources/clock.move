#[allow(unused_use)]
module sui_metaschool::clock {
  use sui::object::{Self, UID};
  use sui::transfer;
  use sui::tx_context::{Self, TxContext};
  use sui::clock::{Self, Clock};
  use sui::event;

  struct TimeEvent has copy, drop, store {
    timestamp_ms: u64
  }

  #[allow(unused_variable)]
  // clock at 0x6
  public entry fun get_timestamp_ms(clock: &Clock, ctx: &mut TxContext) {
    event::emit(TimeEvent {
      timestamp_ms: clock::timestamp_ms(clock),
    });
  }

}