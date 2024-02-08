# Pre-Commit-Hooks

Pre-commit-hooks is a project designed to enhance code quality and consistency by providing a collection of pre-commit hooks.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [C++ Configuration](#how-to-use-cpp-config)
  - [Python Configuration](#how-to-use-python-config)
- [Setting up and Executing the Pre-Commit-Hooks](#setting-up-and-executing-the-pre-commit-hooks)
- [Contributing](#contributing)

## Installation

To utilize the pre-commit hooks, you'll need to install specific applications locally, as detailed in the usage section below.

First, install `pre-commit` with the following command:

```sh
pip install pre-commit
```

## Usage

Once the pre-commit hooks are set up, they'll automatically execute with each commit, ensuring adherence to coding standards and detecting static analysis issues. If a hook identifies an error, the commit will be halted.

You can find a general project usage `.pre-commit-config.yaml` file located at the root of the repository, available for use if needed.

### How to use cpp-config

For C++ projects, you'll need to integrate these hooks into your project:

1. Copy the `.pre-commit-config.yaml` file from the `cpp-config` directory to your project root.
2. The `.pre-commit-config.yaml` file is preconfigured to utilize a personalized `.clang-format` file if there is one present in the root of the repository. Otherwise it will use the default Microsoft formatter. There is an example of a `.clang-format` file in the folder.


### How to use python-config

Work in progress.

## Setting up and Executing the Pre-Commit-Hooks

Once you've copied over the required files and installed the necessary applications, the next step is to configure your Git repository to utilize the pre-commit hooks. Follow these steps:

1. Move to your local directory using cd.

2. Run the command below to set up pre-commit in your **local** git repository:

```sh
pre-commit install
```

3. After installing pre-commit, it's advisable to run the following command:

```sh
pre-commit run --all-files
```

This command ensures that all hooks are executed for all files previously added to the repository.

To ensure that you have the latest versions of the hooks, you can periodically run the following command:

```sh
pre-commit autoupdate
```

This command updates the hooks to their latest versions, keeping your pre-commit setup current with any improvements or bug fixes.

## Contributing

Contributions are welcome. Please follow the existing coding standards and add pre-commit hooks for any new files.
