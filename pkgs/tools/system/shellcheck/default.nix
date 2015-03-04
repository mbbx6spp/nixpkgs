{ haskellPackages ? (import <nixpkgs> {}).haskellPackages
, fetchurl ? (import <nixpkgs> {}).fetchurl
}:

let
  cabal = import (haskellPackages) cabal;
  json = import (haskellPackages) json;
  mtl = import (haskellPackages) mtl;
  parsec = import (haskellPackages) parsec;
  QuickCheck = import (haskellPackages) QuickCheck;
  regexCompat = import (haskellPackages) regexCompat;
  transformers = import (haskellPackages) transformers;
in
cabal.mkDerivation (self: {
  pname = "ShellCheck";
  version = "0.3.5";
  src = fetchurl {
    url     = "https://github.com/koalaman/shellcheck/archive/v0.3.5.tar.gz";
    sha256  = "e2907df9a28b955bde122c4ddf144c6039c0b85d";
  };
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    json mtl parsec QuickCheck regexCompat transformers
  ];
  testDepends = [
    json mtl parsec QuickCheck regexCompat transformers
  ];
  meta = {
    homepage    = "http://www.shellcheck.net/";
    description = "Shell script analysis tool";
    license     = self.stdenv.lib.licenses.agpl3;
    platforms   = self.ghc.meta.platforms;
  };
})
