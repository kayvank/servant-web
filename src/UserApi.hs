{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}
-- |
module UserApi where

import Data.Aeson
import Servant.API
import Servant.Server
import Database.Persist.Postgresql (ConnectionString)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Except (throwE)
import Data.Proxy (Proxy(..))
import Data.Int
import Database
import Schema
import Network.Wai.Handler.Warp (run)

-- define API type
type UsersApi =
  "v1" :> "users" :> Capture "userid" Int64 :> Get '[JSON] User
  :<|>
  "v1" :> "users" :> ReqBody '[JSON] User :> Post '[JSON] Int64

usersApi :: Proxy UsersApi
usersApi = Proxy :: Proxy UsersApi

fetchUserHandler :: ConnectionString -> Int64 -> Handler User
fetchUserHandler conn uid =  do
  maybeuser <- liftIO $ fetchUser conn uid
  case maybeuser of
    Just theUser -> return theUser
    Nothing -> Handler $ ( throwE $ err401 { errBody = "Could not find the user" } )

usersServer :: ConnectionString -> Server UsersApi
usersServer conn = (fetchUserHandler conn) :<|> (createUserHandler conn )

createUserHandler :: ConnectionString -> User -> Handler Int64
createUserHandler conn user = liftIO $ createUser conn user

runServer' :: ConnectionString -> IO ()
runServer' dbConn = run 3000 (serve usersApi (usersServer dbConn))

runServer :: IO ()
runServer = do
  dbConn <- fetchConnection
  run 3000 (serve usersApi (usersServer dbConn))
