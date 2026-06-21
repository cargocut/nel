> [!WARNING]  
> This project is still **highly experimental**, but we would be
> delighted to receive feedback (but please be careful with
> production).

# nel

> A very simple implementation of a non-empty list.

Until non-empty lists are included in the standard library, this
rather naive implementation should do the trick. Currently the goal of
the API **is not to be complete** but to follow our current usages.

**Why not using**
[ocaml-non-empty-list](https://github.com/johnyob/ocaml-non-empty-list)?
Although the implementation is more than reasonable, it relies on
Base, which we feel is too much to expect for small projects.
