module Edit.Update exposing (..)

import Edit.Model exposing (..)
import Firebase exposing (..)
import Navigation
import Routing exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeSize height ->
            { model | windowHeight = height } ! []

        InputArticle str ->
            let
                title =
                    str
                        |> String.split "\n"
                        |> List.head
                        |> Maybe.withDefault ""

                article =
                    str
                        |> String.split "\n"
                        |> List.drop 1
                        |> String.join "\n"
            in
                { model
                    | title = title
                    , article = article
                    , input = str
                }
                    ! []

        InputTags str ->
            let
                tags =
                    str
                        |> String.split ","
                        |> List.map String.trim
                        |> List.filter (not << String.isEmpty)
            in
                { model | tags = tags, tagInput = str } ! []

        Store ->
            let
                post =
                    { title = model.title
                    , article = model.article
                    , tags = model.tags
                    }
            in
                model ! [ storePost ( model.post |> Maybe.map .uid, post ) ]

        StoreSuccess uid ->
            model ! [ Navigation.newUrl (routeToUrl <| Routing.Post uid) ]
