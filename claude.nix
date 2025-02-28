{
  config,
  pkgs,
  ...
}: let
  claude-code = pkgs.nodePackages.buildNodePackage {
    name = "claude-code";
    packageName = "claude-code";
    # version = "x.y.z"; # Replace with actual version
    src = pkgs.fetchFromGitHub {
      owner = "anthropics";
      repo = "claude-code";
      rev = "1a4e0f4d73562ab97b7f0ebe3fd514e2f992ad13";
      hash = "sha256-PZ9ONYZqfMAkPSR9cP42JI6ykSJ81zdjbhgHOr/RurM=";
    };
    # Add dependencies if needed
    meta = {
      description = "Claude Code CLI tool";
      homepage = "https://github.com/anthropics/claude-code"; # Replace with actual URL
    };
  };
in {
  home.packages = [
    claude-code
  ];
}
