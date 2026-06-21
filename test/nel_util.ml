(* Copyright (c) 2026, Cargocut and the Nel developers.
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause *)

let testable t = Alcotest.(map Nel.to_list @@ list t)
