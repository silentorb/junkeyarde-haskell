{-# LANGUAGE ForeignFunctionInterface #-}
import Data.Char
import Foreign.C.Types
import System.Process
getHiddenChar = fmap (chr.fromEnum) c_getch
foreign import ccall unsafe "conio.h getch"
  c_getch :: IO CInt

--clear :: IO ()
clear = system "cls"

data Game = Game {
  turn :: Int
} deriving (Show)

game_loop = do
  clear
  putStrLn "The JunkeYarde"
  putStrLn "?"
  command <- c_getch
  if command == 113
  then putStrLn "Now leaving the JunkeYarde"
  else game_loop

main = do
  putStrLn "Welcome to the JunkeYarde"
  game_loop
