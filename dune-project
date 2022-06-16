(lang dune 2.0)
(using menhir 2.0)

(name shenzhen)

(generate_opam_files true)

(source
 (github ghuysmans/shenzhen))

(authors "Guillaume Huysmans")

(maintainers "Guillaume Huysmans")

(license GPL-2.0-or-later)

(package
 (name shenzhen)
 (synopsis "A parser for SHENZHEN I/O assembly programs")
 (depends ocaml dune))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
