module Main exposing (..)

import Navigation exposing (programWithFlags)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Data.User exposing (User)
import Routing exposing (parseLocation)
import Firebase exposing (..)
import Edit.Sub as Edit


main : Program (Maybe User) Model Msg
main =
   programWithFlags LocationChange
    { init = \maybeUser loc -> setRoute (parseLocation loc) (init maybeUser)
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

subscriptions : Model -> Sub Msg
subscriptions model =
    [ case getPage model.pageState of
        Edit model ->
            Edit.subscriptions model |> Sub.map EditMsg

        _ ->
            Sub.none
    , getPostListData PostListInit
    , getPostData PostInit
    , getEditData EditInit
    ]
    |> Sub.batch