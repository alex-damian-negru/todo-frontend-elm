module Todo exposing (Todo, add, empty, initTodos, remove, view)

import Html exposing (Html, li, text, ul)



-- MODEL


type alias Todo =
    { id : Int
    , title : String
    , completed : Bool
    , order : Int
    , url : String
    }


empty : Todo
empty =
    Todo 5 "" False 5 ""


initTodos : List Todo
initTodos =
    [ Todo 1 "test1" True 1 "http://"
    , Todo 2 "test2" True 2 "http://"
    , Todo 3 "test3" True 3 "http://"
    , Todo 4 "test4" True 4 "http://"
    ]



-- VIEW


view : List Todo -> Html msg
view todos =
    let
        renderedTodos =
            todos
                |> List.map renderTodo
    in
    ul [] renderedTodos


renderTodo : Todo -> Html msg
renderTodo todo =
    li [] [ text todo.title ]



-- HELPERS


add : Todo -> List Todo -> List Todo
add todo todos =
    List.append todos [ todo ]


remove : List Todo -> List Todo
remove todos =
    todos
        |> List.tail
        |> Maybe.withDefault []
