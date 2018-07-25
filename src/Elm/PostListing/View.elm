module PostListing.View exposing (..)

import Bulma.Components exposing (..)
import Bulma.Layout exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Form exposing (..)
import Bulma.Modifiers exposing (..)
import Data.Post exposing (Post)
import Data.Common exposing (UniqAsset)
import Html exposing (Html, text, span)
import Html.Events exposing (onClick)
import Markdown exposing (toHtml)
import PostListing.Model exposing (..)
import Routing exposing (Route, routeToUrl)


view : Model -> Html Msg
view model =
    section NotSpaced
        []
        [ if List.length model.posts /= 0 then
            model.posts
                |> List.map (postCard >> List.singleton >> column { columnModifiers | widths = postWidth } [])
                |> columns { columnsModifiers | multiline = True } []
          else
            fields Centered
                []
                [ controlButton buttonModifiers
                    []
                    [ onClick (ChangeRoute <| routeToUrl Routing.Create) ]
                    [ span [] [ text "Create Stock" ] ]
                ]
        ]


postCard : UniqAsset Post -> Html Msg
postCard { uid, asset } =
    card
        [ onClick <| ChangeRoute (routeToUrl <| Routing.Post uid)
        ]
        [ cardHeader []
            [ cardTitle []
                [ content Standard
                    []
                    [ toHtml [] asset.title
                    ]
                ]
            ]
        , cardContent []
            [ content Standard
                []
                [ (previewText >> toHtml []) asset.article
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
