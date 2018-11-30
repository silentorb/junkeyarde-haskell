module Display where

import           Data.List
import           GameTypes
import           Simulation

display :: Character -> String
display character = "  " ++ name character

display :: Game -> String
display game =
  let enemies = enemies game
   in intercalate "\n" map display enemies
