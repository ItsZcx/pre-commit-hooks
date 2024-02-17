# Pre-Commit-Hooks

Pre-commit-hooks is a project designed to enhance code quality and consistency by providing a collection of pre-commit hooks, those hooks can be run locally as well as with Docker.

## Table of Contents

- [Installation](#installation)
  - [Run via Docker](#run-via-docker)
  - [Run locally](#run-locally)
- [Usage](#usage)
  - [How to use cpp-config](#how-to-use-cpp-config)
  - [How to use python-config](#how-to-use-python-config)
  - [How to use haskell-config](#how-to-use-haskell-config)
- [Setting up and Executing the Pre-Commit-Hooks](#setting-up-and-executing-the-pre-commit-hooks)
  - [Executing Pre-Commit-Hooks with Docker](#executing-pre-commit-hooks-with-docker)
  - [Executing Pre-Commit-Hooks locally](#executing-pre-commit-hooks-locally)
- [Contributing](#contributing)

## Installation

There are two way to utilize the pre-commit hooks, locally, downloading necessary dependecies and with Docker, without downloading anything.

If you want to have the hooks run in every single commit, refere to running it locally, if you prefere to decide when the hooks will run, refere to running it via Docker.

For both options, you will have to copy some files/scripts present in this repository.

### Run via Docker

To run the pre-commit hooks via Docker, you only need to have `Docker` installed on your computer. Refer to the official Docker documentation for installation instructions.

You can execute the hooks using a provided script whenever you deem it appropriate.

### Run locally

To utilize the pre-commit hooks locally, you'll need to install `pre-commit` with the following command:

```sh
pip install pre-commit
```

## Usage

Once the pre-commit hooks are set up, they will only run on the **TRACKED FILES IN THE REPOSITORY**. If a hook detects an error locally, the commit process will be stopped.

A general project usage `.pre-commit-config.yaml` file is available at the root of the repository for reference and use if needed.

### How to use cpp-config

For C++ projects, you'll need to integrate these hooks into your project:
1. Copy the `.pre-commit-config.yaml` file from the `cpp-config` directory to your project root.

2. The `.pre-commit-config.yaml` file is preconfigured to utilize a personalized `.clang-format` file if there is one present in the root of the repository. Otherwise it will use the default Microsoft formatter. There is a `.clang-format` file in the folder.

#### How to use cpp-config with Docker or locally

Refer to this documentation if you want to run them with Docker
  - [Executing Pre-Commit-Hooks with Docker](#executing-pre-commit-hooks-with-docker)

Refer to this documentation if you want to run them locally
  - [Executing Pre-Commit-Hooks locally](#executing-pre-commit-hooks-locally)

### How to use python-config

For Python projects, you'll need to integrate these hooks into your project:
1. Copy the `.pre-commit-config.yaml` file from the `python-config` directory to your project root.

#### How to use python-config with Docker or locally

Refer to this documentation if you want to run them with Docker
  - [Executing Pre-Commit-Hooks with Docker](#executing-pre-commit-hooks-with-docker)

Refer to this documentation if you want to run them locally
  - [Executing Pre-Commit-Hooks locally](#executing-pre-commit-hooks-locally)

### How to use haskell-config

For Haskell projects, you'll need to integrate these hooks into your project:
1. Copy the `.pre-commit-config.yaml` file from the `haskell-config` directory to your project root.

2. Fourmolu is preconfigured to utilize a personalized `fourmolu.yaml` file if there is one present in the root of the repository. Otherwise it will use the default fourmolu formatting configuration. There is a `fourmolu.yaml` file in the folder in case you want one.

#### How to use haskell-config with Docker or locally

Refer to this documentation if you want to run them with Docker
  - [Executing Pre-Commit-Hooks with Docker](#executing-pre-commit-hooks-with-docker)

Refer to this documentation if you want to run them locally
  - [Executing Pre-Commit-Hooks locally](#executing-pre-commit-hooks-locally)

## Setting up and Executing the Pre-Commit-Hooks

### Executing Pre-Commit-Hooks with Docker

To use it with Docker, you will additionally need to copy the script `pre-commit.sh` into your root repository.

Whenever you wish to run the hooks, simply execute the script as follows:
```sh
./pre-commit.sh
```

The script will create a container with a published image, connected to your code via a volume, where the hooks will be executed. After execution, the script will display the output of the hooks and their status.

Please note that the script will create two temporary files, `.pre-commit-keeper.log` and `.pre-commit-output.log`. These files will be automatically deleted upon the completion of the script.

### Executing Pre-Commit-Hooks locally

Once you've copied over the required files, the next step is to configure your Git repository to utilize the pre-commit hooks locally. Follow these steps:

1. Run the command below to set up pre-commit in your **local** git repository:

```sh
pre-commit install
```

2. After installing pre-commit, it's advisable to run the following command:

```sh
pre-commit run --all-files
```

This command ensures that all hooks are executed for all files previously added to the repository. If there is any error about not finding a binary, you will probably have to locally install that necessary application with apt, stack, pip... etc.

To ensure that you have the latest versions of the hooks, you can periodically run the following command:

```sh
pre-commit autoupdate
```

This command updates the hooks to their latest versions, keeping your pre-commit setup current with any improvements or bug fixes.

## Contributing

Contributions are welcome. Please follow the existing coding standards and add pre-commit hooks for any new files.
