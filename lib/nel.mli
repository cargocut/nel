(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

(** Describes a non-empty list (usually expressed as [nel] for Non Empty
    List) (i.e. one containing at least one element). *)

(** {1 Types} *)

(** The type isn’t very original and overloads [::] ([cons]) to represent
    a pair consisting of an element and a (regular) list. As the sum
    does not contain [Nil], it is impossible to construct a non-empty
    list. *)
type 'a t = ( :: ) of 'a * 'a list

(** {1 Building non-empty list}

    A set of functions for constructing non-empty lists. *)

(** [make x xs] constructs a non-empty list with a head and a tail. *)
val make : 'a -> 'a list -> 'a t

(** [singleton x] constructs a non-empty list with just one element, [x]. *)
val singleton : 'a -> 'a t

(** [cons x nel] is [x :: nel]. *)
val cons : 'a -> 'a t -> 'a t

(** [from_list tl] attempts to convert a list into a non-empty
    list. Returns [None] if the given list [tl] is empty. *)
val from_list : 'a list -> 'a t option

(** [from_list_exn tl] attempts to convert a list into a non-empty list
    (like {!val:from_list} but raises [Invalid_argument "Nel.from_list_exn"]
    if the given list [tl] is empty). *)
val from_list_exn : 'a list -> 'a t

(** {1 Conversion} *)

(** [to_list nel] convert the given [nel] to a regular OCaml list. *)
val to_list : 'a t -> 'a list
