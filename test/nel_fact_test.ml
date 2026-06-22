(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

open struct
  (* NOTE: [open struct end] allows us to not have an mli and ensure that
     all tests are properly handled. *)

  open Alcotest

  let length0 =
    test_case "length" `Quick (fun () ->
      let expected = 1
      and computed = Nel.length (Nel.singleton 1) in
      check int "should be equal" expected computed)
  ;;

  let length1 =
    test_case "length" `Quick (fun () ->
      let expected = 6
      and computed = Nel.length (Nel.make 1 [ 2; 3; 4; 5; 6 ]) in
      check int "should be equal" expected computed)
  ;;

  let is_singleton0 =
    test_case "is_singleton" `Quick (fun () ->
      let expected = true
      and computed = Nel.is_singleton (Nel.singleton 1) in
      check bool "should be equal" expected computed)
  ;;

  let is_singleton1 =
    test_case "is_singleton" `Quick (fun () ->
      let expected = false
      and computed = Nel.is_singleton (Nel.make 1 [ 2; 3; 4; 5; 6 ]) in
      check bool "should be equal" expected computed)
  ;;

  let hd0 =
    test_case "hd" `Quick (fun () ->
      let expected = 1
      and computed = Nel.hd (Nel.make 1 [ 2; 3; 4 ]) in
      check int "should be equal" expected computed)
  ;;

  let hd1 =
    test_case "hd" `Quick (fun () ->
      let expected = 1
      and computed = Nel.hd (Nel.singleton 1) in
      check int "should be equal" expected computed)
  ;;

  let tl0 =
    test_case "tl" `Quick (fun () ->
      let expected = [ 2; 3; 4 ]
      and computed = Nel.tl (Nel.make 1 [ 2; 3; 4 ]) in
      check (list int) "should be equal" expected computed)
  ;;

  let tl1 =
    test_case "tl" `Quick (fun () ->
      let expected = []
      and computed = Nel.tl (Nel.singleton 1) in
      check (list int) "should be equal" expected computed)
  ;;

  let equal0 =
    test_case "equal" `Quick (fun () ->
      let expected = true
      and computed =
        Nel.equal Int.equal Nel.(make 1 [ 2; 3; 4 ]) Nel.(1 :: 2 :: 3 :: [ 4 ])
      in
      check bool "should be equal" expected computed)
  ;;

  let equal1 =
    test_case "equal" `Quick (fun () ->
      let expected = false
      and computed =
        Nel.equal Int.equal Nel.(make 1 [ 3; 4 ]) Nel.(1 :: 2 :: 3 :: [ 4 ])
      in
      check bool "should be equal" expected computed)
  ;;

  let compare0 =
    test_case "compare" `Quick (fun () ->
      let expected = 0
      and computed =
        Nel.compare
          Int.compare
          Nel.(make 1 [ 2; 3; 4 ])
          Nel.(1 :: 2 :: 3 :: [ 4 ])
      in
      check int "should be equal" expected computed)
  ;;

  let compare1 =
    test_case "compare" `Quick (fun () ->
      let expected = 1
      and computed =
        Nel.compare
          Int.compare
          Nel.(make 3 [ 2; 3; 4 ])
          Nel.(1 :: 2 :: 3 :: [ 4 ])
      in
      check int "should be equal" expected computed)
  ;;

  let compare2 =
    test_case "compare" `Quick (fun () ->
      let expected = -1
      and computed =
        Nel.compare
          Int.compare
          Nel.(make 0 [ 2; 3; 4 ])
          Nel.(1 :: 2 :: 3 :: [ 4 ])
      in
      check int "should be equal" expected computed)
  ;;

  let compare_lengths0 =
    test_case "compare_lengths" `Quick (fun () ->
      let expected = 0
      and computed =
        Nel.compare_lengths Nel.(make 0 [ 2; 3; 4 ]) Nel.(1 :: 2 :: 3 :: [ 4 ])
      in
      check int "should be equal" expected computed)
  ;;

  let compare_lengths1 =
    test_case "compare_lengths" `Quick (fun () ->
      let expected = -1
      and computed =
        Nel.compare_lengths Nel.(make 0 [ 2; 3 ]) Nel.(1 :: 2 :: 3 :: [ 4 ])
      in
      check int "should be equal" expected computed)
  ;;

  let compare_lengths2 =
    test_case "compare_lengths" `Quick (fun () ->
      let expected = 1
      and computed =
        Nel.compare_lengths
          Nel.(make 0 [ 2; 3; 4; 5 ])
          Nel.(1 :: 2 :: 3 :: [ 4 ])
      in
      check int "should be equal" expected computed)
  ;;

  let compare_length_with0 =
    test_case "compare_length_with" `Quick (fun () ->
      let expected = 0
      and computed = Nel.compare_length_with Nel.(make 0 [ 2; 3; 4 ]) 4 in
      check int "should be equal" expected computed)
  ;;

  let compare_length_with1 =
    test_case "compare_length_with" `Quick (fun () ->
      let expected = 1
      and computed = Nel.compare_length_with Nel.(make 0 [ 2; 3; 4 ]) 3 in
      check int "should be equal" expected computed)
  ;;

  let compare_length_with2 =
    test_case "compare_length_with" `Quick (fun () ->
      let expected = -1
      and computed = Nel.compare_length_with Nel.(make 0 [ 2; 3; 4 ]) 6 in
      check int "should be equal" expected computed)
  ;;

  let compare_length_with3 =
    test_case "compare_length_with" `Quick (fun () ->
      let expected = 0
      and computed = Nel.compare_length_with Nel.(singleton 1) 1 in
      check int "should be equal" expected computed)
  ;;

  let compare_length_with4 =
    test_case "compare_length_with" `Quick (fun () ->
      let expected = 1
      and computed = Nel.compare_length_with Nel.(singleton 1) 0 in
      check int "should be equal" expected computed)
  ;;

  let compare_length_with5 =
    test_case "compare_length_with" `Quick (fun () ->
      let expected = 1
      and computed = Nel.compare_length_with Nel.(singleton 1) (-2) in
      check int "should be equal" expected computed)
  ;;
end

let cases =
  ( "Facts"
  , [ length0
    ; length1
    ; is_singleton0
    ; is_singleton1
    ; hd0
    ; hd1
    ; tl0
    ; tl1
    ; equal0
    ; equal1
    ; compare0
    ; compare1
    ; compare2
    ; compare_lengths0
    ; compare_lengths1
    ; compare_lengths2
    ; compare_length_with0
    ; compare_length_with1
    ; compare_length_with2
    ; compare_length_with3
    ; compare_length_with4
    ; compare_length_with5
    ] )
;;
