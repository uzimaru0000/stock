module PostListing.Model exposing (..)

import Data.Post exposing (Post)
import Data.User exposing (User)
import Data.Common exposing (Uid)


type alias Model =
    { user : User
    , posts : List Post
    }


type Msg
    = SelectPost Uid


init : Model
init =
    { user = User "" "" Nothing
    , posts =
        List.range 0 7
            |> List.map
                (\_ ->
                    { uid = ""
                    , title = "hoge"
                    , article = """# hoge
## hogehoge
- hoge
- hoge
"""
                    , tags = []
                    }
                )
    }
