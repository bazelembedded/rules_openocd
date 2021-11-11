# Openocd Rules for Bazel
A set of Bazel rules for flashing bare-metal programs using 
[openocd](https://openocd.org/).

For a comprehensive introduction please read our [documentation]().

# Getting started
``` python
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_openocd",
    remote = "https://github.com/bazelembedded/rules_openocd.git",
    commit = "<TODO>",
)

load("@rules_openocd//:openocd_deps.bzl", "openocd_deps")

openocd_deps()
```