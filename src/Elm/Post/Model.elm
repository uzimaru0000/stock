module Post.Model exposing (..)

import Data.Post exposing (Post)
import Data.User exposing (User)
import Data.Common exposing (UniqAsset)

type alias Model =
    { user : UniqAsset User
    , post : UniqAsset Post
    }


init : Model
init =
    { user = UniqAsset "" (User "" Nothing)
    , post =
        UniqAsset "" <|
            { title = "ViewTest"
            , article = """ # hoge
## hogehoge
- test
- test
"""
            , tags = [ "tag1", "tag2" ]
            }
    }
