{ fetchurl, fetchgit, linkFarm, runCommand, gnutar }: rec {
  offline_cache = linkFarm "offline" packages;
  packages = [
    {
      name = "_sec_ant_readable_stream___readable_stream_0.4.1.tgz";
      path = fetchurl {
        name = "_sec_ant_readable_stream___readable_stream_0.4.1.tgz";
        url  = "https://registry.yarnpkg.com/@sec-ant/readable-stream/-/readable-stream-0.4.1.tgz";
        sha512 = "831qok9r2t8AlxLko40y2ebgSDhenenCatLVeW/uBtnHPyhHOvG0C7TvfgecV+wHzIm5KUICgzmVpWS+IMEAeg==";
      };
    }
    {
      name = "_sindresorhus_merge_streams___merge_streams_4.0.0.tgz";
      path = fetchurl {
        name = "_sindresorhus_merge_streams___merge_streams_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/@sindresorhus/merge-streams/-/merge-streams-4.0.0.tgz";
        sha512 = "tlqY9xq5ukxTUZBmoOp+m61cqwQD5pHJtFY3Mn8CA8ps6yghLH/Hw8UPdqg4OLmFW3IFlcXnQNmo/dh8HzXYIQ==";
      };
    }
    {
      name = "abbrev___abbrev_4.0.0.tgz";
      path = fetchurl {
        name = "abbrev___abbrev_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/abbrev/-/abbrev-4.0.0.tgz";
        sha512 = "a1wflyaL0tHtJSmLSOVybYhy22vRih4eduhhrkcjgrWGnRfrZtovJ2FRjxuTtkkj47O/baf0R86QU5OuYpz8fA==";
      };
    }
    {
      name = "cross_spawn___cross_spawn_7.0.6.tgz";
      path = fetchurl {
        name = "cross_spawn___cross_spawn_7.0.6.tgz";
        url  = "https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-7.0.6.tgz";
        sha512 = "uV2QOWP2nWzsy2aMp8aRibhi9dlzF5Hgh5SHaB9OiTGEyDTiJJyx0uy51QXdyWbtAHNua4XJzUKca3OzKUd3vA==";
      };
    }
    {
      name = "env_paths___env_paths_4.0.0.tgz";
      path = fetchurl {
        name = "env_paths___env_paths_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/env-paths/-/env-paths-4.0.0.tgz";
        sha512 = "pxP8eL2SwwaTRi/KHYwLYXinDs7gL3jxFcBYmEdYfZmZXbaVDvdppd0XBU8qVz03rDfKZMXg1omHCbsJjZrMsw==";
      };
    }
    {
      name = "execa___execa_9.6.1.tgz";
      path = fetchurl {
        name = "execa___execa_9.6.1.tgz";
        url  = "https://registry.yarnpkg.com/execa/-/execa-9.6.1.tgz";
        sha512 = "9Be3ZoN4LmYR90tUoVu2te2BsbzHfhJyfEiAVfz7N5/zv+jduIfLrV2xdQXOHbaD6KgpGdO9PRPM1Y4Q9QkPkA==";
      };
    }
    {
      name = "figures___figures_6.1.0.tgz";
      path = fetchurl {
        name = "figures___figures_6.1.0.tgz";
        url  = "https://registry.yarnpkg.com/figures/-/figures-6.1.0.tgz";
        sha512 = "d+l3qxjSesT4V7v2fh+QnmFnUWv9lSpjarhShNTgBOfA0ttejbQUAlHLitbjkoRiDulW0OPoQPYIGhIC8ohejg==";
      };
    }
    {
      name = "get_stream___get_stream_9.0.1.tgz";
      path = fetchurl {
        name = "get_stream___get_stream_9.0.1.tgz";
        url  = "https://registry.yarnpkg.com/get-stream/-/get-stream-9.0.1.tgz";
        sha512 = "kVCxPF3vQM/N0B1PmoqVUqgHP+EeVjmZSQn+1oCRPxd2P21P2F19lIgbR3HBosbB1PUhOAoctJnfEn2GbN2eZA==";
      };
    }
    {
      name = "human_signals___human_signals_8.0.1.tgz";
      path = fetchurl {
        name = "human_signals___human_signals_8.0.1.tgz";
        url  = "https://registry.yarnpkg.com/human-signals/-/human-signals-8.0.1.tgz";
        sha512 = "eKCa6bwnJhvxj14kZk5NCPc6Hb6BdsU9DZcOnmQKSnO1VKrfV0zCvtttPZUsBvjmNDn8rpcJfpwSYnHBjc95MQ==";
      };
    }
    {
      name = "is_plain_obj___is_plain_obj_4.1.0.tgz";
      path = fetchurl {
        name = "is_plain_obj___is_plain_obj_4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-plain-obj/-/is-plain-obj-4.1.0.tgz";
        sha512 = "+Pgi+vMuUNkJyExiMBt5IlFoMyKnr5zhJ4Uspz58WOhBF5QoIZkFyNHIbBAtHwzVAgk5RtndVNsDRN61/mmDqg==";
      };
    }
    {
      name = "is_safe_filename___is_safe_filename_0.1.1.tgz";
      path = fetchurl {
        name = "is_safe_filename___is_safe_filename_0.1.1.tgz";
        url  = "https://registry.yarnpkg.com/is-safe-filename/-/is-safe-filename-0.1.1.tgz";
        sha512 = "4SrR7AdnY11LHfDKTZY1u6Ga3RuxZdl3YKWWShO5iyuG5h8QS4GD2tOb04peBJ5I7pXbR+CGBNEhTcwK+FzN3g==";
      };
    }
    {
      name = "is_stream___is_stream_4.0.1.tgz";
      path = fetchurl {
        name = "is_stream___is_stream_4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/is-stream/-/is-stream-4.0.1.tgz";
        sha512 = "Dnz92NInDqYckGEUJv689RbRiTSEHCQ7wOVeALbkOz999YpqT46yMRIGtSNl2iCL1waAZSx40+h59NV/EwzV/A==";
      };
    }
    {
      name = "is_unicode_supported___is_unicode_supported_2.1.0.tgz";
      path = fetchurl {
        name = "is_unicode_supported___is_unicode_supported_2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/is-unicode-supported/-/is-unicode-supported-2.1.0.tgz";
        sha512 = "mE00Gnza5EEB3Ds0HfMyllZzbBrmLOX3vfWoj9A9PEnTfratQ/BcaJOuMhnkhjXvb2+FkY3VuHqtAGpTPmglFQ==";
      };
    }
    {
      name = "isexe___isexe_2.0.0.tgz";
      path = fetchurl {
        name = "isexe___isexe_2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/isexe/-/isexe-2.0.0.tgz";
        sha512 = "RHxMLp9lnKHGHRng9QFhRCMbYAcVpn69smSGcq3f36xjgVVWThj4qqLbTLlq7Ssj8B+fIQ1EuCEGI2lKsyQeIw==";
      };
    }
    {
      name = "mkdirp___mkdirp_3.0.1.tgz";
      path = fetchurl {
        name = "mkdirp___mkdirp_3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/mkdirp/-/mkdirp-3.0.1.tgz";
        sha512 = "+NsyUUAZDmo6YVHzL/stxSu3t9YS1iljliy3BSDrXJ/dkn1KYdmtZODGGjLcc9XLgVVpH4KshHB8XmZgMhaBXg==";
      };
    }
    {
      name = "nopt___nopt_9.0.0.tgz";
      path = fetchurl {
        name = "nopt___nopt_9.0.0.tgz";
        url  = "https://registry.yarnpkg.com/nopt/-/nopt-9.0.0.tgz";
        sha512 = "Zhq3a+yFKrYwSBluL4H9XP3m3y5uvQkB/09CwDruCiRmR/UJYnn9W4R48ry0uGC70aeTPKLynBtscP9efFFcPw==";
      };
    }
    {
      name = "npm_run_path___npm_run_path_6.0.0.tgz";
      path = fetchurl {
        name = "npm_run_path___npm_run_path_6.0.0.tgz";
        url  = "https://registry.yarnpkg.com/npm-run-path/-/npm-run-path-6.0.0.tgz";
        sha512 = "9qny7Z9DsQU8Ou39ERsPU4OZQlSTP47ShQzuKZ6PRXpYLtIFgl/DEBYEXKlvcEa+9tHVcK8CF81Y2V72qaZhWA==";
      };
    }
    {
      name = "parse_ms___parse_ms_4.0.0.tgz";
      path = fetchurl {
        name = "parse_ms___parse_ms_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/parse-ms/-/parse-ms-4.0.0.tgz";
        sha512 = "TXfryirbmq34y8QBwgqCVLi+8oA3oWx2eAnSn62ITyEhEYaWRlVZ2DvMM9eZbMs/RfxPu/PK/aBLyGj4IrqMHw==";
      };
    }
    {
      name = "path_key___path_key_3.1.1.tgz";
      path = fetchurl {
        name = "path_key___path_key_3.1.1.tgz";
        url  = "https://registry.yarnpkg.com/path-key/-/path-key-3.1.1.tgz";
        sha512 = "ojmeN0qd+y0jszEtoY48r0Peq5dwMEkIlCOu6Q5f41lfkswXuKtYrhgoTpLnyIcHm24Uhqx+5Tqm2InSwLhE6Q==";
      };
    }
    {
      name = "path_key___path_key_4.0.0.tgz";
      path = fetchurl {
        name = "path_key___path_key_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/path-key/-/path-key-4.0.0.tgz";
        sha512 = "haREypq7xkM7ErfgIyA0z+Bj4AGKlMSdlQE2jvJo6huWD1EdkKYV+G/T4nq0YEF2vgTT8kqMFKo1uHn950r4SQ==";
      };
    }
    {
      name = "pretty_ms___pretty_ms_9.3.0.tgz";
      path = fetchurl {
        name = "pretty_ms___pretty_ms_9.3.0.tgz";
        url  = "https://registry.yarnpkg.com/pretty-ms/-/pretty-ms-9.3.0.tgz";
        sha512 = "gjVS5hOP+M3wMm5nmNOucbIrqudzs9v/57bWRHQWLYklXqoXKrVfYW2W9+glfGsqtPgpiz5WwyEEB+ksXIx3gQ==";
      };
    }
    {
      name = "shebang_command___shebang_command_2.0.0.tgz";
      path = fetchurl {
        name = "shebang_command___shebang_command_2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/shebang-command/-/shebang-command-2.0.0.tgz";
        sha512 = "kHxr2zZpYtdmrN1qDjrrX/Z1rR1kG8Dx+gkpK1G4eXmvXswmcE1hTWBWYUzlraYw1/yZp6YuDY77YtvbN0dmDA==";
      };
    }
    {
      name = "shebang_regex___shebang_regex_3.0.0.tgz";
      path = fetchurl {
        name = "shebang_regex___shebang_regex_3.0.0.tgz";
        url  = "https://registry.yarnpkg.com/shebang-regex/-/shebang-regex-3.0.0.tgz";
        sha512 = "7++dFhtcx3353uBaq8DDR4NuxBetBzC7ZQOhmTQInHEd6bSrXdiEyzCvG07Z44UYdLShWUyXt5M/yhz8ekcb1A==";
      };
    }
    {
      name = "signal_exit___signal_exit_4.1.0.tgz";
      path = fetchurl {
        name = "signal_exit___signal_exit_4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/signal-exit/-/signal-exit-4.1.0.tgz";
        sha512 = "bzyZ1e88w9O1iNJbKnOlvYTrWPDl46O1bG0D3XInv+9tkPrxrN8jUUTiFlDkkmKWgn1M6CfIA13SuGqOa9Korw==";
      };
    }
    {
      name = "smol_toml___smol_toml_1.6.0.tgz";
      path = fetchurl {
        name = "smol_toml___smol_toml_1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/smol-toml/-/smol-toml-1.6.0.tgz";
        sha512 = "4zemZi0HvTnYwLfrpk/CF9LOd9Lt87kAt50GnqhMpyF9U3poDAP2+iukq2bZsO/ufegbYehBkqINbsWxj4l4cw==";
      };
    }
    {
      name = "strip_final_newline___strip_final_newline_4.0.0.tgz";
      path = fetchurl {
        name = "strip_final_newline___strip_final_newline_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/strip-final-newline/-/strip-final-newline-4.0.0.tgz";
        sha512 = "aulFJcD6YK8V1G7iRB5tigAP4TsHBZZrOV8pjV++zdUwmeV8uzbY7yn6h9MswN62adStNZFuCIx4haBnRuMDaw==";
      };
    }
    {
      name = "unicorn_magic___unicorn_magic_0.3.0.tgz";
      path = fetchurl {
        name = "unicorn_magic___unicorn_magic_0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/unicorn-magic/-/unicorn-magic-0.3.0.tgz";
        sha512 = "+QBBXBCvifc56fsbuxZQ6Sic3wqqc3WWaqxs58gvJrcOuN83HGTCwz3oS5phzU9LthRNE9VrJCFCLUgHeeFnfA==";
      };
    }
    {
      name = "which___which_2.0.2.tgz";
      path = fetchurl {
        name = "which___which_2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/which/-/which-2.0.2.tgz";
        sha512 = "BLI3Tl1TW3Pvl70l3yq3Y64i+awpwXqsGBYWkkqMtnbXgrMD+yj7rhW0kuEDxzJaYXGjEW5ogapKNMEKNMjibA==";
      };
    }
    {
      name = "yoctocolors___yoctocolors_2.1.2.tgz";
      path = fetchurl {
        name = "yoctocolors___yoctocolors_2.1.2.tgz";
        url  = "https://registry.yarnpkg.com/yoctocolors/-/yoctocolors-2.1.2.tgz";
        sha512 = "CzhO+pFNo8ajLM2d2IW/R93ipy99LWjtwblvC1RsoSUMZgyLbYFr221TnSNT7GjGdYui6P459mw9JH/g/zW2ug==";
      };
    }
  ];
}
