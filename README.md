# prolog-ufo-puzzle

> A logic puzzle solver in Prolog — four "UFO" sightings, four people, four weekdays, four objects. Solve it with declarative constraints and let the unifier do the work.

[![Prolog](https://img.shields.io/badge/Prolog-SWI-red.svg)]() [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## The puzzle

Four people — **Ms. Gort**, **Mr. Klaatu**, **Ms. Barada**, and **Mr. Nikto** — each reported a different "UFO" sighting (a balloon, a clothesline, a frisbee, and a water tower) on a different day of the week (Tuesday through Friday). Given these clues:

1. Mr. Klaatu's sighting was **later in the week than the frisbee-spotter** (who isn't Ms. Gort), but **earlier than the balloon-spotter**.
2. Friday's sighting was by **Ms. Barada**, or the **clothesline-spotter**, or both.
3. Mr. Nikto **did not** sight on Tuesday.
4. Mr. Klaatu **did not** see the water tower.

Find: who saw what, on which day.

---

## Why Prolog

This is the kind of problem Prolog was *invented* for. You describe the constraints, and the resolution engine searches the solution space by backtracking. No loops, no flags, no state — just facts and rules.

The solver:
1. Sets up a list of `(Person, Object, Day)` triples, partially uninstantiated.
2. Asserts that each object and each day appears exactly once.
3. Encodes each clue as a logical constraint.
4. Calls `forall(member(T, Events), report(T))` to print the resulting solution.

```prolog
earlier(A, B) :-
  append(Earlier, Later, ['Tuesday', 'Wednesday', 'Thursday', 'Friday']),
  member(A, Earlier), member(B, Later), !.
```

`earlier/2` is implemented via `append/3` — a classic Prolog idiom for "X comes before Y in this list."

---

## Run it

```bash
swipl -q -t solve -s ufo_puzzle.pl
```

Or interactively:

```bash
swipl ufo_puzzle.pl
?- solve.
```

Expected output is a 4-line English description of the unique solution.

---

## Coursework context

A small study in declarative programming — solving a constraint puzzle by describing rules instead of writing imperative search code.

---

## License

[MIT](LICENSE)

---

*Built by [@forgehk](https://github.com/forgehk) — [DarkForge AI](https://darkforgeai.com)*
