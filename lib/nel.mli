(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

(** Describes a non-empty list (usually expressed as [nel] for Non Empty
    List) (i.e. one containing at least one element). Most of the
    documentation was mostly done by {{:https://ocaml.org} OCaml
    Standard Library}. *)

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

(** [init len f] is [[f 0; f 1; ...; f (len-1)]], evaluated left to right.
    Return [None] if the given [len] is [< 1]. *)
val init : int -> (int -> 'a) -> 'a t option

(** Same of {!val:init} but raises [Invalid_argument "Nel.init_exn"] if
    the given [len] is [< 1]. *)
val init_exn : int -> (int -> 'a) -> 'a t

(** [singleton x] constructs a non-empty list with just one element, [x]. *)
val singleton : 'a -> 'a t

(** [return x] is [singleton x]. See {!val:singleton}. *)
val return : 'a -> 'a t

(** [from_list tl] attempts to convert a list into a non-empty
    list. Return [None] if the given list [tl] is empty. *)
val from_list : 'a list -> 'a t option

(** [from_list_exn tl] attempts to convert a list into a non-empty list
    (like {!val:from_list} but raises [Invalid_argument "Nel.from_list_exn"]
    if the given list [tl] is empty). *)
val from_list_exn : 'a list -> 'a t

(** {1 Facts} *)

(** [length nel] return the length (number of elements) of the given
    [nel]. Since it is a non-empty list, [length nel] always returns a
    number [>= 1]. *)
val length : 'a t -> int

(** [is_singleton nel] return [true] if the non-empty list holds only one
    element. [false] otherwise. *)
val is_singleton : 'a t -> bool

(** [hd nel] return the first element of the given list [nel]. Since the
    list cannot be empty, the function is total. *)
val hd : 'a t -> 'a

(** [tl nel] return the given list [nel] without the first element. Since
    the list can be a singleton, the tail is returned as a list (and
    not a non-empty list). *)
val tl : 'a t -> 'a list

(** [last nel] retun the latest element of the given [nel]. Since the list
    cannot be empty, the function is total. *)
val last : 'a t -> 'a

(** Return the [n]-th element of the given list. The first element (head
    of the list) is at position 0. If the result does not exits, it
    return [None]. *)
val nth : 'a t -> int -> 'a option

(** Same of {!val:nth} but raises [Invalid_argument "Nel.nth_exn"] if the
    given [n] is [< 1] and [Failure] if the index does not exists. *)
val nth_exn : 'a t -> int -> 'a

(** {1 Manipulation} *)

(** [cons x nel] is [x :: nel]. *)
val cons : 'a -> 'a t -> 'a t

(** Non Empty List reversal. *)
val rev : 'a t -> 'a t

(** [append nel1 nel2] appends [nel2] to [nel1]. *)
val append : 'a t -> 'a t -> 'a t

(** [rev_append nel1 nel2] reverses [nel1] and concatenates it with [nel2].
    This is equivalent to [append (rev nel1) nel2]. *)
val rev_append : 'a t -> 'a t -> 'a t

(** Concatenate a list of lists. The elements of the argument are all
    concatenated together (in the same order) to give the result.
    Not tail-recursive
    (length of the argument + length of the longest sub-list). *)
val concat : 'a t t -> 'a t

(** An alias for {!val:concat}. *)
val flatten : 'a t t -> 'a t

(** {1 Iteration} *)

(** [iter f nel] apply [f] on every element of [nel]. *)
val iter : ('a -> unit) -> 'a t -> unit

(** Same as {!val:iter} but the function is applied to the index of the
    element as first argument (counting from 0), and the element
    itself as second argument. *)
val iteri : (int -> 'a -> unit) -> 'a t -> unit

(** [map f nel] produce a new non-empty list applying [f] on every element
    of [nel]. *)
val map : ('a -> 'b) -> 'a t -> 'b t

(** See {!val:map} but the function is applied to the index of the element
    as first argument (counting from 0), and the element itself as
    second argument. *)
val mapi : (int -> 'a -> 'b) -> 'a t -> 'b t

(** Same as [rev (map f l)] but more efficient. *)
val rev_map : ('a -> 'b) -> 'a t -> 'b t

(** See {!val:rev_map} but the function is applied to the index of the element
    as first argument (counting from 0), and the element itself as
    second argument. *)
val rev_mapi : (int -> 'a -> 'b) -> 'a t -> 'b t

(** [concat_map f nel] is [concat (map f nel)]. *)
val concat_map : ('a -> 'b t) -> 'a t -> 'b t

(** [bind nel f] is [concat_map f nel]. See {!val:concat_map}. *)
val bind : 'a t -> ('a -> 'b t) -> 'b t

(** See {!val:concat_map} but the function is applied to the index of the element
    as first argument (counting from 0), and the element itself as
    second argument. *)
val concat_mapi : (int -> 'a -> 'b t) -> 'a t -> 'b t

(** [fold_left f init [b1; ...; bn]] is [f (... (f (f init b1) b2) ...) bn]. *)
val fold_left : ('acc -> 'a -> 'acc) -> 'acc -> 'a t -> 'acc

(** [fold_right f [a1; ...; an] init] is
    [f a1 (f a2 (... (f an init) ...))]. Not tail-recursive. *)
val fold_right : ('a -> 'acc -> 'acc) -> 'a t -> 'acc -> 'acc

(** [reduce f nel] is the semigroup reduction over a non-empty list. *)
val reduce : ('a -> 'a -> 'a) -> 'a t -> 'a

(* NOTE: I did not include [fold_lefti] and [fold_righti] because it can
   be implemented using [fold_left|right] easili. *)

(** {1 Comparison} *)

(** Equality between non-empty lists. *)
val equal : ('a -> 'a -> bool) -> 'a t -> 'a t -> bool

(** Comparison between non-empty lists. Use the same lexicographic
    heuristics than {!val:Stdlib.List.compare}. *)
val compare : ('a -> 'a -> int) -> 'a t -> 'a t -> int

(** Compare the lengths of two lists. [compare_lengths l1 l2] is
    equivalent to [compare (length l1) (length l2)], except that the
    computation stops after reaching the end of the shortest list. *)
val compare_lengths : 'a t -> 'a t -> int

(** Compare the length of a list to an integer.  [compare_length_with l len]
    is equivalent to [compare (length l) len], except that the
    computation stops after at most [len] iterations on the list. *)
val compare_length_with : 'a t -> int -> int

(** {1 Conversion} *)

(** [to_list nel] convert the given [nel] to a regular OCaml list. *)
val to_list : 'a t -> 'a list
