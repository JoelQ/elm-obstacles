module World where

import Graphics.Element exposing (Element)
import Graphics.Collage exposing (..)
import Color exposing (..)
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


view : World -> Form
view world =
  group
  [ background
  , Entity.viewCharacter world.character
  , Entity.viewObstacles world.obstacles
  , Entity.viewGoal world.goal
  ]

viewFaded : World -> Form
viewFaded world =
  view world |> alpha 0.5

background : Form
background = rect 300 300 |> filled green
