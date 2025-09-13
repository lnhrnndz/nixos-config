{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  fontconfig,
  freetype,
  libX11,
  libXft,
  ncurses,
}:

stdenv.mkDerivation {
  pname = "st";
  version = "custom";

  src = fetchFromGitHub {
    owner = "lnhrnndz";
    repo = "st";
    rev = "v1.0.0";
    sha256 = "1kbbgriwflb4j6sgj9pvlcnmqcs5wlf51f94xifld3s7xj8wj8is";
  };

  outputs = [
    "out"
    "terminfo"
  ];

  postPatch = ''
    # Fix function declaration order issue - add forward declaration
    sed -i '1i void xloadsparefonts(void);' x.c
  '';

  strictDeps = true;

  makeFlags = [
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
  ];

  nativeBuildInputs = [
    pkg-config
    ncurses
    fontconfig
    freetype
  ];

  buildInputs = [
    libX11
    libXft
  ];

  preInstall = ''
    export TERMINFO=$terminfo/share/terminfo
    mkdir -p $TERMINFO $out/nix-support
    echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
  '';

  installFlags = [ "PREFIX=$(out)" ];
}
