module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed


main : Program () Int Int
main =
    Browser.sandbox
        { init = 0
        , view = view
        , update = (+)
        }


view : Int -> Html Int
view rowCount =
    Html.Keyed.node "table"
        []
        (List.concat
            [ [ ( "first", tr [] [ td [] [ button [ onClick 1 ] [ text "Add 1 row" ], button [ onClick 2 ] [ text "Add 2 rows" ] ] ] ) ]
            , List.range 0 rowCount |> List.map (\key -> ( String.fromInt key, tr [] [ td [] [] ] ))
            , [ ( "last", tr [] [ td [] [ button [ onClick 1 ] [ text "Add 1 row" ], button [ onClick 2 ] [ text "Add 2 rows" ] ] ] ) ]
            ]
        )
