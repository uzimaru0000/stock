module Post.View exposing (..)

import Post.Model exposing (..)
import Html exposing (Html, text, div, span, hr, i, a, p)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onClick)
import Bulma.Layout exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Modifiers exposing (..)
import Markdown exposing (toHtml)
import Routing exposing (Route, routeToUrl)


view : Model -> Html Msg
view { post, isModalActive } =
    section NotSpaced
        []
        [ columns { columnsModifiers | centered = True }
            []
            [ column
                { columnModifiers
                    | widths =
                        Devices (Just Auto) (Just Auto) widths widths widths
                }
                []
                [ box []
                    [ level
                        [ class "is-mobile"
                        ]
                        [ levelLeft []
                            [ levelItem []
                                [ title H3
                                    []
                                    [ post.asset.title
                                        |> String.filter ((/=) '#')
                                        |> String.trim
                                        |> text
                                    ]
                                ]
                            ]
                        , levelRight []
                            [ levelItem [ onClick <| ChangeRoute (routeToUrl <| Routing.Edit post.uid) ]
                                [ button { buttonModifiers | color = White }
                                    []
                                    [ icon Standard [] [ i [ class "fas fa-edit" ] [] ]
                                    ]
                                ]
                            , levelItemLink []
                                [ delete [ onClick <| ChangeModalState True ] []
                                ]
                            ]
                        ]
                    , hr [] []
                    , content Standard
                        []
                        [ toHtml [] post.asset.article
                        ]
                    , hr [] []
                    , post.asset.tags
                        |> List.map postTag
                        |> tags []
                    ]
                ]
            ]
        , removeModal isModalActive
        ]


widths : Maybe Width
widths =
    Just Width9


postTag : String -> Html Msg
postTag str =
    tag { tagModifiers | color = Info, isLink = True, size = Standard }
        []
        [ text <| "# " ++ str ]


removeModal : Bool -> Html Msg
removeModal isActive =
    modal isActive
        []
        [ modalBackground [ onClick <| ChangeModalState False ] []
        , modalCard []
            [ modalCardHead []
                [ modalCardTitle [] [ text "Remove" ]
                , modalClose Standard [ onClick <| ChangeModalState False ] []
                ]
            , modalCardBody []
                [ content Standard
                    []
                    [ p [] [ text "本当に消してもいいですか？\n（消した内容は戻りません）" ] ]
                ]
            , modalCardFoot []
                [ button { buttonModifiers | color = Danger }
                    [ onClick RemovePost ]
                    [ span [] [ text "OK" ] ]
                , button buttonModifiers
                    [ onClick <| ChangeModalState False ]
                    [ span [] [ text "Cancel" ] ]
                ]
            ]
        ]
