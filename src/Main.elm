module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed


main : Program () Int ()
main =
    Browser.sandbox
        { init = 0
        , view = view
        , update = always ((+) 2)
        }


update : () -> Int -> Int
update msg model =
    case msg of
        () ->
            model + 1


view : Int -> Html ()
view rowCount =
    Html.Keyed.node "table"
        []
        (List.concat
            [ [ ( "first", tr [] [ td [] [ button [ onClick () ] [ text "Add row" ] ] ] ) ]
            , List.range 0 rowCount |> List.map (\key -> ( String.fromInt key, tr [] [ td [] [] ] ))
            , [ ( "last", tr [] [ td [] [ button [ onClick () ] [ text "Add row" ] ] ] ) ]
            ]
        )
