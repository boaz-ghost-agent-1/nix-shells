# Nix Development Shells

![](assets/nix-shells.png)

A collection of reusable Nix development environments that I use on NixOS.

The goal of this repository is to keep my development shells in one place,
making it easy to start a project with the tools I need without installing
development dependencies globally.

## Structure

```text
.
├── core/
│   └── shell.nix
├── go/
│   └── shell.nix
├── pi/
│   └── shell.nix
├── Makefile
├── README.md
└── shell.nix
```

Each directory contains a development shell for a particular language,
toolchain, or use case.

The root `shell.nix` is used to maintain this repository itself and provides
the formatting and linting tools used by the `Makefile`.

## Available Shells

### Core

General-purpose development environment containing commonly used tools such
as git, neovim, jq, fastfetch, and lolcat.

```bash
nix-shell core/shell.nix
```

### Go

Go development environment containing the Go toolchain, `gopls`, and
additional Go tools.

```bash
nix-shell go/shell.nix
```

The shell also creates project-local Go directories for development caches
and installed binaries.

### Pi

Node.js environment for running the Pi coding agent.

```bash
nix-shell pi/shell.nix
```

The environment keeps globally installed npm packages local to the project
instead of installing them into the system.

## Usage

Clone the repository:

```bash
git clone <repository-url>
cd <repository-name>
```

Enter a development shell directly:

```bash
nix-shell go/shell.nix
```

Or enter its directory first:

```bash
cd go
nix-shell
```

## Using a Shell in Another Project

Copy the desired `shell.nix` into your project:

```bash
cp /path/to/nix-shells/go/shell.nix ~/projects/my-project/shell.nix
cd ~/projects/my-project
nix-shell
```

The project then has its own development environment that can be modified
independently.

## Repository Development

The root `shell.nix` provides all tools required to maintain the Nix files in
this repository.

Enter the development environment:

```bash
nix-shell
```

### Formatting

Format all Nix files and clean whitespace:

```bash
make fmt
```

`make fmt`:

- normalizes excessive indentation
- removes trailing whitespace
- formats Nix code with `nixfmt`

### Checking

Run all checks:

```bash
make check
```

Or run them individually:

```bash
make fmt-check
make lint
make deadnix
make whitespace
```

The repository uses:

- `nixfmt` — Nix code formatting
- `statix` — Nix linting and anti-pattern detection
- `deadnix` — detection of unused Nix code
- `git diff --check` — whitespace error detection

Run:

```bash
make help
```

to see all available Makefile targets.

## Development Workflow

A typical workflow when changing or adding a development shell is:

```bash
nix-shell

# Make changes...

make fmt
make check

git diff
git add .
git commit
```

Before committing, `make check` should complete without errors.

## Adding a New Shell

Create a directory for the new environment:

```text
rust/
└── shell.nix
```

A minimal shell looks like:

```nix
{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = with pkgs; [
    # Development tools go here
  ];

  shellHook = ''
    echo "Development shell ready!"
  '';
}
```

Then verify it:

```bash
nix-shell rust/shell.nix
```

and format/check the repository:

```bash
make fmt
make check
```

## Why Development Shells?

On NixOS, I prefer keeping development dependencies out of the global system
configuration whenever possible.

Development shells provide:

- isolated development environments
- reproducible toolchains
- fewer globally installed packages
- easy switching between development stacks
- reusable starting points for new projects

Instead of remembering which packages are required whenever I start a new
project, I can reuse one of the environments from this repository.

## Notes

These shells are primarily maintained for my own development workflow on
NixOS.

They may also work on other systems running Nix, but compatibility outside my
setup is not guaranteed.

Feel free to use, modify, or adapt them for your own projects.
