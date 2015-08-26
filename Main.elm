import Graphics.Element exposing (Element)
import Keyboard
import Game

main : Signal Element
main =
  Signal.foldp Game.update Game.init Keyboard.arrows
  |> Signal.map Game.view

