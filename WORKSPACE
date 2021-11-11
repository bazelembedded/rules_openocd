load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Setup documentation generation to markdown
# Used in modules: docs.
# Required by: rules_openocd.
http_archive(
    name = "io_bazel_stardoc",
    sha256 = "c9794dcc8026a30ff67cf7cf91ebe245ca294b20b071845d12c192afe243ad72",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/stardoc/releases/download/0.5.0/stardoc-0.5.0.tar.gz",
        "https://github.com/bazelbuild/stardoc/releases/download/0.5.0/stardoc-0.5.0.tar.gz",
    ],
)

load("@io_bazel_stardoc//:setup.bzl", "stardoc_repositories")

stardoc_repositories()

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Setup html site generation for docs site.
# Used in modules: docs.
# Required by: rules_openocd.
git_repository(
    name = "rules_zola",
    commit = "46ff45f56b7d0e7042ad3484cc551b5f97cd5adc",
    remote = "https://github.com/silvergasp/bazel_rules_zola.git",
    shallow_since = "1631871747 +0800",
)

load("@rules_zola//:zola_deps.bzl", "zola_deps")

zola_deps()

load("@rules_zola//zola:themes.bzl", "git_theme")

# Setup zola site theme.
# Used in modules: docs.
# Required by: rules_openocd.
git_theme(
    name = "com_github_aaranxu_adidoks",
    commit = "871a47d59ecb62e7c900111f04e155a5ddd3cb33",
    map_to = "adidoks",
    remote = "https://github.com/aaranxu/adidoks.git",
)
