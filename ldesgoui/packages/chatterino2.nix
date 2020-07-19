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
    sha256 = "1b7g7lg9083q00mgg4vqhchrkjz5x7gbpfz4450ybmrpgmwb3z9l";
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
