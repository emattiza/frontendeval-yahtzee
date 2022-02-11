module Dice exposing (..)

import Html exposing (Html, div, span, text)
import Html.Attributes as HAttrs exposing (class)
import Svg exposing (Svg, circle, g, rect, svg)
import Svg.Attributes as SAttrs exposing (height, viewBox, width, x, y)


type Dice
    = One
    | Two
    | Three
    | Four
    | Five
    | Six


viewDiceContainer : List Dice -> Html msg
viewDiceContainer diceList =
    let
        total : String
        total =
            diceList |> List.map toInt |> List.sum |> String.fromInt
    in
    div
        [ class "display-dice-container" ]
        (List.append
            [ span [ HAttrs.class "dice-total-display" ] [ text total ] ]
            (List.map viewDice diceList)
        )


viewDice : Dice -> Svg msg
viewDice dice =
    svg
        [ viewBox "0 0 100 100"
        , SAttrs.class "dice-svg"
        ]
        [ g
            []
            [ rect
                [ x "0"
                , y "0"
                , width "100"
                , height "100"
                , SAttrs.fill "white"
                , SAttrs.rx "10"
                ]
                []
            , viewDots dice
            ]
        ]


viewDots : Dice -> Svg msg
viewDots dice =
    let
        dot : String -> String -> Svg msg
        dot x y =
            circle [ SAttrs.cx x, SAttrs.cy y, SAttrs.fill "black", SAttrs.r "10" ] []

        centerDot : Svg msg
        centerDot =
            dot "50" "50"

        topRightDot : Svg msg
        topRightDot =
            dot "80" "20"

        bottomLeftDot : Svg msg
        bottomLeftDot =
            dot "20" "80"

        bottomRightDot : Svg msg
        bottomRightDot =
            dot "80" "80"

        topLeftDot : Svg msg
        topLeftDot =
            dot "20" "20"

        centerLeftDot : Svg msg
        centerLeftDot =
            dot "20" "50"

        centerRightDot : Svg msg
        centerRightDot =
            dot "80" "50"
    in
    case dice of
        One ->
            g
                []
                [ centerDot ]

        Two ->
            g
                []
                [ topRightDot
                , bottomLeftDot
                ]

        Three ->
            g
                []
                [ topRightDot
                , centerDot
                , bottomLeftDot
                ]

        Four ->
            g
                []
                [ topRightDot
                , bottomLeftDot
                , bottomRightDot
                , topLeftDot
                ]

        Five ->
            g
                []
                [ topRightDot
                , bottomLeftDot
                , bottomRightDot
                , topLeftDot
                , centerDot
                ]

        Six ->
            g
                []
                [ topRightDot
                , bottomLeftDot
                , bottomRightDot
                , topLeftDot
                , centerLeftDot
                , centerRightDot
                ]


toInt : Dice -> Int
toInt dice =
    case dice of
        One ->
            1

        Two ->
            2

        Three ->
            3

        Four ->
            4

        Five ->
            5

        Six ->
            6


fromInt : Int -> Maybe Dice
fromInt num =
    case num of
        1 ->
            Just One

        2 ->
            Just Two

        3 ->
            Just Three

        4 ->
            Just Four

        5 ->
            Just Five

        6 ->
            Just Six

        _ ->
            Nothing


toString : Dice -> String
toString dice =
    dice
        |> toInt
        |> String.fromInt
