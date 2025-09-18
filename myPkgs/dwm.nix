{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  fontconfig,
  freetype,
  libX11,
  libXft,
  libXinerama,
}:

stdenv.mkDerivation {
  pname = "dwm";
  version = "custom";

  src = fetchFromGitHub {
    owner = "lnhrnndz";
    repo = "dwm";
    rev = "v1.0.0";
    sha256 = "0q91h6q7hxlsdy9lglb56f474nfh177ffd0z7l82w05pnwp5zklq";
  };

  buildInputs = [
    libX11
    libXft
    libXinerama
  ];

  #postPatch = ''
  #  # Fix function declaration order issue - add forward declaration
  #  sed -i '1i void xloadsparefonts(void);' x.c
  #'';

  #strictDeps = true;

  preBuild = ''
    makeFlagsArray+=(
      "PREFIX=$out"
      "CC=$CC"
      ${lib.optionalString stdenv.hostPlatform.isStatic ''
        LDFLAGS="$(${stdenv.cc.targetPrefix}pkg-config --static --libs x11 xinerama xft)"
      ''}
    )
  '';

  #makeFlags = [
  #  "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
  #];

  #preConfigure = ''
  #  makeFlagsArray+=(
  #    PREFIX="$out"
  #    CC="$CC"
  #  )
  #'';
}
