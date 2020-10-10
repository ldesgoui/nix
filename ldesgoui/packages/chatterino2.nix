{ stdenv
, pkgconfig
, fetchFromGitHub
, qtbase
, qtsvg
, qtmultimedia
, qmake
, boost
, openssl
, mkDerivation
}:

mkDerivation rec {
  pname = "chatterino2";
  version = "nightly";

  src = fetchFromGitHub {
    owner = "Chatterino";
    repo = pname;
    rev = "github-actions-nightly";
    sha256 = "0vs0sb0zcy0nd20ajz3zjh99nxzsazmi8f33dgm10362q4zxpl5z";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    qmake
    pkgconfig
  ];

  buildInputs = [
    qtbase
    qtsvg
    qtmultimedia
    boost
    openssl
  ];
}
