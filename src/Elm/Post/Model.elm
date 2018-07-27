module Post.Model exposing (..)

import Data.Post exposing (Post)
import Data.Common exposing (UniqAsset)

type alias Model =
    { post : UniqAsset Post
    , isModalActive : Bool
    }


type Msg
    = ChangeRoute String
    | RemovePost
    | ChangeModalState Bool


init : UniqAsset Post -> Model
init post =
    { post = post
    , isModalActive = False
    }
