module Entity where

import Graphics.Collage exposing (..)
import Color exposing (..)

type alias Entity = (Float, Float)

update : { x : Int, y : Int } -> Entity -> Entity
update arrows (x, y) =
  (x + 15 * (toFloat arrows.x), y + 15 * (toFloat arrows.y))

haveCollided : Entity -> Entity -> Bool
haveCollided (entity1X, entity1Y) (entity2X, entity2Y) =
  (entity1X > entity2X - 25)
  && (entity1X < entity2X + 25)
  && (entity1Y > entity2Y - 25)
  && (entity1Y < entity2Y + 25)

viewObstacles : List Entity -> Form
viewObstacles obstacles =
  List.map viewObstacle obstacles |> group

viewObstacle : Entity -> Form
viewObstacle coordinates =
  rect 25 25 |> filled black |> move coordinates

viewCharacter : Entity -> Form
viewCharacter coordinates =
  rect 25 25 |> filled red |> move coordinates

viewGoal : Entity -> Form
viewGoal coordinates =
  rect 25 25 |> filled brown |> move coordinates
