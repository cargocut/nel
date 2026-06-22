(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

open struct
  (* NOTE: [open struct end] allows us to not have an mli and ensure that
     all tests are properly handled. *)

  open Alcotest

  let iter0 =
    test_case "iter" `Quick (fun () ->
      let buf = ref [] in
      let () =
        Nel.make 1 [ 2; 3; 4; 5 ] |> Nel.iter (fun x -> buf := x :: !buf)
      in
      let expected = [ 5; 4; 3; 2; 1 ]
      and computed = !buf in
      check (list int) "should be equal" expected computed)
  ;;

  let iter1 =
    test_case "iter" `Quick (fun () ->
      let buf = ref [] in
      let () = Nel.singleton 1 |> Nel.iter (fun x -> buf := x :: !buf) in
      let expected = [ 1 ]
      and computed = !buf in
      check (list int) "should be equal" expected computed)
  ;;

  let iteri0 =
    test_case "iteri" `Quick (fun () ->
      let buf = ref [] in
      let () =
        Nel.make 1 [ 2; 3; 4; 5 ]
        |> Nel.iteri (fun i x -> buf := (i, x) :: !buf)
      in
      let expected = [ 4, 5; 3, 4; 2, 3; 1, 2; 0, 1 ]
      and computed = !buf in
      check (list (pair int int)) "should be equal" expected computed)
  ;;

  let iteri1 =
    test_case "iteri" `Quick (fun () ->
      let buf = ref [] in
      let () =
        Nel.singleton 1 |> Nel.iteri (fun i x -> buf := (i, x) :: !buf)
      in
      let expected = [ 0, 1 ]
      and computed = !buf in
      check (list (pair int int)) "should be equal" expected computed)
  ;;

  let map0 =
    test_case "map" `Quick (fun () ->
      let expected = Nel.singleton 1
      and computed = Nel.singleton 0 |> Nel.map succ in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let map1 =
    test_case "map" `Quick (fun () ->
      let expected = Nel.make 1 [ 2; 3; 4; 5 ]
      and computed = Nel.make 0 [ 1; 2; 3; 4 ] |> Nel.map succ in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let mapi0 =
    test_case "mapi" `Quick (fun () ->
      let expected = Nel.singleton (0, 1)
      and computed = Nel.singleton 0 |> Nel.mapi (fun i x -> i, succ x) in
      check
        (Nel_util.testable @@ pair int int)
        "should be equal"
        expected
        computed)
  ;;

  let mapi1 =
    test_case "mapi" `Quick (fun () ->
      let expected = Nel.make (0, 1) [ 1, 2; 2, 3; 3, 4; 4, 5 ]
      and computed =
        Nel.make 0 [ 1; 2; 3; 4 ] |> Nel.mapi (fun i x -> i, succ x)
      in
      check
        (Nel_util.testable @@ pair int int)
        "should be equal"
        expected
        computed)
  ;;

  let rev_map0 =
    test_case "rev_map" `Quick (fun () ->
      let expected = Nel.singleton 1
      and computed = Nel.singleton 0 |> Nel.rev_map succ in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let rev_map1 =
    test_case "rev_map" `Quick (fun () ->
      let expected = Nel.make 5 [ 4; 3; 2; 1 ]
      and computed = Nel.make 0 [ 1; 2; 3; 4 ] |> Nel.rev_map succ in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let rev_mapi0 =
    test_case "rev_mapi" `Quick (fun () ->
      let expected = Nel.singleton (0, 1)
      and computed = Nel.singleton 0 |> Nel.rev_mapi (fun i x -> i, succ x) in
      check
        (Nel_util.testable @@ pair int int)
        "should be equal"
        expected
        computed)
  ;;

  let rev_mapi1 =
    test_case "rev_mapi" `Quick (fun () ->
      let expected = Nel.make (4, 5) [ 3, 4; 2, 3; 1, 2; 0, 1 ]
      and computed =
        Nel.make 0 [ 1; 2; 3; 4 ] |> Nel.rev_mapi (fun i x -> i, succ x)
      in
      check
        (Nel_util.testable @@ pair int int)
        "should be equal"
        expected
        computed)
  ;;

  let concat_map0 =
    test_case "concat_map" `Quick (fun () ->
      let expected = Nel.make 1 [ 2; 2; 3; 4; 4; 5 ]
      and computed =
        Nel.make 1 [ 2; 3; 4; 5 ]
        |> Nel.concat_map (fun x ->
          if x mod 2 = 0 then Nel.make x [ x ] else Nel.singleton x)
      in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let concat_map1 =
    test_case "concat_map" `Quick (fun () ->
      let expected = Nel.make 1 [ 2; 3; 4; 5 ]
      and computed =
        Nel.singleton 1
        |> Nel.concat_map (fun x -> Nel.make x [ x + 1; x + 2; x + 3; x + 4 ])
      in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;

  let concat_map2 =
    test_case "concat_map" `Quick (fun () ->
      let expected =
        Nel.make 1 [ 2; 3; 4; 5; 2; 3; 4; 5; 6; 3; 4; 5; 6; 7; 4; 5; 6; 7; 8 ]
      and computed =
        Nel.make 1 [ 2; 3; 4 ]
        |> Nel.concat_map (fun x -> Nel.make x [ x + 1; x + 2; x + 3; x + 4 ])
      in
      check (Nel_util.testable int) "should be equal" expected computed)
  ;;
end

let cases =
  ( "Iteration"
  , [ iter0
    ; iter1
    ; iteri0
    ; iteri1
    ; map0
    ; map1
    ; mapi0
    ; mapi1
    ; rev_map0
    ; rev_map1
    ; rev_mapi0
    ; rev_mapi1
    ; concat_map0
    ; concat_map1
    ; concat_map2
    ] )
;;
