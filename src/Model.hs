{-# LANGUAGE DeriveGeneric #-}
-- |

module Model where

import GHC.Generics

data Item = Item
  {
    itemId :: Integer
  , itemText :: String
  } deriving (Eq, Show, Generic)

exampleItem :: Item
exampleItem = Item 0 "Example item"
