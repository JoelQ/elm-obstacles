import Graphics.Element exposing (Element)
import Graphics.Collage exposing (..)
import Color exposing (..)
import Keyboard
import Text

main : Signal Element
main =
  Signal.foldp update initWorld Keyboard.arrows |> Signal.map view

type alias Entity = (Float, Float)

type alias World = { character : Entity, goal: Entity, obstacles: List Entity }

initWorld : World
initWorld = { character = (-100, 100), goal = (100, -100), obstacles = [(-100, 0), (0, -100)] }

background : Form
background =
  rect 300 300 |> filled green
  
view : World -> Element
view world =
  if | haveCollided world.character world.goal -> collage 300 300 [ viewWorld world |> alpha 0.5, victoryText ]
     | List.any (haveCollided world.character) world.obstacles -> collage 300 300 [ viewWorld world |> alpha 0.5, failureText ]
     | otherwise -> collage 300 300 [ viewWorld world ]
  
victoryText : Form
victoryText =
  "You win!!!" |> Text.fromString |> text
  
failureText : Form
failureText =
  "Game Over!" |> Text.fromString |> text

viewWorld : World -> Form
viewWorld world =
  group [ background, viewCharacter world.character, viewObstacles world.obstacles, viewGoal world.goal ]

viewObstacles : List Entity -> Form
viewObstacles obstacles =
  List.map viewObstacle obstacles |> group
  
viewObstacle : Entity -> Form
viewObstacle coordinates =
  rect 25 25 |> filled black |> move coordinates
  
viewCharacter : Entity -> Form
viewCharacter coordinates =
  rect 25 25 |> filled red |> move coordinates
  
haveCollided : Entity -> Entity -> Bool
haveCollided (entity1X, entity1Y) (entity2X, entity2Y) =
 (entity1X > entity2X - 25)
 && (entity1X < entity2X + 25)
 && (entity1Y > entity2Y - 25)
 && (entity1Y < entity2Y + 25)
  
viewGoal : Entity -> Form
viewGoal coordinates =
  rect 25 25 |> filled brown |> move coordinates
update : { x : Int, y : Int } -> World -> World
update arrows world =
  { world | character <- updateCharacter arrows world.character }

updateCharacter : { x : Int, y : Int } -> Entity -> Entity
updateCharacter arrows (x, y) = (x + 15 * (toFloat arrows.x), y + 15 * (toFloat arrows.y))
  
