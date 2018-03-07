{ stdenv, bash, buildPerlPackage, fetchurl, fetchzip, fetchFromGitHub, makeWrapper, perl
, perlPackages, writeScript}:
let
  version = "1.2.4.2";
  pname = "dnsenum";

	StringRandom = stdenv.mkDerivation rec {
		name = "perl-String-Random-0.29";
		src = fetchzip {
      url = "mirror://cpan/authors/id/S/SH/SHLOMIF/${name}.tar.gz";
      sha256 = "1pwss4f12clixvi9v2rjggpwx26nwm0krrfx11flm3jn9447q103";
		};

    buildInputs = [ perl perlPackages.ModuleBuild ];
    outputs = [ "out" ];
    doCheck = true;
    checkTarget = "test";
    PERL_AUTOINSTALL = "--skipdeps";
    installTargets = "pure_install";
    AUTOMATED_TESTING = true;

    builder = writeScript "builder" ''
      source $stdenv/setup

      mkdir -p $out
      cp -r $src/* $out/
      cd $out

      ${perl}/bin/perl Build.PL --prefix $out --installdirs site --destdir $out
      $out/Build
      $out/Build test
      $out/Build install

			genericBuild

			if test -e $out/nix-support/propagated-build-inputs; then
				ln -s $out/nix-support/propagated-build-inputs $out/nix-support/propagated-user-env-packages
			fi
    '';
	};

	NetNetmask = buildPerlPackage rec {
		name = "Net-Netmask-1.9022";
		src = fetchurl {
			url = "mirror://cpan/authors/id/M/MU/MUIR/modules/${name}.tar.gz";
      sha256 = "0cqmlcxifh5phb3m6bi5pddv0f235vhjvcr0aipjwxfyyhgrq287";
		};
	};
in
stdenv.mkDerivation rec {
  inherit pname version;
  name = "${pname}-${version}";

  src = fetchFromGitHub {
		owner = "fwaeytens";
		repo = pname;
    rev = "e3336c51a6d43d1ebb292970958e9cdc0cf93419";
    sha256 = "1bg1ljv6klic13wq4r53bg6inhc74kqwm3w210865b1v1n8wj60v";
  };

  buildInputs = [ makeWrapper perl ];

  phases = [ "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/${pname}.pl $out/bin/${pname}
    chmod +x $out/bin/${pname}

    wrapProgram $out/bin/${pname} --set PERL5LIB \
      "${with perlPackages; stdenv.lib.makePerlPath ([
				NetNetmask NetDNS NetIP StringRandom ConfigStd NetCIDR TermANSIColor XMLWriter
      ])}"
  '';

  meta = with stdenv.lib; {
    description = "Enumerate DNS information of a domain";
    longDescription = ''
			Multithreaded perl script to enumerate DNS information of a domain and to
			discover non-contiguous ip blocks.
    '';
    license = licenses.gpl2;
    homepage = https://tools.kali.org/information-gathering/dnsenum;
    platforms = platforms.all;
    maintainers = [ maintainers.mbbx6spp ];
  };
}
