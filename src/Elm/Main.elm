module Main exposing (..)

import Html exposing (Html, program, text)
-- import PostListing.Model exposing (..)
-- import PostListing.Update exposing (update)
-- import PostListing.View exposing (view)
-- import Post.Model exposing (..)
-- import Post.View exposing (view)
import Create.Model exposing (..)
import Create.Update exposing (update)
import Create.View exposing (view)


--main : Html msg
--main =
--    text "hoge"


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
