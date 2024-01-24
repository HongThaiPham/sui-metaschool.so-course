module sui_metaschool::calculator {
  use std::string;
  use sui::object::{Self, UID};
  use sui::transfer;
  use sui::tx_context::{Self, TxContext};
  use sui::event;

  struct Calculator has key, store {
    id: UID,
    a: u64,
    b: u64,
    operator: string::String,
    result: u64,
  }

  struct CalculatorEvent has copy, drop {
    a: u64,
    b: u64,
    operator: string::String,
    result: u64,
    from: address
  }

  public entry fun add(a: u64, b: u64, ctx: &mut TxContext) {
    let res = priv_add(a, b);
    event::emit(
      CalculatorEvent {
        a,
        b,
        operator: string::utf8(b"add"),
        result: res,
        from: tx_context::sender(ctx)
      }
    );
    transfer::transfer(
      Calculator {
        id: object::new(ctx),
        a,
        b,
        operator: string::utf8(b"add"),
        result: res,
      },
      tx_context::sender(ctx)
    );
  }

  public entry fun sub(a: u64, b: u64, ctx: &mut TxContext) {
    let res = priv_sub(a, b);
    event::emit(
      CalculatorEvent {
        a,
        b,
        operator: string::utf8(b"sub"),
        result: res,
        from: tx_context::sender(ctx)
      }
    );
    transfer::transfer(
      Calculator {
        id: object::new(ctx),
        a,
        b,
        operator: string::utf8(b"sub"),
        result: res,
      },
      tx_context::sender(ctx)
    );
  }


  public entry fun mul(a: u64, b: u64, ctx: &mut TxContext) {
    let res = priv_mul(a, b);
    event::emit(
      CalculatorEvent {
        a,
        b,
        operator: string::utf8(b"mul"),
        result: res,
        from: tx_context::sender(ctx)
      }
    );
    transfer::transfer(
      Calculator {
        id: object::new(ctx),
        a,
        b,
        operator: string::utf8(b"mul"),
        result: res,
      },
      tx_context::sender(ctx)
    )
  }


  public entry fun div(a: u64, b: u64, ctx: &mut TxContext) {
    let res = priv_div(a, b);
    event::emit(
      CalculatorEvent {
        a,
        b,
        operator: string::utf8(b"div"),
        result: res,
        from: tx_context::sender(ctx)
      }
    );
    transfer::transfer(
      Calculator {
        id: object::new(ctx),
        a,
        b,
        operator: string::utf8(b"div"),
        result: res,
      },
      tx_context::sender(ctx)
    )
  }

  fun priv_add(a: u64, b: u64) : u64 {
    a + b
  }

  fun priv_sub(a: u64, b: u64) : u64 {
    a - b
  }

  fun priv_mul(a: u64, b: u64) : u64 {
    a * b
  }

  fun priv_div(a: u64, b: u64) : u64 {
    a / b
  }
}