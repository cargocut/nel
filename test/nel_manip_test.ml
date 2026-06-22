(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

open struct
  (* NOTE: [open struct end] allows us to not have an mli and ensure that
     all tests are properly handled. *)

  open Alcotest

  let cons0 =
    test_case "cons" `Quick (fun () ->
      let expected = Nel.(1 :: [ 2 ])
      and computed = Nel.(cons 1 @@ singleton 2) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let cons1 =
    test_case "cons" `Quick (fun () ->
      let expected = Nel.(0 :: 1 :: [ 2 ])
      and computed = Nel.(cons 0 @@ cons 1 @@ singleton 2) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let rev0 =
    test_case "rev" `Quick (fun () ->
      let expected = Nel.singleton 1
      and computed = Nel.rev Nel.(1 :: []) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let rev1 =
    test_case "rev" `Quick (fun () ->
      let expected = Nel.make 5 [ 4; 3; 2; 1 ]
      and computed = Nel.rev Nel.(1 :: [ 2; 3; 4; 5 ]) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let append0 =
    test_case "append" `Quick (fun () ->
      let expected = Nel.make 1 [ 2 ]
      and computed = Nel.append Nel.(singleton 1) Nel.(singleton 2) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let append1 =
    test_case "append" `Quick (fun () ->
      let expected = Nel.make 1 [ 2; 3; 4; 5 ]
      and computed = Nel.append Nel.(singleton 1) Nel.(make 2 [ 3; 4; 5 ]) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let append2 =
    test_case "append" `Quick (fun () ->
      let expected = Nel.make 1 [ 2; 3; 4; 5 ]
      and computed = Nel.append Nel.(make 1 [ 2 ]) Nel.(make 3 [ 4; 5 ]) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let rev_append0 =
    test_case "rev_append" `Quick (fun () ->
      let expected = Nel.make 1 [ 2 ]
      and computed = Nel.rev_append Nel.(singleton 1) Nel.(singleton 2) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let rev_append1 =
    test_case "rev_append" `Quick (fun () ->
      let expected = Nel.make 1 [ 2; 3; 4; 5 ]
      and computed =
        Nel.rev_append Nel.(singleton 1) Nel.(make 2 [ 3; 4; 5 ])
      in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let rev_append2 =
    test_case "rev_append" `Quick (fun () ->
      let expected = Nel.make 2 [ 1; 3; 4; 5 ]
      and computed = Nel.rev_append Nel.(make 1 [ 2 ]) Nel.(make 3 [ 4; 5 ]) in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;
end

let cases =
  ( "Manipulation"
  , [ cons0
    ; cons1
    ; rev0
    ; rev1
    ; append0
    ; append1
    ; append2
    ; rev_append0
    ; rev_append1
    ; rev_append2
    ] )
;;
