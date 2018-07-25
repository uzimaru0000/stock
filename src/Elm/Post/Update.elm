module Post.Update exposing (..)

import Post.Model exposing (..)
import Navigation
import Routing exposing (Route, routeToUrl)
import Firebase exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeRoute url ->
            model ! [ Navigation.newUrl url ]

        RemovePost ->
            model ! [ removePost model.post.uid, Navigation.newUrl <| routeToUrl Routing.Home ]
