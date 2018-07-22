module Data.Post exposing (Post)

import Json.Decode as JD
import Json.Encode as JE
import Data.Common exposing (..)


type alias Post =
    { uid : Uid
    , title : String
    , article : String
    , tags : List String
    }


decoder : JD.Decoder Post
decoder =
    JD.map4 Post
        (JD.field "uid" JD.string)
        (JD.field "title" JD.string)
        (JD.field "article" JD.string)
        (JD.field "tags" <| JD.list JD.string)


encoder : Post -> JE.Value
encoder post =
    JE.object
        [ ( "uid", JE.string post.uid )
        , ( "title", JE.string post.title )
        , ( "article", JE.string post.article )
        , ( "tags", post.tags |> List.map JE.string |> JE.list )
        ]
