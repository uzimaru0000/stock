module PostListing.Update exposing (..)

import PostListing.Model exposing (Model, Msg(..))
import Routing exposing (Route(Post), routeToUrl)
import Navigation exposing (newUrl)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectPost uid ->
            model ! [ newUrl (routeToUrl <| Post uid) ]
