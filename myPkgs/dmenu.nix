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
    rev = "v1.1.1";
    sha256 = "0fhhfvkfk2r0yq8nfqk3m80m2s4sj6xvw9hr3fjbpbsqb5v3ra2w";
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
