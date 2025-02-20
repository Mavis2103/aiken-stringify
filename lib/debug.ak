use aiken/builtin
use aiken/primitive/string
use cardano/address.{Address, Credential}
use cardano/assets.{Value}
use cardano/transaction.{
  Datum, Input, Output, OutputReference, Redeemer, ScriptPurpose, Transaction,
}
use stringify

fn debug(self: a, name: String, serializer: fn(a) -> String) -> Void {
  builtin.debug(string.concat(name, serializer(self)), self) |> fn(_) { Void }
}

pub fn diagnostic(self: a, name: String, d: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    fn(_) { stringify.format_cbor(d) |> stringify.indent },
  )
}

pub fn data(self: Data, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.data,
  )
}

pub fn tx(self: Transaction) {
  debug(
    self,
    @"\n",
    stringify.tx,
  )
}

pub fn input(self: Input, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.input,
  )
}

pub fn output(self: Output, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.output,
  )
}

pub fn value(self: Value, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.value,
  )
}

pub fn minted_value(self: Value, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.value,
  )
}

pub fn int(self: Int, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    string.from_int,
  )
}

pub fn redeemers(self: Pairs<ScriptPurpose, Redeemer>, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.redeemers,
  )
}

pub fn credential(self: Credential, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.credential,
  )
}

pub fn out_ref(self: OutputReference, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.out_ref,
  )
}

pub fn address(self: Address, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.address,
  )
}

pub fn datum(self: Datum, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.datum,
  )
}

pub fn bytearray(self: ByteArray, name: String) {
  debug(
    self,
    string.concat(
      name,
      @"\n",
    ),
    stringify.bytearray,
  )
}
