I try to spend half of the time working on the server and the escond half,
on the client.

As time is limited I am going to search a Ruby implementation of minesweeper to
be used along Rails, which will expose an API only.

I would love to implement it myself but I prefer to set up the app.

Start time: repository was crated on 2017-02-04 22:40.

Found an interesting Ruby gem:
https://github.com/svarlet/minesweeper-core
It is useful because it does not includes an end-user interface.

It does not allow to flag a cell with a question mark.

Create a Rails app with --api option.

Now i shall focus on designing the api
actions needed:

* new game
* recover game
* reveal
* flag
* unflag
* flag question
* unflag question

new game: GET /game
recover a game: GET /game/:id
reveal: POST /game/:id/reveal?row=y&column=x
flag: POST /game/:id/flag?row=y&column=x
unflag: POST /game/:id/unflag?row=y&column=x


STOP 23:15
START 13:00

