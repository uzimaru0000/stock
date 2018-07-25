module PostListing.Model exposing (..)

import Data.Post exposing (Post)
import Data.User exposing (User)
import Data.Common exposing (UniqAsset, Uid)


type alias Model =
    { user : User
    , posts : List (UniqAsset Post)
    }


type Msg
    = SelectPost Uid


init : User -> List (UniqAsset Post) -> Model
init user posts =
    { user = user
    , posts = posts
    }
