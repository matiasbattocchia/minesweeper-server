# Minesweeper server

A minesweeper game Rails 5 API. It uses [minesweeper-core](https://github.com/svarlet/minesweeper-core) gem internally.

## API

Currently hosted at http://minesweeper-server.herokuapp.com/.

### Start a new game

```http
POST /api/v1/games
```

#### Data params

* **rows** — Integer, default: 5.
Up to 10 rows are permitted.
* **mines** — Integer, default: equals the number of rows.
Cannot be greater than number of cells (rows^2).

### Recover a game

```http
GET /api/v1/games/:id
```

#### URL params

* **id** (required) — Integer.

### Reveal a cell

```http
PUT /api/v1/games/:id/reveal
```

#### URL params

Same as **recover a game**.

#### Data params

* **row** (required) — Integer.
Cannot exceed the number of rows. Starts counting from 0.
* **column** (required) — Integer.
Cannot exceed the number of columns (rows). Starts counting from 0.

### Flag a cell (example)

```http
PUT /api/v1/games/:id/flag?row=y&column=x
```

### Unflag a cell (example)

```http
PUT /api/v1/games/:id/unflag?row=y&column=x
```

### Example successful response

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
  "type": "games",
  "id": 1,
  "attributes": {
    "rows": 5,
    "mines": [[0, 1], [2, 3], [4, 5]],
    "board": "HHFHHHH0010HHHH02HHH01HHH",
    "status": "In play"
  }
}
```

**Mines**: array of mine coordinates pairs (row, column).

**Board**: each character represents a cell; it is the 2D board rearranged in a single line.
* H: hidden
* *Integer*: mines around count
* F: flagged

**Status**: current game status.
* In play
* Game over: You won!
* Game over: You blew it!

### Example error response

```http
HTTP/1.1 400 Bad request
Content-Type: application/json
```

```json
{
  "error": "Parameter 'rows' is not an integer."
}
```

## Challenge

We ask that you complete the following challenge to evaluate your development
skills. Please use Ruby and Rails framework to accomplish the following task:
Develop the classic game of Minesweeper:
https://en.wikipedia.org/wiki/Minesweeper_(video_game) —
Please see the description section for how the game is set up.

**The following is a list of items (prioritized from most important to least
important) we wish to see:**

* [x] Design and implement an API for the game
(think of a mobile app for your API).
* [ ] Implement an API client library for the API designed above. Ideally,
in a different language, of your preference, to the one used for the API.
* [x] When a cell with no adjacent mines is revealed, all adjacent squares
will be revealed (and repeat).
* [x] Ability to 'flag' a cell with a question mark or red flag.
* [x] Alert when game is over.
* [x] Persistence. Do not to lose the game if the browser is closed.
* [ ] Time tracking.
* [x] Ability to start a new game and preserve/resume the old ones.
* [x] Ability to select the game parameters: number of rows, columns,
and mines.
* [ ] Ability to support multiple users/accounts.
* [ ] Nice user experience (e.g. avoid page reload while playing).

**Deliverables we expect:**

* URL where the game can be accessed and played (use any platform of your
preference: Heroku, Amazon AWS, etc.)
* Code in a public GitHub repo.
* README file with the decisions taken and important notes.
* Time you spent on the challenge.
* You do not need to fully complete the challenge. We suggest not to spend
more than 5 hours total, which can be done over the course of 2 days.
Please make commits as often as possible and do not make one commit
at the end.  We will evaluate the code and time spent.

What we want to see is how well you handle yourself given the time you spend
on the problem, how you think, and how you prioritize when time is
insufficient to solve everything.

## Notes

I try to spend half of the time working on the server and the escond half,
on the client.

As time is limited I am going to search a Ruby implementation of minesweeper to
be used along Rails, which will expose an API only.

I would love to implement it myself but I prefer to set up the app.

Start time: repository was crated on 2017-02-04 22:40.

Found an interesting Ruby gem:

It is useful because it does not includes an end-user interface.

It does not allow to flag a cell with a question mark.

Create a Rails app with --api option.

Now i shall focus on designing the api

STOP 23:15 (35 min)
START 13:00
I had a problem with readline
Running into serious problems with serialization.
STOP 17:30 (4:30 + :35 =  5:05)
START 18:15
I wanted to use UUIDs but requires workarounds...
Minesweeper uses weird exceptions to state the game.
STOP 20:30 (2:15 + 5:05 = 7:20)

START 19:00
Some API guidelines lectures.
STOP 20:30
