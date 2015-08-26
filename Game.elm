module Game where

import Graphics.Element exposing (Element)
import Graphics.Collage exposing (..)
import Text

import World exposing (World)
import Entity

init = World.init
update = World.update

view : World -> Element
view world =
  if | gameWon world -> viewport [ World.viewFaded world, victoryText ]
     | gameLost world -> viewport [ World.viewFaded world, failureText ]
     | otherwise -> viewport [ World.view world ]

viewport : List Form -> Element
viewport forms =
  collage 300 300 forms

gameLost : World -> Bool
gameLost world =
  List.any (Entity.haveCollided world.character) world.obstacles

gameWon : World -> Bool
gameWon world =
  Entity.haveCollided world.character world.goal

victoryText : Form
victoryText =
  "You win!!!" |> Text.fromString |> text

failureText : Form
failureText =
  "Game Over!" |> Text.fromString |> text
