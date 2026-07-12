
s" os-class" environment? [IF]
  type cr
[ELSE]
  .( OS unknown ) CR
[THEN]

S" gforth" ENVIRONMENT? [IF]
  .( Gforth version: ) TYPE CR
[ELSE]
  .( Not Gforth/Version unknown) CR
[THEN]

