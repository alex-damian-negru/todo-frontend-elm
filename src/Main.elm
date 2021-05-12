module Main exposing (..)

import Browser
import Components.TodoInput as TodoInput
import Html exposing (Html, button, div, li, text, ul)
import Html.Events exposing (onClick)
import Todo exposing (Todo, view)



---- MODEL ----


type alias Model =
    { todos : List Todo
    , todoInProgress : Maybe Todo
    }


init : ( Model, Cmd Msg )
init =
    ( { todos = Todo.initTodos
      , todoInProgress = Nothing
      }
    , Cmd.none
    )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        maybeNewTodoInput =
            model.todoInProgress
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
                | todoInProgress = Just Todo.empty
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
    case model.todoInProgress of
        Just newTodo ->
            let
                ( updatedNewTodo, newCmd ) =
                    TodoInput.update todoInputMsg newTodo
            in
            ( { model | todoInProgress = Just updatedNewTodo }, Cmd.map GotInputMsg newCmd )

        --TODO If the Input sent a Save message, append the ToDo in progress to the list of todos in the model and make ToDo in Progress to Nothing
        --TODO If the Input sent anything else (SetTitle), take the udated ToDo and set it on the Model as the ToDo in progress
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
