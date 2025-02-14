# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license

# This is an empty nixCats config.
# you may import this template directly into your nvim folder
# and then add plugins to categories here,
# and call the plugins with their default functions
# within your lua, rather than through the nvim package manager's method.
# Use the help, and the example config github:BirdeeHub/nixCats-nvim?dir=templates/example

# It allows for easy adoption of nix,
# while still providing all the extra nix features immediately.
# Configure in lua, check for a few categories, set a few settings,
# output packages with combinations of those categories and settings.

# All the same options you make here will be automatically exported in a form available
# in home manager and in nixosModules, as well as from other flakes.
# each section is tagged with its relevant help section.

{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  # see :help nixCats.flake.outputs
  outputs = { self, nixpkgs, nixCats, ... }@inputs: 
    let
    inherit (nixCats) utils;
    luaPath = "${./.}";
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
    dependencyOverlays = (utils.standardPluginOverlay inputs);
    categoryDefinitions = { pkgs, settings, categories, extra, name, mkNvimPlugin, ... }@packageDef: {
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          ripgrep
          fd
          lua-language-server
          nixd
          alejandra
        ];
        neonixdev = {
          inherit (pkgs) nix-doc nil lua-language-server nixd;
        };
      };

      # This is for plugins that will load at startup without using packadd:
      startupPlugins = {
        neonixdev = with pkgs.vimPlugins; [
          neodev-nvim
          neoconf-nvim
        ];
        lazy = with pkgs.vimPlugins; [
          lazy-nvim
        ];
        general = {
          vimPlugins = {
            tree-sitterAll = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
          };
          cmp = with pkgs.vimPlugins; [
            blink-cmp
            friendly-snippets
          ];
          git = with pkgs.vimPlugins; [
            gitsigns-nvim
          ];
          ui = with pkgs.vimPlugins; [
            fidget-nvim
            lualine-nvim
          ];
          beautify = with pkgs.vimPlugins; [
            nvim-autopairs
            nvim-web-devicons
            catppuccin-nvim
          ];
          general = with pkgs.vimPlugins; [
            which-key-nvim
            oil-nvim
          ];
        };
      };
    };
    packageDefinitions = {
      nixNvim = {pkgs , ... }: {
        settings = {
          wrapRc = false;
          aliases = [ "nv" "vi" ];
        categories = {
          general.vimPlugins = {
            tree-sitterAll = true;
            git = true;
            ui = true;
            beautify = true;
            cmp = true;
            general = true;
          };
          lspsAndRuntimeDeps = {
            general = true;
            neonixdev = true;
          };
        };
      };
    };
    };
    defaultPackageName = "nixNvim";
  in
  forEachSystem (system: let
    nixCatsBuilder = utils.baseBuilder luaPath {
      inherit nixpkgs system dependencyOverlays;
    } categoryDefinitions packageDefinitions;
    defaultPackage = nixCatsBuilder defaultPackageName;
    # this is just for using utils such as pkgs.mkShell
    # The one used to build neovim is resolved inside the builder
    # and is passed to our categoryDefinitions and packageDefinitions
    pkgs = import nixpkgs { inherit system; };
  in
  {
    # these outputs will be wrapped with ${system} by utils.eachSystem

    # this will make a package out of each of the packageDefinitions defined above
    # and set the default package to the one passed in here.
    packages = utils.mkAllWithDefault defaultPackage;

    # choose your package for devShell
    # and add whatever else you want in it.
    devShells = {
      default = pkgs.mkShell {
        name = defaultPackageName;
        packages = [ defaultPackageName ];
        inputsFrom = [ ];
        shellHook = ''
        '';
      };
    };

  }) // (let
    # we also export a nixos module to allow reconfiguration from configuration.nix
    nixosModule = utils.mkNixosModules {
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions nixpkgs;
    };
    # and the same for home manager
    homeModule = utils.mkHomeModules {
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions nixpkgs;
    };
  in {

    # these outputs will be NOT wrapped with ${system}

    # this will make an overlay out of each of the packageDefinitions defined above
    # and set the default overlay to the one named here.
    overlays = utils.makeOverlays luaPath {
      inherit nixpkgs dependencyOverlays ;
    } categoryDefinitions packageDefinitions defaultPackageName;

    nixosModules.default = nixosModule;
    homeModules.default = homeModule;

    inherit utils nixosModule homeModule;
    inherit (utils) templates;
  });

}
