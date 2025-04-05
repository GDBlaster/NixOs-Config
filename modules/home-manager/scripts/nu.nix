{
  pkgs,
  config,
  ...
}:
let
  standalone = pkgs.writeShellScriptBin "nu" ''
    git -C ~/nixos pull
    nh home switch -c $HOSTNAME -b backup -u

    if [ $? -eq 0 ]; then
      COMMIT_DATE=$(date +%Y%m%d)

      git -C ~/nixos add flake.lock
      git -C ~/nixos commit -m "$COMMIT_DATE" --only flake.lock
      git -C ~/nixos push
    else
      echo "Update failed to build changes reverted"

      git -C ~/nixos checkout -- flake.lock
      exit 1
    fi
  '';

  module = pkgs.writeShellScriptBin "nu" ''
    git -C /etc/nixos pull
    nh os switch -u
    if [ $? -eq 0 ]; then

      COMMIT_DATE=$(date +%Y%m%d)
    
      git -C /etc/nixos add flake.lock
      git -C /etc/nixos commit -m "$COMMIT_DATE" --only flake.lock
      git -C /etc/nixos push
    else
      echo "Update failed to build changes reverted"

      git -C /etc/nixos checkout -- flake.lock
      exit 1
    fi
  '';

  nu = if config.hmIsModule then module else standalone;
in
{
  home.packages = [ nu ];
}
