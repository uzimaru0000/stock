module PostListing.Sub exposing (..)


import PostListing.Model exposing (..)
import Firebase exposing (..)

subscriptions : Model -> Sub Msg
subscriptions model =
    getPostList GetPosts    