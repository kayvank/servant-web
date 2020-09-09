
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import           Network.Wai.Handler.Warp
import           System.IO

import Lib

main :: IO ()
main = do
  let port = 3000
      settings =
        setPort port $
        setBeforeMainLoop (hPutStrLn stderr ( "Listening on port " ++ show port )) $
        defaultSettings
  runSettings settings =<<  mkApp
