module Simulation where

import           Commands
import           Data
import           GameTypes

resource value = Resource value value

heroFaction = 0

enemyFaction :: Id
enemyFaction = 1

createPlayer id' = Character id' "Player" heroFaction (resource 10) (resource 10)

createEnemy id' = Character id' "Skeleton" enemyFaction (resource 10) (resource 10)

newGame nextId =
  let player = createPlayer nextId
   in (Game 1 [createPlayer nextId, createEnemy (nextId + 1)] nextId, nextId + 2)

sumBy accessor = foldl (\acc a -> acc + accessor a) 0

isFaction :: Id -> Character -> Bool
isFaction id' character = faction character == id'

enemies :: Game -> [Character]
enemies game = filter (isFaction enemyFaction) (characters game)

--applyAttacksToCharacter :: [Attack] -> Character -> Character
--applyAttacksToCharacter attacks character =
--  let applicableAttacks = filter (\a -> id' character) == target a attacks
--   in character {health = (health character) {value = (value (health character)) - sumBy (amount) applicableAttacks}}
update :: Game -> UserCommand -> Game
update game command = game {turn = turn game + 1}
