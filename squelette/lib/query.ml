open Sig

module Make (N : NODE) : QUERY_STRUCTURE = struct
  type tree = N.node Sig.binary_tree
  type data = int
  type answer = N.answer

  let to_string = N.to_string

  (*Separe une liste de 2^n éléments en un tuple de 2 listes*)
  let separe : 'a list -> ('a list * 'a list) = fun lst ->
    let rec aux = fun lst acc -> 
      match lst with
      | [] -> ([],[])
      | h::t when List.length acc = ((List.length t) - 1) -> (List.rev (h::acc), t)
      | h::t -> aux t (h::acc)
    in aux lst []  
  
  (* Crée une liste d'indice de 0 à n (n un entier donné en paramètres)*)
  let newIndList : int -> int list = fun i ->
    let rec aux = fun acc compteur ->
      if compteur = i then (List.rev acc)
      else aux (compteur::acc) (compteur+1) 
    in aux [] 0

  (* Création de l’arbre *)
  let create : data list -> tree = 
    fun list -> 
      let indLst = newIndList (List.length list) in
      (* Début de la récursivité *)
      let rec aux = fun lst ->
        match lst with 
        | [x] -> Leaf {node = {N.answer = (N.create (List.nth list x)); left = x; right = x}}
        | _ -> let seratedList = (separe lst) in
            let childs = [(aux (fst seratedList));(aux (snd seratedList))] in 
            match childs with
            | [(Leaf {node = n1}) ; (Leaf {node = n2})] -> 
              Node {node = (N.combine n1 n2) ; left_child = (List.hd childs) ; right_child = (List.hd (List.tl childs))}
            | [(Node {node = n1; left_child = _; right_child = _}) ; (Node {node = n2; left_child = _; right_child = _})] ->
              Node {node = (N.combine n1 n2) ; left_child = (List.hd childs) ; right_child = (List.hd (List.tl childs))}
            | _ -> Leaf {node = {answer = (N.create 0); left = 0; right = 0}}
      in aux indLst

  (* Mise à jour d’un élément de la liste *)
    let update : tree -> data -> int -> tree =
      fun tree data ind -> 
        let rec update_rec = 
          fun tree ->
            match tree with
            | Leaf { node = _ } -> Leaf { node = {N.answer = (N.create data); left = ind; right = ind }}
            | Node { node = {N.answer = _;left; right}; left_child; right_child} ->
                let milieu = (left + right) / 2 in 
                let extract = fun tree -> 
                  match tree with 
                  | Leaf {node} -> node
                  | Node {node; _} -> node in
                if milieu >= ind then
                  let n1 = (update_rec left_child) in 
                  Node { node = N.combine (extract n1) (extract right_child) ; left_child = n1 ; right_child = right_child}
                else
                  let n2 = (update_rec right_child) in 
                  Node { node = N.combine (extract left_child) (extract n2) ; left_child = left_child ; right_child = n2} 
        in update_rec tree

    let query : tree -> int -> int -> answer = 
      fun tree lb rb -> let rec aux = fun t -> 
          match t with 
          | Leaf {node = {N.answer = a; left = l; right = r}} -> {N.answer = a; left = l; right = r}
          | Node {node = {N.answer = a; left = l; right = r}; left_child = lc; right_child = rc} ->
              let mid = (l + r) / 2 in
              if (lb <= l && rb >= r) then {N.answer = a; left = l; right = r} else
              if (rb <= mid) then aux lc else
              if (lb >= (mid + 1)) then aux rc 
              else N.combine (aux lc) (aux rc)
        in (aux tree).answer
end
