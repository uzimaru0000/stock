module PostListing.View exposing (..)

import Bulma.Components exposing (..)
import Bulma.Layout exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Data.Post exposing (Post)
import Html exposing (Html, text)
import Markdown exposing (toHtml)
import PostListing.Model exposing (..)


view : Model -> Html Msg
view model =
    section NotSpaced
        []
        [ model.posts
            |> List.map (postCard >> List.singleton >> column { columnModifiers | widths = postWidth } [])
            |> columns { columnsModifiers | multiline = True } []
        ]


postCard : Post -> Html Msg
postCard post =
    card []
        [ cardHeader []
            [ cardTitle [] [ text post.title ]
            ]
        , cardContent []
            [ content Standard
                []
                [ (previewText >> toHtml []) post.article
                ]
            ]
        ]


postWidth : Devices (Maybe Width)
postWidth =
    { mobile = Just Auto
    , tablet = Just Width2
    , desktop = Just Width2
    , widescreen = Just Width2
    , fullHD = Just Width2
    }


previewText : String -> String
previewText str =
    str
        |> String.split "\n"
        |> List.take 3
        |> List.map hashCheck
        |> String.join "\n"


hashCheck : String -> String
hashCheck str =
    let
        hash =
            String.filter ((==) '#') str

        others =
            String.filter ((/=) '#') str
    in
        if String.length hash == 5 then
            others
        else if String.length hash == 0 then
            others
        else
            hash ++ "##" ++ others