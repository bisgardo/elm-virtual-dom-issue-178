module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Keyed exposing (..)
import List.Extra exposing (..)
import Random exposing (Seed, initialSeed, step)


main : Program () (List Int) Int
main =
    Browser.sandbox
        { init = []
        , view = view
        , update = update
        }


rand : Int -> Int
rand limit =
    step (Random.int 0 limit) (initialSeed limit) |> Tuple.first


update : Int -> List Int -> List Int
update inc keys =
    let
        len =
            List.length keys

        ( l, r ) =
            splitAt (rand len) keys
    in
    l ++ (List.range 1 inc |> List.map ((+) len)) ++ r


view : List Int -> Html Int
view keys =
    div []
        [ h1 [] [ text "Elements flash in green when they're attached to the DOM" ]
        , text "When more than one row is added at a time, the final row is redundantly detached and reattached, causing it to lose focus."
        , Html.Keyed.node "table"
            []
            (List.concat
                [ [ ( "first", tr [] [ td [] <| [ text "key=first" ] ++ buttons ] ) ]
                , keys
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
