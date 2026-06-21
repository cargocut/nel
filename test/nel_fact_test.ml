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
end

let cases =
  ( "Facts"
  , [ length0; length1; is_singleton0; is_singleton1; hd0; hd1; tl0; tl1 ] )
;;
