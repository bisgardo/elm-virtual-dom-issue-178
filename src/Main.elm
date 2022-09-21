module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed


main : Program () Bool ()
main =
    Browser.sandbox
        { init = False
        , view = view
        , update = always not
        }


view : Bool -> Html ()
view model =
    div []
        [ Html.Keyed.node "div"
            []
            ([ input_ "A"
             , input_ "B"
             ]
                |> (\x ->
                        if model then
                            List.reverse x

                        else
                            x
                   )
            )
        , text "Type to swaps inputs."
        ]


input_ a =
    ( a
    , input
        [ id a
        , value a
        , onInput (\_ -> ())
        ]
        []
    )
