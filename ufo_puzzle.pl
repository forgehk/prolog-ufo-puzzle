% Logic puzzle: who saw what on which day
%
% Declarative logic puzzle
% Logic Puzzle in Prolog
%
% Tools used:
%   - SWI-Prolog
%   - Visual Studio Code
% Websites used:
%   - https://www.swi-prolog.org
%   - https://swish.swi-prolog.org
%   - https://book.simply-logical.space
%
% Each person reported a "UFO" sighting on a different day of the week.
%

% Chronological order of weekdays
earlier(A, B) :-
  append(Earlier, Later, ['Tuesday', 'Wednesday', 'Thursday', 'Friday']),
  member(A, Earlier), member(B, Later), !.

% Solve the puzzle.
solve :-
  % Each event is represented by a triple of the form
  % (Person, Object, Day) in a list of events:
  Events = [
    ('Ms. Gort',   _, _         ),
    ('Mr. Klaatu', _, KlaatuDay ),
    ('Ms. Barada', _, _         ),
    ('Mr. Nikto',  _, _         )
  ],

  member((_, balloon,     BalloonDay ), Events),
  member((_, clothesline, _          ), Events),
  member((_, frisbee,     FrisbeeDay ), Events),
  member((_, watertower,  _          ), Events),

  member((_, _, 'Tuesday'),   Events),
  member((_, _, 'Wednesday'), Events),
  member((_, _, 'Thursday'),  Events),
  member((_, _, 'Friday'),    Events),

  % 1. Mr. Klaatu made his sighting at some point earlier in the week
  %    than the one who saw the balloon, but at some point later in the week
  %    than the one who spotted the Frisbee (who isn't Ms. Gort).

  member((FrisbeeWho, frisbee, FrisbeeDay), Events),
  FrisbeeWho \= 'Ms. Gort',
  earlier(FrisbeeDay, KlaatuDay),
  earlier(KlaatuDay, BalloonDay),

  % 2. Friday's sighting was made by either Ms. Barada
  %    or the one who saw the clothesline or both.

  ( member(('Ms. Barada', _, 'Friday'), Events)
  ; member((_, clothesline, 'Friday'), Events)
  ),

  % 3. Mr. Nikto did not make his sighting on Tuesday.

  member(('Mr. Nikto', _, NiktoDay), Events),
  NiktoDay \= 'Tuesday',

  % 4. Mr. Klaatu isn't the one whose object turned out to be a water tower.

  \+ member(('Mr. Klaatu', watertower, _), Events),

  % Display a solution: An English sentence for each event.
  forall(member(T, Events), report(T)).

% Write out an English sentence for an event.
report((Who, What, When)) :-
  write(Who), write(' saw the '), write(What),
  write(' on '), write(When), write('.'), nl.

