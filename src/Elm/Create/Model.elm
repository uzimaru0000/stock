module Create.Model exposing (..)

import Data.User exposing (..)
import Data.Common exposing (UniqAsset)
import Window exposing (Size)
import Task

type alias Model =
    { user : UniqAsset User
    , article : String
    , tags : String
    , windowSize : Size
    }


type Msg
    = Create
    | InputArticle String
    | InputTags String
    | ChangeSize Size


init : ( Model, Cmd Msg )
init =
    { user = UniqAsset "" (User "" Nothing)
    , article = ""
    , windowSize = Size 0 0
    , tags = ""
    }
    ! [ Task.perform ChangeSize Window.size ]