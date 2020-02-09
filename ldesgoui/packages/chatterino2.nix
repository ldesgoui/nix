{ stdenv, pkgconfig, fetchFromGitHub, qtbase, qtsvg, qtmultimedia, qmake, boost, openssl, mkDerivation }:

mkDerivation rec {
  pname = "chatterino2";
  version = "nightly-build";

  src = fetchFromGitHub {
    owner = "Chatterino";
    repo = pname;
    sha256 = "00sldsf8g0z94qc27rp32l411247b4dpxm04qq1nwhsz2as4v59i";
    rev = version;
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
