module Edit.Model exposing (..)

import Data.Common exposing (UniqAsset, Uid)
import Data.Post exposing (Post)


type alias Model =
    { article : String
    , tags : String
    , windowHeight : Int
    , post : Maybe (UniqAsset Post)
    }


type Msg
    = Store
    | StoreSuccess Uid
    | InputArticle String
    | InputTags String
    | ChangeSize Int


init : Maybe (UniqAsset Post) -> Int -> Model
init maybePost winHeight =
    { article = ""
    , windowHeight = winHeight
    , tags = ""
    , post = maybePost
    }
