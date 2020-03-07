{ stdenv, pkgconfig, fetchFromGitHub, qtbase, qtsvg, qtmultimedia, qmake, boost, openssl, mkDerivation }:

mkDerivation rec {
  pname = "chatterino2";
  version = "nightly";

  src = fetchFromGitHub {
    owner = "Chatterino";
    repo = pname;
    rev = "github-actions-nightly";
    sha256 = "01qa57168shrpnwn8n07zdz1pyv6i9b7hqdi2bbvqv3kwigi5nrc";
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
