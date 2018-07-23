module Data.Post exposing (Post)

import Json.Decode as JD
import Json.Encode as JE


type alias Post =
    { title : String
    , article : String
    , tags : List String
    }


decoder : JD.Decoder Post
decoder =
    JD.map3 Post
        (JD.field "title" JD.string)
        (JD.field "article" JD.string)
        (JD.field "tags" <| JD.list JD.string)


encoder : Post -> JE.Value
encoder post =
    JE.object
        [ ( "title", JE.string post.title )
        , ( "article", JE.string post.article )
        , ( "tags", post.tags |> List.map JE.string |> JE.list )
        ]
