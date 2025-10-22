{
  stdenv,
  fetchFromGitHub,
  xorg,
}:

stdenv.mkDerivation {
  pname = "dmenu";
  version = "custom";

  src = fetchFromGitHub {
    owner = "Lnhrnndz";
    repo = "dmenu";
    rev = "3f2b554d1564d1b7969254df3235e463ee65542a";
    sha256 = "1g7pml2j0w8ginad6yj46h9gm84lsyicz306i9407v4pl6221nzg";
  };

  buildInputs = [
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
  ];
  
  postPatch = 
    ''
      sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
      sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
    '';
  
  preConfigure = ''
    makeFlagsArray+=(
      PREFIX="$out"
      CC="$CC"
    )
  '';
}
