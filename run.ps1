stack build
if ($LastExitCode -eq 0) {
  stack exec --no-system-ghc junk-exe
}
