(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

open struct
  (* NOTE: [open struct end] allows us to not have an mli and ensure that
     all tests are properly handled. *)

  open Alcotest

  let fold_left0 =
    test_case "fold_left" `Quick (fun () ->
      let expected = "12345"
      and computed =
        Nel.make 1 [ 2; 3; 4; 5 ]
        |> Nel.fold_left (fun b x -> b ^ string_of_int x) ""
      in
      check string "should be equal" expected computed)
  ;;

  let fold_left1 =
    test_case "fold_left" `Quick (fun () ->
      let expected = "1"
      and computed =
        Nel.singleton 1 |> Nel.fold_left (fun b x -> b ^ string_of_int x) ""
      in
      check string "should be equal" expected computed)
  ;;

  let fold_right0 =
    test_case "fold_right" `Quick (fun () ->
      let expected = "54321"
      and computed =
        ""
        |> Nel.fold_right
             (fun x b -> b ^ string_of_int x)
             (Nel.make 1 [ 2; 3; 4; 5 ])
      in
      check string "should be equal" expected computed)
  ;;

  let fold_right1 =
    test_case "fold_right" `Quick (fun () ->
      let expected = "1"
      and computed =
        "" |> Nel.fold_right (fun x b -> b ^ string_of_int x) (Nel.singleton 1)
      in
      check string "should be equal" expected computed)
  ;;

  let reduce0 =
    test_case "reduce" `Quick (fun () ->
      let expected = 120
      and computed = Nel.reduce ( * ) (Nel.from_list_exn [ 1; 2; 3; 4; 5 ]) in
      check int "should be equal" expected computed)
  ;;
end

let cases =
  "Fold", [ fold_left0; fold_left1; fold_right0; fold_right1; reduce0 ]
;;
