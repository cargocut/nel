(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

open struct
  (* NOTE: [open struct end] allows us to not have an mli and ensure that
     all tests are properly handled. *)

  open Alcotest

  let find0 =
    test_case "find" `Quick (fun () ->
      let expected = Some 5
      and computed =
        [ 1; 2; 3; 5; 7 ] |> Nel.from_list_exn |> Nel.find (Int.equal 5)
      in
      check (option int) "should be equal" expected computed)
  ;;

  let find1 =
    test_case "find" `Quick (fun () ->
      let expected = None
      and computed =
        [ 1; 2; 3; 6; 7 ] |> Nel.from_list_exn |> Nel.find (Int.equal 5)
      in
      check (option int) "should be equal" expected computed)
  ;;

  let findi0 =
    test_case "findi" `Quick (fun () ->
      let expected = Some 5
      and computed =
        [ 1; 2; 3; 5; 7 ]
        |> Nel.from_list_exn
        |> Nel.findi (fun i x -> Int.equal i 3 && Int.equal x 5)
      in
      check (option int) "should be equal" expected computed)
  ;;

  let findi1 =
    test_case "findi" `Quick (fun () ->
      let expected = None
      and computed =
        [ 1; 2; 3; 4; 5; 7 ]
        |> Nel.from_list_exn
        |> Nel.findi (fun i x -> Int.equal i 3 && Int.equal x 5)
      in
      check (option int) "should be equal" expected computed)
  ;;

  let find_index0 =
    test_case "find_index" `Quick (fun () ->
      let expected = Some 3
      and computed =
        [ 1; 2; 3; 5; 7 ] |> Nel.from_list_exn |> Nel.find_index (Int.equal 5)
      in
      check (option int) "should be equal" expected computed)
  ;;

  let find_index1 =
    test_case "find_index" `Quick (fun () ->
      let expected = None
      and computed =
        [ 1; 2; 3; 5; 7 ] |> Nel.from_list_exn |> Nel.find_index (Int.equal 22)
      in
      check (option int) "should be equal" expected computed)
  ;;

  (* NOTE: [findi] and [find_index] are relaying on [find_mapi]. *)
end

let cases =
  "Searching", [ find0; find1; findi0; findi1; find_index0; find_index1 ]
;;
