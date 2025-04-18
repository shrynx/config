let
  username = "shriyans";
in
{
  # User info
  inherit username;

  # System info
  hostname = "Shriyanss-MacBook-Pro";
  system = "aarch64-darwin";

  # Home directory
  homeDirectory = "/Users/${username}";
}
