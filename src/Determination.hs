{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE OverloadedStrings #-}

module Determination
    ( run
    ) where

import Control.Monad.Random
import           Control.Concurrent (threadDelay)
import           Control.Monad      (forM_, liftM)
import           Data.Monoid        ((<>))
import           Data.Text          (Text, pack, strip, unpack)
import qualified Data.Text          as T
import           System.IO
import           Turtle             hiding (stdout)

typewrite :: String -> IO ()
typewrite str = forM_ str (\c -> do
  putChar c
  waitSeconds 0.045)

waitSeconds :: RealFrac a => a -> IO ()
waitSeconds n = threadDelay (round (n * 1e6))

getCommand :: IO (Maybe Text)
getCommand = liftM (\case
  [] -> Nothing
  args -> Just (T.unwords args)) arguments

getUser :: IO Text
getUser = liftM
  (\case
    (ExitSuccess, user) -> (strip user)
    (ExitFailure _, _) -> "Frisk")
  (shellStrict "echo $USER" empty)

starters :: [String]
starters =
  [ "You cannot give up just yet..."
  , "It cannot end now!"
  , "Don't lose hope!"
  , "You're going to be alright!"
  , "Our fate rests on you..."
  ]

stayDetermined :: IO ()
stayDetermined = do
  user <- getUser
  starter <- uniform starters
  typewrite ("\n" <> starter <> "\n")
  waitSeconds 0.75
  typewrite (unpack (user <> "!\n"))
  waitSeconds 0.5
  typewrite "Stay determined...\n"

run :: IO ()
run = do
  hSetBuffering stdout NoBuffering
  getCommand >>= \case
    Nothing -> stayDetermined >> typewrite "...try providing a command...\n"
    Just cmd -> shell cmd empty >>= \case
      ExitSuccess -> return ()
      ExitFailure _ -> stayDetermined
