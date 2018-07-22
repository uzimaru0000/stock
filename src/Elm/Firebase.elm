port module Firebase exposing (..)

import Data.Common exposing (Uid)
import Data.Post exposing (Post)
import Data.User exposing (User)


-- Cmd ports


port login : () -> Cmd msg


port logout : () -> Cmd msg


port postRequest : Uid -> Cmd msg


port postListRequest : () -> Cmd msg



-- Sub ports


port loginSuccess : (User -> msg) -> Sub msg


port logoutSuccess : (() -> msg) -> Sub msg


port getPost : (Post -> msg) -> Sub msg
