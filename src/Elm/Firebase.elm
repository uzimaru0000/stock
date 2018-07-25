port module Firebase exposing (..)

import Data.Common exposing (Uid, UniqAsset)
import Data.Post exposing (Post)
import Data.User exposing (User)


-- Cmd ports


port login : () -> Cmd msg


port logout : () -> Cmd msg


port postListInit : () -> Cmd msg


port editInit : Uid -> Cmd msg


port postInit : Uid -> Cmd msg


port storePost : ( Maybe Uid, Post ) -> Cmd msg



-- Sub ports


port loginSuccess : (User -> msg) -> Sub msg


port logoutSuccess : (() -> msg) -> Sub msg


port getPostListData : (List (UniqAsset Post) -> msg) -> Sub msg


port getEditData : (UniqAsset Post -> msg) -> Sub msg


port getPostData : (UniqAsset Post -> msg) -> Sub msg


port successStorePost : (Uid -> msg) -> Sub msg
