module PostListing.Model exposing (..)

import Data.Post exposing (Post)
import Data.Common exposing (UniqAsset, Uid)


type alias Model =
    { posts : List (UniqAsset Post)
    }


type Msg
    = ChangeRoute String
    | GetPosts (List (UniqAsset Post))


init : List (UniqAsset Post) -> Model
init posts =
    { posts = posts
    }
