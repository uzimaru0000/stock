module Model exposing (..)

import Navigation exposing (Location)
import Data.User exposing (User)
import Data.Common exposing (UniqAsset)
import Data.Post exposing (Post)
import Edit.Model as Edit
import Post.Model as Post
import PostListing.Model as PostListing
import Routing exposing (..)


type Page
    = Blank
    | NotFound
    | Home
    | PostList PostListing.Model
    | PostView Post.Model
    | Edit Edit.Model


type PageState
    = Loaded Page
    | Transition Page


type alias Model =
    { pageState : PageState
    , user : Maybe User
    }


type Msg
    = LocationChange Location
    | RouteChange Route
    | Login
    | Logout
    | PostListingMsg PostListing.Msg
    | EditMsg Edit.Msg
    | PostListInit (List (UniqAsset Post))
    | CreateInit (Maybe (UniqAsset Post)) Int
    | EditInit (UniqAsset Post)
    | PostInit (UniqAsset Post)


getPage : PageState -> Page
getPage pageState =
    case pageState of
        Loaded page ->
            page
        Transition page ->
            page


init : Maybe User -> Model
init maybeUser =
    { pageState = Loaded Blank 
    , user = maybeUser
    }