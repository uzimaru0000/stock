module PostListing.Update exposing (..)

import PostListing.Model exposing (Model, Msg(..))
import Routing exposing (Route(Post), transitionRoute)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectPost uid ->
            model ! [ transitionRoute <| Post uid ]
