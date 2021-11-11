+++
title = "Quick Start"
description = "A one page summary on how to integrate Openocd into your Bazel project."
date = 2021-05-01T08:20:00+00:00
updated = 2021-05-01T08:20:00+00:00
draft = false
weight = 20
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "A one page summary on how to integrate Openocd into your Bazel project."
toc = true
top = false
+++


## Setup 
Start by fetching the rules and deps via your WORKSPACE file.

```py
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_openocd",
    remote = "https://github.com/bazelembedded/rules_openocd.git",
    commit = "<TODO>",
)

load("@rules_openocd//:openocd_deps.bzl", "openocd_deps")

openocd_deps()
```

## Creating a flashing target 
Here we will be adding a target for flashing an elf file to a bare-metal 
target. 

```py 
load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@bazel_embedded//tools/openocd:defs.bzl", "openocd_debug_server", "openocd_flash")

# The target to flash
cc_binary(
    name = "main",
    srcs = ["main.cc"],
    # ...
)

# Run this target to upload to the microcontroller
openocd_flash(
    name = "main_flash",
    device_configs = [
        "target/stm32h7x_dual_bank.cfg",
    ],
    image = ":main.stripped",
    interface_configs = [
        "interface/stlink.cfg",
    ],
    transport = "hla_swd",
)
```