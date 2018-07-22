module Routing exposing (..)

import Data.Common exposing (Uid)
import UrlParser exposing (..)
import Navigation exposing (..)


type Route
    = Home
    | Post Uid
    | NotFound


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Home top
        , map Post (s "post" </> string)
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
    case route of
        Home ->
            "/"

        Post uid ->
            String.join "/" [ "post", uid ]

        NotFound ->
            "notfound"


transitionRoute : Route -> Cmd msg
transitionRoute =
    newUrl << routeToUrl
