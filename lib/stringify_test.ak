use aiken/builtin
use cardano/address.{Address, Inline, Script, VerificationKey}
use cardano/assets
use cardano/transaction.{
  InlineDatum, Input, Mint, NoDatum, Output, OutputReference, Spend, Transaction,
}
use debug

test log_int() {
  1 |> debug.int(@"int")
  True
}

test log_value() {
  assets.from_lovelace(111_000_000)
    |> assets.add("pid", "name", 1)
    |> debug.value(@"value")
  True
}

test log_input() {
  Input {
    output_reference: OutputReference("tx_0", 0),
    output: Output {
      value: assets.from_lovelace(111_000_000) |> assets.add("pid", "name", 1),
      address: Address {
        payment_credential: Script("script_hash"),
        stake_credential: None,
      },
      datum: NoDatum,
      reference_script: None,
    },
  }
    |> debug.input(@"input")
  True
}

test log_output() {
  Output {
    value: assets.from_lovelace(111_000_000) |> assets.add("pid", "name", 1),
    address: Address {
      payment_credential: Script("script_hash"),
      stake_credential: None,
    },
    datum: NoDatum,
    reference_script: None,
  }
    |> debug.output(@"output")
  True
}

type MyDatum {
  bytes: ByteArray,
  int: Int,
  str: String,
  int_list: List<Int>,
  bytes_list: List<ByteArray>,
}

test log_output_2() {
  Output {
    value: assets.from_lovelace(111_000_000) |> assets.add("pid", "name", 1),
    address: Address {
      payment_credential: Script("script_hash"),
      stake_credential: None,
    },
    datum: InlineDatum(
      MyDatum {
        bytes: "bytes",
        int: 1,
        str: @"str",
        int_list: [1, 2, 3, 4],
        bytes_list: ["1", "2", "3"],
      },
    ),
    reference_script: None,
  }
    |> debug.output(@"output with datum")
  True
}

test log_data() {
  MyDatum {
    bytes: "bytes",
    int: 1,
    str: @"str",
    int_list: [1, 2, 3, 4],
    bytes_list: ["1", "2", "3"],
  }
    |> debug.data(@"data")
  True
}

test log_tx() {
  let t = transaction.placeholder
  let d: Data =
    MyDatum {
      bytes: "bytes",
      int: 1,
      str: @"str",
      int_list: [1, 2, 3, 4],
      bytes_list: ["1", "2", "3"],
    }
  Transaction {
    ..t,
    redeemers: [
      Pair(Spend(OutputReference("tx_1", 12)), builtin.i_data(0)),
      Pair(Mint("policy"), d),
      ..t.redeemers
    ],
    extra_signatories: ["sig1", "sig2"],
    mint: assets.from_asset("policy_id", "asset_name", 112)
      |> assets.add("policy_id", "asset_name_2", 1),
    inputs: [
      Input {
        output_reference: OutputReference("tx_1", 12),
        output: Output {
          value: assets.from_lovelace(2_000_000),
          address: Address {
            payment_credential: VerificationKey("public_key"),
            stake_credential: Some(Inline(VerificationKey("stake_key"))),
          },
          datum: NoDatum,
          reference_script: None,
        },
      },
    ],
    outputs: [
      Output {
        value: assets.from_lovelace(111_000_000) |> assets.add("pid", "name", 1),
        address: Address {
          payment_credential: Script("script_hash"),
          stake_credential: None,
        },
        datum: InlineDatum(
          MyDatum {
            bytes: "bytes",
            int: 1,
            str: @"str",
            int_list: [1, 2, 3, 4],
            bytes_list: ["1", "2", "3"],
          },
        ),
        reference_script: None,
      },
      Output {
        value: assets.from_lovelace(2_000_000),
        address: Address {
          payment_credential: VerificationKey("public_key"),
          stake_credential: Some(Inline(VerificationKey("stake_key"))),
        },
        datum: NoDatum,
        reference_script: None,
      },
    ],
  }
    |> debug.tx
  True
}

test any_1() {
  1 |> debug.data(@"int")
  None |> debug.data(@"None")
  Some(1) |> debug.data(@"Some(1)")
  assets.from_lovelace(123_456)
    |> assets.add("pid", "name", -1)
    |> assets.to_dict
    |> debug.data(@"Dict")
  (1, 2, [1, 2, 3]) |> debug.data(@"Tuple")
  [1, 2, 3] |> debug.data(@"List")
  True
}

test bytearray_1() {
  "627974656172726179" |> debug.bytearray(@"ByteArray")
  True
}

test bytearray_2() {
  #"fab2208123" |> debug.bytearray(@"ByteArray")
  True
}
