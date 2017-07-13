{ lib, python2Packages, fetchFromGitHub }:

python2Packages.buildPythonApplication rec {
  name = "cli53-${version}";
  version = "0.5.2-1";

  src = fetchFromGitHub {
    owner = "dailykos";
    repo = "cli53";
    rev = "e4b27cbe7eb76dbfbcee1a0e1ff71cedd8aa9d34";
    sha256 = "12nk12y2w1g8llq8ckr50abbbgs2m23hnb9fvpfi7k9dhfhmzxi4";
  };

  propagatedBuildInputs = with python2Packages; [
    boto
    dns
  ];

  meta = with lib; {
    description = "CLI tool for the Amazon Route 53 DNS service";
    homepage = https://github.com/barnybug/cli53;
    license = licenses.mit;
    maintainers = with maintainers; [ benley ];
  };
}
