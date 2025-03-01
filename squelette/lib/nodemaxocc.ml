type data = int
type answer = int * int
type node = { answer : answer; left : int; right : int }

(*On crée un noeud à l'aide d'un tuple qui prend data et le nombre d'occurence max qui est 1 car on veut pas de doublons ce qui va bien retourner answer qui est intint *)
let create : data -> answer = 
 fun value -> (value,1)

  let combine : node -> node -> node =
    fun leftNode rightNode ->
     {
       (*On prend la réponse ayant la plus grande valeur maximale.
          Si jamais elles ont les mêmes valeurs, alors il suffit de prendre
          la gauche et de combiner les occurrences.*)
       answer = 
         (if fst leftNode.answer > fst rightNode.answer then leftNode.answer
          else if fst leftNode.answer < fst rightNode.answer then rightNode.answer
          else (fst leftNode.answer, snd leftNode.answer + snd rightNode.answer)); 
       left = leftNode.left;
       right =  rightNode.right;
     }

let to_string : answer -> string = 
(*comme le sujet*)
 fun value ->
  "(" ^ string_of_int (fst value) ^ ", " ^ string_of_int (snd value) ^ ")"