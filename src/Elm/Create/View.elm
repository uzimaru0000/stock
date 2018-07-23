module Create.View exposing (..)

import Bulma.Layout exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Modifiers exposing (..)
import Html exposing (Html, text, div, span)
import Html.Attributes exposing (style, class, id, rows)
import Html.Events exposing (onInput, onClick)
import Create.Model exposing (..)
import Markdown exposing (..)


view : Model -> Html Msg
view model =
    section NotSpaced
        [ style [ ( "height", (toString <| model.windowSize.height - 52) ++ "px" ) ]
        ]
        [ columns columnsModifiers
            [ style [ ( "height", "100%" ) ] ]
            [ column columnModifiers [ id "edit" ] [ editArea model ]
            , column columnModifiers [ style [ ( "height", "100%" ) ] ] [ previewArea model ]
            ]
        ]


editArea : Model -> Html Msg
editArea model =
    content Standard
        []
        [ field
            []
            [ controlTextArea controlTextAreaModifiers
                []
                [ style
                    [ ( "resize", "none" )
                    , ( "max-height", "initial" )
                    ]
                , onInput InputArticle
                ]
                []
            ]
        , field
            [ style [ ( "height", "auto" ) ] ]
            [ controlText controlInputModifiers
                []
                [ onInput InputTags ]
                []
            ]
        ]


previewArea : Model -> Html Msg
previewArea model =
    div [ style [ ( "height", "100%" ) ] ]
        [ box [ style [ ( "height", "100%" ) ] ]
            [ content Standard [] [ toHtml [] model.article ]
            , model.tags
                |> String.split ","
                |> List.map String.trim
                |> List.filter (not << String.isEmpty)
                |> List.map tagPreview
                |> tags []
            ]
        , buttons Right
            []
            [ button { buttonModifiers | color = Success }
                [ style [ ( "padding", "0 32px" ) ]
                , onClick Create
                ]
                [ span [] [ text "Create" ] ]
            ]
        ]


tagPreview : String -> Html Msg
tagPreview str =
    tag { tagModifiers | color = Info }
        []
        [ text ("# " ++ str) ]
