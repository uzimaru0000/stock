module Edit.View exposing (..)

import Bulma.Layout exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Html exposing (Html, text, div, span, hr)
import Html.Attributes exposing (style, class, id, placeholder, value)
import Html.Events exposing (onInput, onClick)
import Edit.Model exposing (..)
import Markdown exposing (..)


view : Model -> Html Msg
view model =
    section NotSpaced
        [ style [ ( "height", (toString <| model.windowHeight - 52) ++ "px" ) ]
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
                , placeholder "← This line is title"
                , value model.input
                ]
                []
            ]
        , field
            [ style [ ( "height", "auto" ) ] ]
            [ controlText controlInputModifiers
                []
                [ onInput InputTags
                , placeholder "Input Tags (Ex : tag1, tag2)"
                , value model.tagInput
                ]
                []
            ]
        ]


previewArea : Model -> Html Msg
previewArea model =
    let
        title =
            if (String.length model.title) == 0 then
                ""
            else
                [ "# "
                , model.title
                    |> String.filter ((/=) '#')
                    |> String.trim
                , "\n"
                , "---"
                ]
                    |> String.join ""

        md =
            [ title, model.article ]
                |> String.join "\n"
    in
        div [ style [ ( "height", "100%" ) ] ]
            [ box
                [ style
                    [ ( "height", "100%" )
                    , ( "overflow", "auto" )
                    ]
                ]
                [ content Standard
                    []
                    [ toHtml [] md
                    ]
                , hr [] []
                , model.tags
                    |> List.map tagPreview
                    |> tags []
                ]
            , buttons Right
                []
                [ button { buttonModifiers | color = Success }
                    [ style [ ( "padding", "0 32px" ) ]
                    , onClick Store
                    ]
                    [ span [] [ text "Finish" ]
                    ]
                ]
            ]


tagPreview : String -> Html Msg
tagPreview str =
    tag { tagModifiers | color = Info }
        []
        [ text ("# " ++ str) ]
