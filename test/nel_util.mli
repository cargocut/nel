(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

(** Some utils for testing purpose. *)

(** A {!type:Alcotest.testable} for {!type:Nel.t}. *)
val testable : 'a Alcotest.testable -> 'a Nel.t Alcotest.testable
