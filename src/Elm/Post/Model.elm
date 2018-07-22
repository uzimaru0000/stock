module Post.Model exposing (..)

import Data.Post exposing (Post)
import Data.User exposing (User)


type alias Model =
    { user : User
    , post : Post
    }


init : Model
init =
    { user = User "" "" Nothing
    , post =
        { uid = ""
        , title = "ViewTest"
        , article = """ # hoge
## hogehoge
- test
- test
"""
        , tags = [ "tag1", "tag2" ]
        }
    }