module Components.TodoInput exposing (Msg(..), update, view)

import Html exposing (Html, form, input)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput, onSubmit)
import Todo exposing (Todo)



-- MODEL


type alias Model =
    Todo



-- VIEW


view : Model -> Html Msg
view model =
    let
        titleInput =
            input
                [ value model.title
                , onInput SetTitle
                ]
                []
    in
    form [ onSubmit Save ]
        [ titleInput
        ]



-- UPDATE


type Msg
    = SetTitle String
    | Save


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetTitle newTitle ->
            ( { model | title = newTitle }, Cmd.none )

        Save ->
            ( model, Cmd.none )
