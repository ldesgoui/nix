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
    sha256 = "1q52vcawac3kdjc7rw9149igib38gamlha9na729k8dsay7ivw57";
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
