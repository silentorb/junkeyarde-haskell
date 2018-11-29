{-# LANGUAGE ForeignFunctionInterface #-}
import Data.Char
import Foreign.C.Types
import System.Process
import qualified Data.Map as Map
import Input
import Simulation
import Commands

clear = system "cls"

data AppMode =
  AppActive |
  AppQuit
  deriving (Eq, Ord, Show, Read, Bounded, Enum)

gameLoop game nextId = do
  clear
  putStrLn "The JunkeYarde"
  putStrLn ("Turn " ++ (show (turn game)))
  putStrLn "?"
  command <- userInput
  if command == CommandQuit
  then return ()
  else gameLoop (updateGame game command) nextId

main = do
  putStrLn "Welcome to the JunkeYarde"
  let (game, nextId) = newGame 1
  gameLoop game nextId
  putStrLn "Now leaving the JunkeYarde"
