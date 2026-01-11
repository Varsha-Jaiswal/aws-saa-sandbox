`jq` is a command-line tool for processing JSON data like grep, awk, and sed. It helps in filtering, mapping and transforming the data. It useful because almost all output from AWS CLI commands are in JSON format by default.

---
Difference between `bash` and `sh`:

- **`sh` (Bourne Shell)**: This is the original, older Unix shell. It adheres to strict POSIX standards, making it very portable but limited in features.
- **`bash` (Bourne Again Shell)**: This is an updated, modern version of `sh`. It is a superset of `sh` (meaning it runs `sh` scripts) but includes many extra features like arrays, better conditional syntax, and command history.
  > **Note**: In many Linux systems, `/bin/sh` is actually a symbolic link to `dash` (a lighter shell), whereas `/bin/bash` is the full-featured shell you typically use interactively.
---
`#!/usr/bin/env bash` is a shebang line that tells the system to use the `bash` interpreter to run the script. This env is used to find the interpreter in the system's PATH and to maintain portability across different systems.