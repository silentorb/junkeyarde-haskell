cd src
ghc -outputdir ../bin -o ../bin/junk Main
if ($LastExitCode -eq 0) {
  ../bin/junk
}

cd ..