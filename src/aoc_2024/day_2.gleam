import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

fn is_list_safe(arr: List(Int)) -> Bool {
  let is_directions_correct =
    list.window_by_2(arr)
    |> list.map(fn(x) {
      case x.1 > x.0 {
        True -> 1
        False -> -1
      }
    })
    |> list.window_by_2()
    |> list.all(fn(x) { x.0 == x.1 })
  let are_diifs_correct =
    list.window_by_2(arr)
    |> list.all(fn(x) {
      let abs = int.absolute_value(x.0 - x.1)
      abs >= 1 && abs <= 3
    })
  is_directions_correct && are_diifs_correct
}

pub fn pt_1(input: String) {
  string.split(input, "\n")
  |> list.map(fn(x) {
    string.split(x, " ")
    |> list.map(fn(x) { x |> int.parse() |> result.unwrap(0) })
  })
  |> list.fold(0, fn(acc, arr) {
    case is_list_safe(arr) {
      True -> acc + 1
      False -> acc
    }
  })
}

fn remove_element_from_list(arr: List(Int), i: Int) -> List(Int) {
  list.index_map(arr, fn(x, index) { #(index, x) })
  |> list.filter(fn(x) { x.0 != i })
  |> list.map(fn(x) { x.1 })
}

fn check_permutations(arr: List(Int), i: Int) -> Bool {
  case i >= list.length(arr) {
    True -> False
    False -> {
      let new_arr = remove_element_from_list(arr, i)
      is_list_safe(new_arr) || check_permutations(arr, i + 1)
    }
  }
}

pub fn pt_2(input: String) {
  string.split(input, "\n")
  |> list.map(fn(x) {
    string.split(x, " ")
    |> list.map(fn(x) { x |> int.parse() |> result.unwrap(0) })
  })
  |> list.fold(0, fn(acc, arr) {
    case is_list_safe(arr) || check_permutations(arr, 0) {
      True -> acc + 1
      False -> acc
    }
  })
}
