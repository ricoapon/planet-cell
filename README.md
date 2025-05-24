# Planet Cell

This is a life-like cellular automation game.

## Resources

Similar game: https://calamitynolan.itch.io/gameoflifegame

ChatGPT chat used for inspiration: https://chatgpt.com/share/6831c69e-4728-8008-ae29-0393e1f2831d

Visual inspiration: https://store.steampowered.com/app/3431440/Sound_Blocks/

## Technical setup

I want the game to be playable in the browser. I don't want to use NPM-like tools that are going to be annoying to maintain.
The UI should be simple enough that I can do this with basic HTML and CSS, since it is just a grid.

I have a few choices that seem acceptable, from preferable to least preferable:

* Java + TeaVM
* Kotlin/JS
* Plain JS
* Godot with exporting to the web

I am the biggest fan of the first option, because that will make me learn about TeaVM. If I want to quickly get started,
then I think Kotlin/JS is the easiest.

## Random thoughts

First make the sandbox where I can play around with different rules. Construct some kind of notation for storing a game
as a string (like FEN). Then make it possible to play the game based on the notation. This gives me easy access to just
play around without programming too much.

Use hexagonal grid with similar rules. Makes it a completely different game!
