(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

open struct
  (* NOTE: [open struct end] allows us to not have an mli and ensure that
     all tests are properly handled. *)

  open Alcotest

  let for_all0 =
    test_case "for_all" `Quick (fun () ->
      let expected = true
      and computed =
        Nel.from_list_exn [ 2 ] |> Nel.for_all (fun x -> x mod 2 = 0)
      in
      check bool "should be equal" expected computed)
  ;;

  let for_all1 =
    test_case "for_all" `Quick (fun () ->
      let expected = true
      and computed =
        Nel.from_list_exn [ 2; 4; 6; 8 ] |> Nel.for_all (fun x -> x mod 2 = 0)
      in
      check bool "should be equal" expected computed)
  ;;

  let for_all2 =
    test_case "for_all" `Quick (fun () ->
      let expected = false
      and computed =
        Nel.from_list_exn [ 2; 4; 6; 5; 8 ]
        |> Nel.for_all (fun x -> x mod 2 = 0)
      in
      check bool "should be equal" expected computed)
  ;;

  let for_some0 =
    test_case "for_some" `Quick (fun () ->
      let expected = true
      and computed =
        Nel.from_list_exn [ 2 ] |> Nel.for_some (fun x -> x mod 2 = 0)
      in
      check bool "should be equal" expected computed)
  ;;

  let for_some1 =
    test_case "for_some" `Quick (fun () ->
      let expected = true
      and computed =
        Nel.from_list_exn [ 2; 3; 4; 8 ] |> Nel.for_some (fun x -> x mod 2 = 0)
      in
      check bool "should be equal" expected computed)
  ;;

  let for_some2 =
    test_case "for_some" `Quick (fun () ->
      let expected = false
      and computed =
        Nel.from_list_exn [ 2; 4; 6; 8 ] |> Nel.for_some (fun x -> x mod 2 <> 0)
      in
      check bool "should be equal" expected computed)
  ;;

  let mem0 =
    test_case "mem" `Quick (fun () ->
      let expected = true
      and computed = Nel.from_list_exn [ 1; 2; 3; 4 ] |> Nel.mem 3 in
      check bool "should be equal" expected computed)
  ;;

  let mem1 =
    test_case "mem" `Quick (fun () ->
      let expected = false
      and computed = Nel.from_list_exn [ 1; 2; 3; 4 ] |> Nel.mem 5 in
      check bool "should be equal" expected computed)
  ;;
end

let cases =
  ( "Scanning"
  , [ for_all0
    ; for_all1
    ; for_all2
    ; for_some0
    ; for_some1
    ; for_some2
    ; mem0
    ; mem1
    ] )
;;
