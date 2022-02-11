module Main exposing (main)

import Browser
import Dice exposing (Dice(..), viewDiceContainer)
import Html exposing (Html, button, div, input, label, span, text)
import Html.Attributes exposing (class, placeholder, type_)
import Html.Events exposing (onClick, onInput)
import Random


type alias Model =
    { count : Int
    , diceList : List Dice
    }


initialModel : Model
initialModel =
    { count = 0
    , diceList = []
    }


type Msg
    = RollDice
    | DiceCount String
    | GotNewDiceList (List Dice)


roll : Int -> Random.Generator (List Dice)
roll n =
    Random.list n (Random.uniform One [ Two, Three, Four, Five, Six ])


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RollDice ->
            ( model, Random.generate GotNewDiceList (roll model.count) )

        DiceCount ct ->
            let
                intCt =
                    ct
                        |> String.toInt
                        |> Maybe.withDefault model.count
            in
            ( if intCt < 100 && intCt > 0 then
                { model
                    | count =
                        Maybe.withDefault model.count (String.toInt ct)
                }

              else
                model
            , Cmd.none
            )

        GotNewDiceList diceList ->
            ( { model | diceList = diceList }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ viewDiceNeededForm model.diceList
        , viewDiceContainer model.diceList
        ]


viewDiceNeededForm : List Dice -> Html Msg
viewDiceNeededForm diceList =
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
        , button [ class "roll-dice-btn", onClick RollDice ]
            [ text <|
                case diceList of
                    [] ->
                        "Roll"

                    _ ->
                        "Roll again"
            ]
        ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
