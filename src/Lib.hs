{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Lib where

import Data.Aeson
import Servant
import Model

type ItemApi =
  "item" :> Get '[JSON] [Item] :<|>
  "item" :> Capture "itemId" Integer :> Get '[JSON] Item

itemApi :: Proxy ItemApi
itemApi = Proxy

mkApp :: IO Application
mkApp  = return $ serve itemApi server

server :: Server ItemApi
server =
  getItems :<|>
  getItemById

getItems :: Handler [Item]
getItems = return [exampleItem]

getItemById :: Integer -> Handler Item
getItemById = \ case
  0 -> return exampleItem
  _ -> throwError err404

instance ToJSON Item
instance FromJSON Item
