{-# LANGUAGE LambdaCase #-}
module Lib ( demo ) where

import Control.Monad              ( forever, when )
import Control.Monad.Loops        ( untilM )
import Control.Monad.Trans.Class  ( lift )
import Control.Monad.Trans.Either ( EitherT, runEitherT, left )
import Data.Char                  ( toLower )

import Player                     ( Player( Player1, Player2 ) )
import Game

demo :: IO ()
demo = do
  putStrLn "Tennis, anyone?"
  blankLine
  playGame `untilM` (not <$> playAgain)
  blankLine
  putStrLn "Have a nice day."

playGame :: IO ()
playGame = do
  blankLine
  putStrLn $ "New Game!"
  blankLine
  Game.execute Game.new
  blankLine

askYN :: String -> IO Bool
askYN prompt = do
  putStr prompt
  response <- clamp . map toLower <$> getLine
  maybe (askYN prompt) return response
  where
    clamp s =
        case s of
          "y"    -> Just True
          "yes"  -> Just True
          "yep"  -> Just True
          "n"    -> Just False
          "no"   -> Just False
          "nope" -> Just False
          _      -> Nothing

playAgain :: IO Bool
playAgain = askYN "Would you like to play again? "

exit :: Monad m => EitherT () m a
exit = left ()

blankLine :: IO ()
blankLine = putStrLn ""
