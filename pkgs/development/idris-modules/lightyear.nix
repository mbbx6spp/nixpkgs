{ build-idris-package
, fetchgit
, prelude
, base
, lib
, idris
, effects
}: build-idris-package {
  name = "lightyear";

  src = fetchgit {
    url = "git://github.com/ziman/lightyear";
    rev = "04e87473150a347db5a85ee706953bd0af28a305";
    sha256 = "196j0qkwb3m52kqnh4asmhn2w7pfdiqpz2kr68xffj8klghaqqzi";
  };

  propagatedBuildInputs = [ prelude base effects ];

  meta = {
    description = "Parser combinators for Idris";

    homepage = https://github.com/ziman/lightyear;

    license = lib.licenses.bsd2;

    inherit (idris.meta) platforms;
  };
}
