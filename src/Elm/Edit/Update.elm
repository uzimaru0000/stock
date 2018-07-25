module Edit.Update exposing (..)

import Edit.Model exposing (..)
import Data.Post exposing (Post)
import Firebase exposing (..)
import Navigation
import Routing exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeSize height ->
            { model | windowHeight = height } ! []

        InputArticle str ->
            { model | article = str } ! []

        InputTags str ->
            { model | tags = str } ! []

        Store ->
            let
                splitText =
                    model.article
                        |> String.split "\n"

                post =
                    { title =
                        splitText
                            |> List.head
                            |> Maybe.withDefault ""
                    , article =
                        splitText
                            |> List.tail
                            |> Maybe.map (String.join "\n")
                            |> Maybe.withDefault ""
                    , tags =
                        model.tags
                            |> String.split ","
                            |> List.map String.trim
                            |> List.filter (not << String.isEmpty)
                    }
            in
                model ! [ storePost ( model.post |> Maybe.map .uid, post ) ]

        StoreSuccess uid ->
            model ! [ Navigation.newUrl (routeToUrl <| Routing.Post uid) ]
