module Edit.Model exposing (..)

import Data.Common exposing (UniqAsset, Uid)
import Data.Post exposing (Post)


type alias Model =
    { title : String
    , article : String
    , input : String
    , tags : List String
    , tagInput : String
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
    { title =
        maybePost
            |> Maybe.map (.asset >> .title)
            |> Maybe.withDefault ""
    , article =
        maybePost
            |> Maybe.map (.asset >> .article)
            |> Maybe.withDefault ""
    , input =
        maybePost
            |> Maybe.map .asset
            |> Maybe.map (\x -> x.title ++ "\n" ++ x.article)
            |> Maybe.withDefault ""
    , windowHeight = winHeight
    , tags =
        maybePost
            |> Maybe.map (.asset >> .tags)
            |> Maybe.withDefault []
    , tagInput =
        maybePost
            |> Maybe.map (.asset >> .tags >> String.join ", ")
            |> Maybe.withDefault ""
    , post = maybePost
    }
