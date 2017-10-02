

game_loop = do
  putStrLn "?"
  name <- getLine
  if name == "q"
  then putStrLn "Now leaving the JunkeYarde"
  else game_loop

main = do
  putStrLn "Welcome to the JunkeYarde"
  game_loop
