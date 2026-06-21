(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

open struct
  (* NOTE: [open struct end] allows us to not have an mli and ensure that
     all tests are properly handled. *)

  open Alcotest

  let make0 =
    test_case "make" `Quick (fun () ->
      let expected = Nel.(1 :: 2 :: [ 3 ])
      and computed = Nel.make 1 [ 2; 3 ] in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let singleton0 =
    test_case "singleton" `Quick (fun () ->
      let expected = Nel.(1 :: [])
      and computed = Nel.singleton 1 in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

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

  let from_list0 =
    test_case "from_list" `Quick (fun () ->
      let expected = None
      and computed = Nel.from_list [] in
      check
        (option @@ Nel_util.testable int)
        "When the list is empty, [from_list] shoudl fail (return [None])"
        expected
        computed)
  ;;

  let from_list1 =
    test_case "from_list" `Quick (fun () ->
      let expected = Some Nel.(1 :: 2 :: [ 3 ])
      and computed = Nel.from_list [ 1; 2; 3 ] in
      check
        (option @@ Nel_util.testable int)
        "When the list is empty, [from_list] shoudl fail (return [None])"
        expected
        computed)
  ;;
end

let cases =
  "Building", [ make0; singleton0; cons0; cons1; from_list0; from_list1 ]
;;
