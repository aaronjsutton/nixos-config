{ isWSL, inputs, ...}: 

{ config, lib, pkgs, ... }:

let
	isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    silver-searcher
    tree
    jq
    github-cli
		delta
    entr
		nodejs
		typescript
		terraform-ls
		awscli2
		jujutsu

		stylelint
		stylelint-lsp
  ];

  home.file = {
    ".gitconfig".source = dotfiles/gitconfig;
    ".gitignore".source = dotfiles/gitignore;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

	programs.jujutsu = {
		enable = true;
	};

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
		defaultCommand = "ag -l .";
		defaultOptions = [
			"--height 40%"
			"--color light"
			"--layout reverse"
		];
	};

  programs.home-manager.enable = true;

  xdg.enable = true;

	programs.git = {
		enable = true;
		lfs.enable = true;
	};

	programs.zoxide = {
		enable = true;
    enableZshIntegration = true;
	};

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    config = {
      global = {
        warn_timeout = "10s";
				strict_env = true;
				hide_env_diff = true;
      };
    };
  };

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
		plugins = with pkgs.vimPlugins; [
			rose-pine
			typescript-tools-nvim
			plenary-nvim
			nvim-lspconfig
			nvim-ufo
			(nvim-treesitter.withPlugins (
				plugins: with plugins; [
					css
					dockerfile
					elixir
					erlang
					html
					terraform
					javascript
					jsdoc
					json
					jsonc
					lua
					nix
					go
					python
					tsx
					typescript
					yaml
					toml
				]
			))
		];
	};

  programs.zsh = {
    enable = true;
		initExtra = builtins.readFile ./zshrc;

		plugins = [ ];
  };
}
