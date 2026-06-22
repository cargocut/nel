(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

type 'a t = ( :: ) of 'a * 'a list

(* NOTE: The original implementations were created without paying
   particular attention to performance, with the goal of producing a
   well-tested and usable version. Improving performance is therefore
   open to contributions! *)

(* NEXT: The Preface implementation, thanks to @mbarbin, includes more
   refined optimizations that we might need to adopt someday, but
   without a benchmark, I'm not convinced it's necessary at this
   point. See: https://github.com/xvw/preface/pull/191 *)

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
let concat ((x :: xs) :: rest) = x :: (xs @ List.concat_map to_list rest)
let flatten = concat

let iter f (x :: xs) =
  f x;
  List.iter f xs
;;

let iteri f (x :: xs) =
  f 0 x;
  List.iteri (fun i x -> f (i + 1) x) xs
;;

let map f (x :: xs) = f x :: List.map f xs
let mapi f (x :: xs) = f 0 x :: List.mapi (fun i x -> f (i + 1) x) xs

let rev_map f (x :: xs) =
  let rec aux acc first = function
    | List.[] -> first :: acc
    | List.(x :: xs) -> aux (first :: acc) (f x) xs
  in
  aux [] (f x) xs
;;

let rev_mapi f (x :: xs) =
  let rec aux acc first n = function
    | List.[] -> first :: acc
    | List.(x :: xs) -> aux (first :: acc) (f n x) (n + 1) xs
  in
  aux [] (f 0 x) 1 xs
;;

let concat_map f nel =
  (* KLUDGE: Maybe it can be improved. *)
  concat (map f nel)
;;

let concat_mapi f nel =
  (* KLUDGE: Maybe it can be improved. *)
  concat (mapi f nel)
;;

let fold_left f default (x :: xs) = List.fold_left f (f default x) xs
let fold_right f (x :: xs) default = f x (List.fold_right f xs default)
let reduce f (x :: xs) = List.fold_left f x xs
let for_all pred (x :: xs) = pred x && List.for_all pred xs
let for_some pred (x :: xs) = pred x || List.exists pred xs
let exists = for_some
let mem x = for_some (( = ) x)
let memq x = for_some (( == ) x)
let find pred (x :: xs) = if pred x then Some x else List.find_opt pred xs

let find_map pred (x :: xs) =
  let rec aux = function
    | List.[] -> None
    | List.(x :: xs) ->
      (match pred x with
       | None -> aux xs
       | Some x -> Some x)
  in
  aux List.(x :: xs)
;;

let find_mapi pred (x :: xs) =
  let rec aux n = function
    | List.[] -> None
    | List.(x :: xs) ->
      (match pred n x with
       | None -> aux (n + 1) xs
       | Some x -> Some x)
  in
  aux 0 List.(x :: xs)
;;

let findi pred = find_mapi (fun i x -> if pred i x then Some x else None)
let find_index pred = find_mapi (fun i x -> if pred x then Some i else None)
let equal eq (x :: xs) (y :: ys) = eq x y && List.equal eq xs ys

let compare cmp (x :: xs) (y :: ys) =
  let c = cmp x y in
  if Int.equal c 0 then List.compare cmp xs ys else c
;;

let compare_lengths (_ :: xs) (_ :: ys) = List.compare_lengths xs ys

let compare_length_with (_ :: xs) len =
  if len < 1 then 1 else List.compare_length_with xs (len - 1)
;;

let return = singleton
let bind nel f = concat_map f nel
