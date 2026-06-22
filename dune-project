(lang dune 3.0)
(name nel)
(version dev)
(generate_opam_files)

(source (github cargocut/nel))
(license MIT)
(authors
  "xhtmlboi <xhtmlboi@gmail.com>"
  "xvw <xaviervdw@gmail.com>"
  "msp <spawnmick@gmail.com>"
 "grm <grimfw@gmail.com>")
(maintainers
  "xhtmlboi <xhtmlboi@gmail.com>"
  "xvw <xaviervdw@gmail.com>"
  "msp <spawnmick@gmail.com>"
  "grm <grimfw@gmail.com>")

(package
 (name nel)
 (synopsis "A very simple implementation of a non-empty list")
 (description "A very simple implementation of a non-empty list")
 (depends
 (ocaml (>= 4.10.0))
 (alcotest (and :with-test (>= 1.9.1)))
 ;; dev setup
 (utop :with-dev-setup)
 (ocamlformat :with-dev-setup)
 (ocp-indent :with-dev-setup)
 (merlin :with-dev-setup)
 (ocaml-lsp-server :with-dev-setup)))
