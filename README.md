# hubot-checkout

A bot to keep track (checkin and checkout) resources.

See [`src/checkout.coffee`](src/checkout.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-checkout --save`

Then add **hubot-checkout** to your `external-scripts.json`:

```json
[
  "hubot-checkout"
]
```

## Todo

- Auto-return resource after due date (e.g. hubot checkout qa-server for 1 day)
- clean up code duplication and utilize coffescript string interpolation

## Sample Interaction

```
user1>> hubot checkout qa-server 
hubot>> user1 checked out qa-server
```
