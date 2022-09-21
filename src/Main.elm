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


randomize =
    True


splitIndex : Int -> Int
splitIndex limit =
    if randomize then
        -- Insert at "random" location.
        step (Random.int 0 limit) (initialSeed limit) |> Tuple.first

    else
    -- Always insert at the end.
        limit


update : Int -> List Int -> List Int
update inc keys =
    let
        len =
            List.length keys
    in
    List.range 1 inc
        |> List.map ((+) len)
        |> List.foldl
            (\k acc ->
                let
                    ( l, r ) =
                        splitAt (splitIndex k) acc
                in
                l ++ [ k ] ++ r
            )
            keys


view : List Int -> Html Int
view keys =
    div []
        [ h1 [] [ text "Elements flash in green when they're attached to the DOM" ]
        , p [] [ text "When more than one consecutive row is added at a time, all rows following them are redundantly detached and reattached." ]
        , p [] [ text "If a button on the last row had focus, it will lose it." ]
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
