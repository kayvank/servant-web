{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE OverloadedStrings          #-}

module Schema where

import Data.Aeson.Types (Pair, Parser)
import Data.Aeson(ToJSON
                 , toJSON
                 , object
                 , (.=)
                 , FromJSON
                 , parseJSON
                 , (.:)
                 , withObject
                 , Object)

import           Database.Persist.Sql
import qualified Database.Persist.TH as PTH
import           Data.Text (Text)

PTH.share [PTH.mkPersist PTH.sqlSettings, PTH.mkMigrate "migrateAll"] [PTH.persistLowerCase|
  User sql=users
    name Text
    email Text
    age Int
    occupation Text
    UniqueEmail email
    deriving Show Read
|]

instance ToJSON  User where
  toJSON user = object [
    "name" .= userName user
    ,"email" .= userEmail user
    , "age" .= userAge user
    , "occupation" .= userOccupation user
    ]

instance FromJSON  User where
  parseJSON = withObject "User" parseUser


userPair :: User -> [Pair]
userPair user =
  ["name" .= userName user
  , "email" .= userEmail user
  , "age" .= userAge user
  , "occupation" .= userOccupation user
  ]

parseUser :: Object -> Parser User
parseUser o = do
  uName <- o .: "name"
  uEmail <- o .: "email"
  uAge <- o .: "age"
  uOccupation <- o .: "occupation"
  return User
    {userName = uName
    , userEmail = uEmail
    , userAge = uAge
    , userOccupation = uOccupation
    }
   
sampleUser:: Entity User
sampleUser = Entity (toSqlKey 1) $ User {
  userName = "admin"
  , userEmail = "admin@ame.com"
  , userAge = 23
  , userOccupation = "System Admin"
  }
