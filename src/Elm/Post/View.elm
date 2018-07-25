module Post.View exposing (..)

import Post.Model exposing (..)
import Html exposing (Html, text, div, span, hr, i, a)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onClick)
import Bulma.Layout exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Markdown exposing (toHtml)
import Routing exposing (Route, routeToUrl)


view : Model -> Html Msg
view { post } =
    section NotSpaced
        []
        [ columns { columnsModifiers | centered = True }
            []
            [ column
                { columnModifiers
                    | widths =
                        Devices widths widths widths widths widths
                }
                []
                [ box []
                    [ level []
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
                                [ delete [ onClick RemovePost ] []
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
        ]


widths : Maybe Width
widths =
    Just Width9


postTag : String -> Html Msg
postTag str =
    tag { tagModifiers | color = Info, isLink = True, size = Standard }
        []
        [ text <| "# " ++ str ]
