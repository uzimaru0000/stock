module Create.Update exposing (..)

import Create.Model exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ChangeSize size ->
            { model | windowSize = size } ! []
        InputArticle str ->
            { model | article = str } ! []
        InputTags str ->
            { model | tags = str } ! []
        _ ->
            model ! []