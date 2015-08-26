module Game where

import Graphics.Element exposing (Element)
import Graphics.Collage exposing (..)
import Color exposing (..)
import Text

import Entity exposing (Entity)

type alias World = { character : Entity, goal: Entity, obstacles: List Entity }

init: World
init =
  { character = (-100, 100)
  , goal = (100, -100)
  , obstacles = [(-100, 0), (0, -100)]
  }

update : { x : Int, y : Int } -> World -> World
update arrows world =
  { world | character <- Entity.update arrows world.character }

view : World -> Element
view world =
  if | gameWon world -> collage 300 300 [ viewWorld world |> alpha 0.5, victoryText ]
     | gameLost world -> collage 300 300 [ viewWorld world |> alpha 0.5, failureText ]
     | otherwise -> collage 300 300 [ viewWorld world ]

gameLost : World -> Bool
gameLost world =
  List.any (Entity.haveCollided world.character) world.obstacles

gameWon : World -> Bool
gameWon world =
  Entity.haveCollided world.character world.goal

viewWorld : World -> Form
viewWorld world =
  group
  [ background
  , Entity.viewCharacter world.character
  , Entity.viewObstacles world.obstacles
  , Entity.viewGoal world.goal
  ]

background : Form
background = rect 300 300 |> filled green

victoryText : Form
victoryText =
  "You win!!!" |> Text.fromString |> text

failureText : Form
failureText =
  "Game Over!" |> Text.fromString |> text
