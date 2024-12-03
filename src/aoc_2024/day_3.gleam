import gleam/int
import gleam/io
import gleam/list
import gleam/regexp
import gleam/result
import gleam/string

// fn find_muls(input: List(String), seq: String) -> Int {
//   case input {
//     [char, ..rest] -> {
//       let goal = string.slice("mul(", string.length(seq), 1)
//       case seq, char {
//         _, ")" -> {
//           let nums =
//             string.slice(seq, 1, string.length(seq))
//             |> string.split_once(",")
//           io.debug(nums)
//           case nums {
//             Ok(nums) -> {
//               let first = int.parse(nums.0)
//               let second = int.parse(nums.1)
//               case first, second {
//                 Ok(first), Ok(second) -> {
//                   first * second + find_muls(rest, "")
//                 }
//                 _, _ -> find_muls(rest, "")
//               }
//             }
//             Error(e) -> find_muls(rest, "")
//           }
//         }
//         _, ","
//         | _, "1"
//         | _, "2"
//         | _, "3"
//         | _, "4"
//         | _, "5"
//         | _, "6"
//         | _, "7"
//         | _, "8"
//         | _, "9"
//         | _, "0"
//         | _, "("
//         | "m", "u"
//         | "mu", "l"
//         | "mul", "("
//         -> find_muls(rest, seq <> char)
//         _, _ -> find_muls(rest, "")
//       }
//     }
//     [] -> 0
//   }
// }

pub fn pt_1(input: String) {
  let assert Ok(re) = regexp.from_string("mul\\(\\d+,\\d+\\)")
  regexp.scan(re, input)
  |> list.try_map(fn(x) {
    x.content
    |> string.slice(4, string.length(x.content) - 5)
    |> string.split_once(",")
    |> result.map(fn(x) {
      let first = int.parse(x.0)
      let second = int.parse(x.1)
      case first, second {
        Ok(first), Ok(second) -> first * second
        _, _ -> 0
      }
    })
  })
  |> result.map(fn(x) { list.fold(x, 0, fn(acc, x) { acc + x }) })
}

fn list_runner(input: List(String), mult: Int) -> Int {
  case input {
    ["don't()", ..rest] -> {
      list_runner(rest, 0)
    }
    ["do()", ..rest] -> {
      list_runner(rest, 1)
    }
    [x, ..rest] -> {
      let sum =
        x
        |> string.slice(4, string.length(x) - 5)
        |> string.split_once(",")
        |> result.map(fn(x) {
          let first = int.parse(x.0)
          let second = int.parse(x.1)
          case first, second {
            Ok(first), Ok(second) -> first * second * mult
            _, _ -> 0
          }
        })
        |> result.unwrap(0)
      sum + list_runner(rest, mult)
    }
    [] -> 0
  }
}

pub fn pt_2(input: String) {
  let assert Ok(re) =
    regexp.from_string("(mul\\(\\d+,\\d+\\)|don't\\(\\)|do\\(\\))")
  regexp.scan(re, input)
  |> list.map(fn(x) { x.content })
  |> list_runner(1)
}
