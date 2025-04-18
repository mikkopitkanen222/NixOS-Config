# Import user configurations.
{ lib, ... }:
{
  imports = [
    ./modules
    ./mp
    ./wsl
  ];

  options.build = {
    userNames = lib.mkOption {
      description = "List of names of the user configurations to build.";
      type = lib.types.listOf (lib.types.enum [ ]);
      example = [
        "alice"
        "bob"
      ];
    };
  };
}
