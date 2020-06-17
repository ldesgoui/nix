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
    sha256 = "0z66pqv26mgp39jidydkkcfcghzfpwia1nnpa11n08bbsy5rc2q5";
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
