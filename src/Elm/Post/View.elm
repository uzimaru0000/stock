module Post.View exposing (..)

import Post.Model exposing (..)
import Html exposing (Html, text, div, span, hr, i)
import Html.Attributes exposing (style, class)
import Bulma.Layout exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Markdown exposing (toHtml)


view : Model -> Html msg
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
                            [ levelItem [] [ title H3 [] [ text post.asset.title ] ]
                            ]
                        , levelRight []
                            [ button { buttonModifiers | color = White }
                                []
                                [ icon Standard [] [ i [ class "fas fa-edit" ] [] ]
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


postTag : String -> Html msg
postTag str =
    tag { tagModifiers | color = Info, isLink = True, size = Standard }
        []
        [ text <| "# " ++ str ]
