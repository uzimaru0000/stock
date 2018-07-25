module Routing exposing (..)

import Html
import Html.Attributes as Html
import Data.Common exposing (Uid)
import UrlParser exposing (..)
import Navigation exposing (..)


type Route
    = Home
    | Post Uid
    | Create
    | Edit Uid
    | NotFound


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Home top
        , map Post (s "post" </> string)
        , map Create (s "new")
        , map Edit (s "edit" </> string)
        ]


parseLocation : Location -> Route
parseLocation loc =
    case (parseHash matchers loc) of
        Just route ->
            route

        Nothing ->
            NotFound


routeToUrl : Route -> String
routeToUrl route =
    "#/"
        ++ (case route of
                Home ->
                    ""

                Post uid ->
                    String.join "/" [ "post", uid ]

                Edit uid ->
                    String.join "/" [ "edit", uid ]

                Create ->
                    "new"

                NotFound ->
                    "notfound"
           )


href : Route -> Html.Attribute msg
href =
    Html.href << routeToUrl
