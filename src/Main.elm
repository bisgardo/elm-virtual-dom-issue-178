module Main exposing (..)

import Browser
import Html exposing (..)
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
    div []
        [ h1 [] [ text "Elements flash in green when they're attached to the DOM" ]
        , text "When more than one row is added at a time, the final row is redundantly detached and reattached, causing it to lose focus."
        , Html.Keyed.node "table"
            []
            (List.concat
                [ [ ( "first", tr [] [ td [] <| [ text "key=first" ] ++ buttons ] ) ]
                , List.range 0 rowCount
                    |> List.map String.fromInt
                    |> List.map (\key -> ( key, tr [] [ td [] [ text <| "key=" ++ key ] ] ))
                , [ ( "last", tr [] [ td [] <| [ text "key=last" ] ++ buttons ] ) ]
                ]
            )
        ]


buttons =
    [ button [ onClick 1 ] [ text "Add 1 row" ]
    , button [ onClick 2 ] [ text "Add 2 rows" ]
    ]
