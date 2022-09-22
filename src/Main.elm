module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (href)
import Html.Events exposing (..)
import Html.Keyed exposing (..)
import List.Extra exposing (..)
import Random exposing (..)


type InsertLocation
    = Middle
    | Random


main : Program () (List Int) ( Int, InsertLocation )
main =
    Browser.sandbox
        { init = []
        , view = view
        , update = update
        }


splitIndex : InsertLocation -> Int -> Int
splitIndex loc limit =
    case loc of
        Middle ->
            limit // 2

        Random ->
            step (Random.int 0 limit) (initialSeed limit) |> Tuple.first


update : ( Int, InsertLocation ) -> List Int -> List Int
update ( inc, loc ) keys =
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
                        splitAt (splitIndex loc k) acc
                in
                l ++ [ k ] ++ r
            )
            keys


view : List Int -> Html ( Int, InsertLocation )
view keys =
    div []
        [ h1 []
            [ text "Demonstration of "
            , a [ href "https://github.com/elm/virtual-dom/issues/178" ] [ text "elm/virtual-dom#178" ]
            , text " ("
            , a [ href "https://github.com/bisgardo/elm-virtual-dom-issue-178" ] [ text "source" ]
            , text ")"
            ]
        , p [] [ text "Elements flash in green when they're attached to the DOM." ]
        , p [] [ text "When more than one consecutive row is added at a time, then all rows following them are redundantly detached and reattached." ]
        , p [] [ text "If a button on the last row had focus, it will lose it. This can be seen by clicking the button. Pressing ENTER will then \"click\" it again as long as it retains focus." ]
        , Html.Keyed.node "table"
            []
            (List.concat
                [ [ ( "first", tr [] [ td [] <| [ text "key=first " ] ++ buttons ] ) ]
                , keys
                    |> List.map String.fromInt
                    |> List.map (\key -> ( key, tr [] [ td [] [ text <| "key=" ++ key ++ " " ] ] ))
                , [ ( "last", tr [] [ td [] <| [ text "key=last " ] ++ buttons ] ) ]
                ]
            )
        ]


buttons =
    [ button [ onClick ( 1, Middle ) ] [ text "Add 1 row (middle)" ]
    , button [ onClick ( 2, Middle ) ] [ text "Add 2 rows (middle)" ]
    , button [ onClick ( 1, Random ) ] [ text "Add 1 row (randomly)" ]
    , button [ onClick ( 2, Random ) ] [ text "Add 2 rows (randomly)" ]
    ]
