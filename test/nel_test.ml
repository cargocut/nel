(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

let () =
  Alcotest.run
    "Non Empty List"
    [ Nel_building_test.cases
    ; Nel_fact_test.cases
    ; Nel_manip_test.cases
    ; Nel_iter_test.cases
    ; Nel_fold_test.cases
    ; Nel_scanning_test.cases
    ; Nel_searching_test.cases
    ]
;;
