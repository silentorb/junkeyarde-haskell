module Commands where

data UserCommand =
  CommandQuit |
  CommandAttack
  deriving (Eq, Ord, Show, Read, Bounded, Enum)
