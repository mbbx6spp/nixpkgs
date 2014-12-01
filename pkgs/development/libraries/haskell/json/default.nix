# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, mtl, parsec, syb, text }:

cabal.mkDerivation (self: {
  pname = "json";
  version = "0.8";
  sha256 = "0ddwgp54drnv4d6jss1fp1khg0d463fz7lasx75fc0bxzjq6ln2w";
  buildDepends = [ mtl parsec syb text ];
  meta = {
    description = "Support for serialising Haskell to and from JSON";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
