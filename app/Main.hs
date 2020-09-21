
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Logger (runStderrLoggingT)
import Database.Persist
import Database.Persist.Postgresql
import Database
import UserApi
import Schema


main :: IO ()
main = runStderrLoggingT $ withPostgresqlPool connString 10 $ \pool -> liftIO $ do
  flip runSqlPersistMPool pool $ do
    liftIO $ migrateDB connString
    -- runMigration migrateAll
    liftIO $ runServer' connString
