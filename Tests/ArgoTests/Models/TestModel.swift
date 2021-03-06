import Argo
import Curry
import Runes

struct TestModel {
  let numerics: TestModelNumerics
  let string: String
  let bool: Bool
  let stringArray: [String]
  let stringArrayOpt: [String]?
  let eStringArray: [String]
  let eStringArrayOpt: [String]?
  let userOpt: User?
  let dict: [String: String]
}

extension TestModel: Argo.Decodable {
  static func decode(_ json: JSON) -> Decoded<TestModel> {
    let curriedInit = curry(self.init)
    return curriedInit
      <^> json["numerics"]
      <*> json["user_opt", "name"]
      <*> json["bool"]
      <*> json["string_array"]
      <*> json[optional: "string_array_opt"]
      <*> json["embedded", "string_array"]
      <*> json[optional: "embedded", "string_array_opt"]
      <*> json[optional: "user_opt"]
      <*> json["dict"]
  }
}

struct TestModelNumerics {
  let int: Int
  let int64: Int64
  let int64String: Int64
  let double: Double
  let float: Float
  let intOpt: Int?
  let uint: UInt
  let uint64: UInt64
  let uint64String: UInt64
}

extension TestModelNumerics: Argo.Decodable {
  static func decode(_ json: JSON) -> Decoded<TestModelNumerics> {
    let f = curry(self.init)
      <^> json["int"]
      <*> json["int64"]
      <*> json["int64_string"]
      <*> json["double"]
      <*> json["float"]
      <*> json[optional: "int_opt"]

    return f
      <*> json["uint"]
      <*> json["uint64"]
      <*> json["uint64_string"]
  }
}
