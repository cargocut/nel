(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

type 'a t = ( :: ) of 'a * 'a list

(* NOTE: The original implementations were created without paying
   particular attention to performance, with the goal of producing a
   well-tested and usable version. Improving performance is therefore
   open to contributions! *)

let make x xs = x :: xs
let singleton x = make x []
let cons x (y :: z) = x :: y :: z

let init len f =
  if len < 1
  then None
  else Some (make (f 0) (List.init (len - 1) (fun i -> f (i + 1))))
;;

let init_exn len f =
  match init len f with
  | None -> raise (Invalid_argument "Nel.init_exn")
  | Some x -> x
;;

let nth (x :: xs) n =
  if n < 0
  then None
  else if Int.equal n 0
  then Some x
  else List.nth_opt xs (n - 1)
;;

let nth_exn (x :: xs) n =
  if n < 0
  then raise (Invalid_argument "Nel.nth_exn")
  else if Int.equal n 0
  then x
  else List.nth xs (n - 1)
;;

let from_list list =
  let open List in
  match list with
  | [] -> None
  | x :: xs -> Some (make x xs)
;;

let from_list_exn list =
  match from_list list with
  | None -> raise (Invalid_argument "Nel.from_list_exn")
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

let rec last nel =
  match nel with
  | [ latest ] -> latest
  | _ :: x :: xs -> last (x :: xs)
;;

let rev_append_to_list (x :: xs) l2 =
  let rec aux acc first = function
    | List.[] -> first :: acc
    | List.(x :: xs) -> aux (first :: acc) x xs
  in
  aux l2 x xs
;;

let rev_append nel nel2 = rev_append_to_list nel (to_list nel2)
let rev nel = rev_append_to_list nel []
let append (x :: xs) (y :: ys) = make x (xs @ List.(y :: ys))
let equal eq (x :: xs) (y :: ys) = eq x y && List.equal eq xs ys

let compare cmp (x :: xs) (y :: ys) =
  let c = cmp x y in
  if Int.equal c 0 then List.compare cmp xs ys else c
;;

let compare_lengths (_ :: xs) (_ :: ys) = List.compare_lengths xs ys

let compare_length_with (_ :: xs) len =
  if len < 1 then 1 else List.compare_length_with xs (len - 1)
;;
