module Model exposing (..)

import Data.User exposing (User)


type Page
    = Blank
    | NotFound
    | Home
    | PostList
    | PostView


type PageState
    = Loaded Page
    | Transition Page


type alias Model =
    { pageState : PageState
    , user : Maybe User
    }
