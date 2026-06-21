(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

type 'a t = ( :: ) of 'a * 'a list

let make x xs = x :: xs
let singleton x = make x []
let cons x (y :: z) = x :: y :: z

let from_list list =
  let open List in
  match list with
  | [] -> None
  | x :: xs -> Some (make x xs)
;;

let from_list_exn list =
  match from_list list with
  | None -> raise (Invalid_argument "from_list_exn")
  | Some x -> x
;;

let length (_ :: xs) = 1 + List.length xs
let to_list (x :: xs) = List.cons x xs

let is_singleton = function
  | _ :: [] -> true
  | _ :: _ -> false
;;

let hd (x :: _) = x
let tl (_ :: x) = x
