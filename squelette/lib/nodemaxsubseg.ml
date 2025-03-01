(*But : Trouver la suite de nombre dans le tableau formant la plus grande somme *)

type data = int
type answer = { sum : int; prefix : int; suffix : int; subseg : int }
type node = { answer : answer; left : int; right : int }

let create : data -> answer = 
  fun value -> { sum = value; prefix = value; suffix = value; subseg = value }

let combine : node -> node -> node =
  fun leftNode rightNode ->
    {
      answer = { sum = leftNode.answer.sum + rightNode.answer.sum ;
                 prefix = max leftNode.answer.prefix (leftNode.answer.sum + rightNode.answer.prefix) ;
                 suffix = max rightNode.answer.suffix (rightNode.answer.sum + leftNode.answer.suffix) ;
                 subseg = max (max leftNode.answer.subseg rightNode.answer.subseg) (leftNode.answer.suffix + rightNode.answer.prefix) 
               }; 
      left = leftNode.left;
      right = rightNode.right;
    }

let to_string : answer -> string = 
  fun value -> string_of_int value.subseg 
