module Main exposing (main)

import Browser
import Dice exposing (Dice(..), viewDice, viewDiceContainer)
import Html exposing (Html, button, div, hr, input, label, span, text)
import Html.Attributes exposing (class, placeholder, type_)
import Html.Events exposing (onClick, onInput, onSubmit)


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = RollDice
    | DiceCount String


update : Msg -> Model -> Model
update msg model =
    case msg of
        RollDice ->
            { model | count = model.count + 1 }

        DiceCount ct ->
            { model
                | count =
                    Maybe.withDefault 0 (String.toInt ct)
            }


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ viewDiceNeededForm
        , viewDiceContainer [ One, Two, Three, Four, Five, Six ]
        ]


viewDiceNeededForm : Html Msg
viewDiceNeededForm =
    div [ class "dice-form" ]
        [ label
            [ class "dice-label" ]
            [ span
                [ class "dice-label-text" ]
                [ text "How many dice?" ]
            ]
        , input
            [ type_ "number"
            , placeholder "0"
            , onInput DiceCount
            , class "dice-input"
            ]
            []
        , button [ class "roll-dice-btn", onClick RollDice ] [ text "Roll" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
