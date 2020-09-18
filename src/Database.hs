{-# LANGUAGE OverloadedStrings #-}

-- |

module Database where

import Data.Int (Int64)
import           Control.Monad.Logger (runStdoutLoggingT, MonadLogger, LoggingT)
import           Control.Monad.Reader (runReaderT)
import           Control.Monad.IO.Class (MonadIO)
import           Database.Persist (get, insert, delete, entityVal, Entity)
import           Database.Persist.Sql (fromSqlKey, toSqlKey)
import           Database.Persist.Postgresql (
  ConnectionString,
  withPostgresqlConn,
  runMigration,
  SqlPersistT)

import Schema

-- TODO make these environmnet varibables
connString :: ConnectionString
connString = "host=172.18.0.2 port=5432 user=q2io dbname=q2io password=password123"

fetchConnection ::  IO ConnectionString
fetchConnection = return connString
runAction :: ConnectionString -> SqlPersistT (LoggingT IO) a -> IO a
runAction  connectionString action = runStdoutLoggingT $
  withPostgresqlConn connectionString $
  \backend -> runReaderT action backend

migrateDB :: ConnectionString -> IO ()
migrateDB conn = runAction conn ( runMigration migrateAll )

createUser :: ConnectionString -> User -> IO Int64
createUser conn user = fromSqlKey <$> runAction conn (insert user)

fetchUser ::  ConnectionString -> Int64 -> IO (Maybe User)
fetchUser conn uid = runAction conn ( get ( toSqlKey uid ) )
