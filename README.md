# Planet Cell

This is a life-like cellular automation game.

## Resources

Similar game: https://calamitynolan.itch.io/gameoflifegame

ChatGPT chat used for inspiration: https://chatgpt.com/share/6831c69e-4728-8008-ae29-0393e1f2831d

Visual inspiration: https://store.steampowered.com/app/3431440/Sound_Blocks/

Soundtracks: https://soundimage.org/puzzle-music/

Sound effects: https://sonniss.com/gameaudiogdc/

## Technical setup

I want the game to be playable in the browser. I don't want to use NPM-like tools that are going to be annoying to maintain.
The UI should be simple enough that I can do this with basic HTML and CSS, since it is just a grid.

I have a few choices that seem acceptable, from preferable to least preferable:

* Java + TeaVM
* Kotlin/JS
* Plain JS
* Godot with exporting to the web

I choose Kotlin/JS, because this is an improvement over plain JS. TeaVM doesn't work nicely with generating HTML.

## Random thoughts

First make the sandbox where I can play around with different rules. Construct some kind of notation for storing a game
as a string (like FEN). Then make it possible to play the game based on the notation. This gives me easy access to just
play around without programming too much.

Use hexagonal grid with similar rules. Makes it a completely different game!

## TODO

Step 2: Make the goal part of the grid. Stop playing if the goal is reached or output doesn't match goal.
Step 3: Be able to toggle blocks on the play screen.
Step 4: Implement cells where the cell type has a value. Output has a letter.
Step 5: Add control blocks pass after N or only pass first N.
Step 6: Switch to Godot.
