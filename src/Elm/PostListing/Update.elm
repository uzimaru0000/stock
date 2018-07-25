module PostListing.Update exposing (..)

import PostListing.Model exposing (Model, Msg(..))
import Navigation exposing (newUrl)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeRoute url ->
            model ! [ newUrl url ]
