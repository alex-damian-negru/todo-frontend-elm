module Main exposing (..)

import Browser
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


type alias Model =
    { id : Int
    , title : String
    , completed : Bool
    , order : Int
    , url : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model 42 "title" True 42 "url"
    , Cmd.none
    )



---- VIEW ----


view : Model -> Html Msg
view task =
    div []
        [ img [ src "/logo.svg" ] []
        , div [] [ text ("id: " ++ String.fromInt task.id) ]
        , div [] [ text ("title: " ++ task.title) ]
        , div [] [ text ("order: " ++ String.fromInt task.order) ]
        , div [] [ text ("url: " ++ task.url) ]
        ]



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg task =
    ( task, Cmd.none )



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
