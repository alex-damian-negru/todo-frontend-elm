module Main exposing (..)

import Browser
import Components.TodoInput as TodoInput
import Html exposing (Html, button, div, li, text, ul)
import Html.Events exposing (onClick)
import Todo exposing (Todo, view)



---- MODEL ----


type alias Model =
    { todos : List Todo
    , newTodo : Maybe Todo
    }


init : ( Model, Cmd Msg )
init =
    ( { todos = Todo.initTodos
      , newTodo = Nothing
      }
    , Cmd.none
    )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        maybeNewTodoInput =
            model.newTodo
                |> Maybe.map TodoInput.view
    in
    div []
        ([ addTodo
         , removeTodo
         , Todo.view model.todos
         ]
            ++ (case maybeNewTodoInput of
                    Just newTodoInput ->
                        [ Html.map GotInputMsg newTodoInput ]

                    Nothing ->
                        []
               )
        )


addTodo : Html Msg
addTodo =
    button [ onClick AddTodo ] [ text "Add" ]


removeTodo : Html Msg
removeTodo =
    button [ onClick RemoveTodo ] [ text "Remove" ]



---- UPDATE ----


type Msg
    = NoOp
    | AddTodo
    | RemoveTodo
    | GotInputMsg TodoInput.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddTodo ->
            ( { model
                | newTodo = Just Todo.empty
              }
            , Cmd.none
            )

        RemoveTodo ->
            ( { model
                | todos = Todo.remove model.todos
              }
            , Cmd.none
            )

        GotInputMsg todoInputMsg ->
            handleInputMsg todoInputMsg model

        NoOp ->
            ( model, Cmd.none )


handleInputMsg : TodoInput.Msg -> Model -> ( Model, Cmd Msg )
handleInputMsg todoInputMsg model =
    case model.newTodo of
        Just todo ->
            let
                ( updatedTodo, newCmd ) =
                    TodoInput.update todoInputMsg todo

                updatedModel =
                    case todoInputMsg of
                        TodoInput.Save ->
                            { model | todos = Todo.add updatedTodo model.todos, newTodo = Nothing }

                        _ ->
                            { model | newTodo = Just updatedTodo }
            in
            ( updatedModel, Cmd.map GotInputMsg newCmd )

        Nothing ->
            ( model, Cmd.none )



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
