module PostListing.Model exposing (..)

import Data.Post exposing (Post)
import Data.User exposing (User)
import Data.Common exposing (UniqAsset, Uid)


type alias Model =
    { user : UniqAsset User
    , posts : UniqAsset (List Post)
    }


type Msg
    = SelectPost Uid
    

init : Model
init =
    { user = UniqAsset "" <| User "" Nothing
    , posts =
        UniqAsset ""
            (List.range 0 7
                |> List.map
                    (\_ ->
                        { title = "hoge"
                        , article = """# hoge
## hogehoge
- hoge
- hoge
"""
                        , tags = []
                        }
                    )
            )
    }
