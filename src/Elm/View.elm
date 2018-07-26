module View exposing (..)

import Html exposing (Html, text, div, i)
import Html.Attributes exposing (classList, class)
import Html.Events exposing (onClick)
import Model exposing (..)
import Data.User exposing (User)
import Routing exposing (Route, href)
import Bulma.Components exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import PostListing.View as PostListing
import Post.View as Post
import Edit.View as Edit


view : Model -> Html Msg
view model =
    case model.pageState of
        Loaded page ->
            frame model.user page False

        Transition page ->
            frame model.user page True


frame : Maybe User -> Page -> Bool -> Html Msg
frame maybeUser currentPage isLoading =
    div []
        [ loading isLoading
        , navigation maybeUser
        , page currentPage
        ]


navigation : Maybe User -> Html Msg
navigation user =
    navbar { navbarModifiers | color = Dark }
        []
        [ navbarBrand []
            (navbarBurger False [] [])
            [ navbarItemLink False [ href Routing.Home ] [ text "Stock" ]
            ]
        , navbarMenu False
            []
            [ navbarStart []
                [ navbarItemLink False
                    [ href Routing.Create
                    , displayByDevice
                        { mobile = Inline
                        , tablet = Inline
                        , desktop = Hidden
                        , widescreen = Hidden
                        , fullHD = Hidden
                        }
                    ]
                    [ text "New Stock" ]
                ]
            , navbarEnd []
                [ if user /= Nothing then
                    navbarItemLink False [ href Routing.Create ]
                        [ icon Medium [] [ i [ class "fas fa-lg fa-plus" ] [] ] ]
                  else
                    text ""
                ]
            ]
        ]


page : Page -> Html Msg
page currentPage =
    case currentPage of
        Home ->
            button buttonModifiers [ onClick Login ] [ text "login" ]

        PostList model ->
            PostListing.view model |> Html.map PostListingMsg

        PostView model ->
            Post.view model |> Html.map PostMsg

        Edit model ->
            Edit.view model |> Html.map EditMsg

        _ ->
            text ""


loading : Bool -> Html msg
loading isLoading =
    div
        [ classList
            [ ( "inactive", not isLoading )
            , ( "loading", True )
            , ( "has-background-light", True )
            ]
        ]
        [ div
            [ class "sk-circle" ]
            (List.range 1 12
                |> List.map (toString >> (++) "sk-child sk-circle" >> class)
                |> List.map (\a -> div [ a ] [])
            )
        ]
