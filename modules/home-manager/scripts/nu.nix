{
  pkgs,
  config,
  ...
}:
let
  standalone = pkgs.writeShellScriptBin "nu" ''
    cleanup() { 
      echo "Update failed to build changes reverted"

      git -C /etc/nixos checkout -- flake.lock
      exit 1
    }

    trap cleanup INT
    nh home switch -b backup -u
    git -C /etc/nixos pull --rebase --autostash 

    if [ $? -eq 0 ]; then

      COMMIT_DATE=$(date +%Y%m%d)

      trap - INT
      git -C /etc/nixos add flake.lock
      git -C /etc/nixos commit -m "$COMMIT_DATE" --only flake.lock
      git -C /etc/nixos push

    else

      trap - INT
      cleanup
      
    fi
  '';

  module = pkgs.writeShellScriptBin "nu" ''
    cleanup() { 
      echo "Update failed to build changes reverted"

      git -C /etc/nixos checkout -- flake.lock
      exit 1
    }

    trap cleanup INT

    git -C /etc/nixos pull --rebase --autostash 
    nh os switch -u
    if [ $? -eq 0 ]; then

      COMMIT_DATE=$(date +%Y%m%d)

      trap - INT
      git -C /etc/nixos add flake.lock
      git -C /etc/nixos commit -m "$COMMIT_DATE" --only flake.lock
      git -C /etc/nixos push

    else

      trap - INT
      cleanup
      
    fi
  '';

  nu = if config.hmIsModule then module else standalone;
in
{
  home.packages = [ nu ];
}
