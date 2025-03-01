type data = int
type answer = int
type node = { answer : answer; left : int; right : int }

let create : data -> answer = 
 fun value -> value

let combine : node -> node -> node =
 fun leftNode rightNode ->
  { answer = leftNode.answer + rightNode.answer ; left = leftNode.left; right = rightNode.right;}

let to_string : answer -> string = 
 fun value -> string_of_int value
