module Main exposing (..)

import Browser
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


type alias Task =
    { id : Int
    , title : String
    , completed : Bool
    , order : Int
    , url : String
    }


init : ( Task, Cmd Msg )
init =
    ( Task 42 "title" True 42 "url"
    , Cmd.none
    )


stringFromBool : Bool -> String
stringFromBool value =
    if value then
        "true"

    else
        "false"



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Task -> ( Task, Cmd Msg )
update msg task =
    ( task, Cmd.none )



---- VIEW ----


view : Task -> Html Msg
view task =
    div []
        [ img [ src "/logo.svg" ] []
        , div [] [ text ("id: " ++ String.fromInt task.id) ]
        , div [] [ text ("title: " ++ task.title) ]
        , div [] [ text ("completed: " ++ stringFromBool task.completed) ]
        , div [] [ text ("order: " ++ String.fromInt task.order) ]
        , div [] [ text ("url: " ++ task.url) ]
        ]



---- PROGRAM ----


main : Program () Task Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
