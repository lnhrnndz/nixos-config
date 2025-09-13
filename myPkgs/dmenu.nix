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
    rev = "v1.1";
    sha256 = "0khpvgsw1xrwc2rxw1lrrg62hi64haq2zbzgy55hg4d9flpldnr4";
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
