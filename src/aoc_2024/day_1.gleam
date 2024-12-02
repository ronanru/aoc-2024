import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn pt_1(input: String) {
  let numbers =
    string.split(input, "\n")
    |> list.map(fn(x) {
      string.split(x, "   ")
      |> list.map(fn(x) { x |> int.parse() |> result.unwrap(0) })
    })
  use first_numbers <- result.map(list.try_map(numbers, list.first))
  use second_numbers <- result.map(list.try_map(numbers, list.last))

  let first_numbers = list.sort(first_numbers, int.compare)
  let second_numbers = list.sort(second_numbers, int.compare)

  list.map2(first_numbers, second_numbers, fn(a, b) {
    io.debug([a, b])
    int.absolute_value(a - b)
  })
  |> list.fold(0, int.add)
}

pub fn pt_2(input: String) {
  let numbers =
    string.split(input, "\n")
    |> list.map(fn(x) {
      string.split(x, "   ")
      |> list.map(fn(x) { x |> int.parse() |> result.unwrap(0) })
    })
  use first_numbers <- result.map(list.try_map(numbers, list.first))
  use second_numbers <- result.map(list.try_map(numbers, list.last))

  let first_numbers = list.sort(first_numbers, int.compare)
  let second_numbers = list.sort(second_numbers, int.compare)

  list.map(first_numbers, fn(x) {
    x * list.count(second_numbers, fn(a) { a == x })
  })
  |> list.fold(0, int.add)
}
