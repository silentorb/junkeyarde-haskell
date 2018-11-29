module Input where

import Data.Char
import Foreign.C.Types
import qualified Data.Map as Map
import Commands

getHiddenChar = fmap (chr.fromEnum) c_getch
foreign import ccall unsafe "conio.h getch"
  c_getch :: IO CInt

inputMap = Map.fromList [
    (97, CommandAttack), -- 'a'
    (113, CommandQuit) -- 'q'
  ]

invalidInput :: IO UserCommand
invalidInput = do
  putStrLn "Invalid Input"
  userInput

userInput :: IO UserCommand
userInput = do
  keyPress <- c_getch
  let command = Map.lookup keyPress inputMap
  case command of
    Just n -> return n
    Nothing -> invalidInput

