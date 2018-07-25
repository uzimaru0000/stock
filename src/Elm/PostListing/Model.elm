module PostListing.Model exposing (..)

import Data.Post exposing (Post)
import Data.User exposing (User)
import Data.Common exposing (UniqAsset, Uid)


type alias Model =
    { posts : List (UniqAsset Post)
    }


type Msg
    = ChangeRoute String


init : User -> List (UniqAsset Post) -> Model
init user posts =
    { posts = posts
    }
