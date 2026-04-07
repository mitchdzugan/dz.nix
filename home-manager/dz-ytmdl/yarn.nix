{ fetchurl, fetchgit, linkFarm, runCommand, gnutar }: rec {
  offline_cache = linkFarm "offline" packages;
  packages = [
    {
      name = "_borewit_text_codec___text_codec_0.2.2.tgz";
      path = fetchurl {
        name = "_borewit_text_codec___text_codec_0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/@borewit/text-codec/-/text-codec-0.2.2.tgz";
        sha512 = "DDaRehssg1aNrH4+2hnj1B7vnUGEjU6OIlyRdkMd0aUdIUvKXrJfXsy8LVtXAy7DRvYVluWbMspsRhz2lcW0mQ==";
      };
    }
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
      name = "_tokenizer_inflate___inflate_0.4.1.tgz";
      path = fetchurl {
        name = "_tokenizer_inflate___inflate_0.4.1.tgz";
        url  = "https://registry.yarnpkg.com/@tokenizer/inflate/-/inflate-0.4.1.tgz";
        sha512 = "2mAv+8pkG6GIZiF1kNg1jAjh27IDxEPKwdGul3snfztFerfPGI1LjDezZp3i7BElXompqEtPmoPx6c2wgtWsOA==";
      };
    }
    {
      name = "_tokenizer_token___token_0.3.0.tgz";
      path = fetchurl {
        name = "_tokenizer_token___token_0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/@tokenizer/token/-/token-0.3.0.tgz";
        sha512 = "OvjF+z51L3ov0OyAU0duzsYuvO01PH7x4t6DJx+guahgTnBHkhJdG7soQeTSFLWN3efnHyibZ4Z8l2EuWwJN3A==";
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
      name = "balanced_match___balanced_match_4.0.4.tgz";
      path = fetchurl {
        name = "balanced_match___balanced_match_4.0.4.tgz";
        url  = "https://registry.yarnpkg.com/balanced-match/-/balanced-match-4.0.4.tgz";
        sha512 = "BLrgEcRTwX2o6gGxGOCNyMvGSp35YofuYzw9h1IMTRmKqttAZZVU67bdb9Pr2vUHA8+j3i2tJfjO6C6+4myGTA==";
      };
    }
    {
      name = "base64_js___base64_js_0.0.2.tgz";
      path = fetchurl {
        name = "base64_js___base64_js_0.0.2.tgz";
        url  = "https://registry.yarnpkg.com/base64-js/-/base64-js-0.0.2.tgz";
        sha512 = "Pj9L87dCdGcKlSqPVUjD+q96pbIx1zQQLb2CUiWURfjiBELv84YX+0nGnKmyT/9KkC7PQk7UN1w+Al8bBozaxQ==";
      };
    }
    {
      name = "bops___bops_0.0.6.tgz";
      path = fetchurl {
        name = "bops___bops_0.0.6.tgz";
        url  = "https://registry.yarnpkg.com/bops/-/bops-0.0.6.tgz";
        sha512 = "EWD8/Ei9o/h/wmR3w/YL/8dGKe4rSFHlaO8VNNcuXnjXjeTgxdcmhjPf9hRCYlqTrBPZbKaht+FxZKahcob5UQ==";
      };
    }
    {
      name = "brace_expansion___brace_expansion_5.0.5.tgz";
      path = fetchurl {
        name = "brace_expansion___brace_expansion_5.0.5.tgz";
        url  = "https://registry.yarnpkg.com/brace-expansion/-/brace-expansion-5.0.5.tgz";
        sha512 = "VZznLgtwhn+Mact9tfiwx64fA9erHH/MCXEUfB/0bX/6Fz6ny5EGTXYltMocqg4xFAQZtnO3DHWWXi8RiuN7cQ==";
      };
    }
    {
      name = "concat_stream___concat_stream_1.0.1.tgz";
      path = fetchurl {
        name = "concat_stream___concat_stream_1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/concat-stream/-/concat-stream-1.0.1.tgz";
        sha512 = "nAHFsgeRVVvZ+aB3S1gLeN73fQ+tdOcw075BHbXMbC6MY0h6nqAkEeqPVCw8kRuDJJZDvaUjxI4jZv2FD0Tl8A==";
      };
    }
    {
      name = "content_type___content_type_1.0.5.tgz";
      path = fetchurl {
        name = "content_type___content_type_1.0.5.tgz";
        url  = "https://registry.yarnpkg.com/content-type/-/content-type-1.0.5.tgz";
        sha512 = "nTjqfcBFEipKdXCv4YDQWCfmcLZKm81ldF0pAopTvyrFGVbcR6P/VAAd5G7N+0tTr8QqiU0tFadD6FK4NtJwOA==";
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
      name = "debug___debug_4.4.3.tgz";
      path = fetchurl {
        name = "debug___debug_4.4.3.tgz";
        url  = "https://registry.yarnpkg.com/debug/-/debug-4.4.3.tgz";
        sha512 = "RGwwWnwQvkVfavKVt22FGLw+xYSdzARwm0ru6DhTVA3umU5hZc28V3kO4stgYryrTlLpuvgI9GiijltAjNbcqA==";
      };
    }
    {
      name = "duplexer___duplexer_0.0.4.tgz";
      path = fetchurl {
        name = "duplexer___duplexer_0.0.4.tgz";
        url  = "https://registry.yarnpkg.com/duplexer/-/duplexer-0.0.4.tgz";
        sha512 = "nO0WWuIDTde3CWK/8IPpG50dyhUilgpsqzYSIP+w20Yh+4iDgb/2Gs75QItcp0Hmx/JtxtTXBalj+LSTD1VemA==";
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
      name = "ffmetadata___ffmetadata_1.7.0.tgz";
      path = fetchurl {
        name = "ffmetadata___ffmetadata_1.7.0.tgz";
        url  = "https://registry.yarnpkg.com/ffmetadata/-/ffmetadata-1.7.0.tgz";
        sha512 = "9qiv40lskKAz63qJKemVxmfH3Xkp3TuXK7teQOxh69kSJDxkBu1Mzr93bSKL9fyqqZ4uo6hnZfCHb/40AEF8+A==";
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
      name = "file_type___file_type_21.3.4.tgz";
      path = fetchurl {
        name = "file_type___file_type_21.3.4.tgz";
        url  = "https://registry.yarnpkg.com/file-type/-/file-type-21.3.4.tgz";
        sha512 = "Ievi/yy8DS3ygGvT47PjSfdFoX+2isQueoYP1cntFW1JLYAuS4GD7NUPGg4zv2iZfV52uDyk5w5Z0TdpRS6Q1g==";
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
      name = "glob___glob_13.0.6.tgz";
      path = fetchurl {
        name = "glob___glob_13.0.6.tgz";
        url  = "https://registry.yarnpkg.com/glob/-/glob-13.0.6.tgz";
        sha512 = "Wjlyrolmm8uDpm/ogGyXZXb1Z+Ca2B8NbJwqBVg0axK9GbBeoS7yGV6vjXnYdGm6X53iehEuxxbyiKp8QmN4Vw==";
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
      name = "ieee754___ieee754_1.2.1.tgz";
      path = fetchurl {
        name = "ieee754___ieee754_1.2.1.tgz";
        url  = "https://registry.yarnpkg.com/ieee754/-/ieee754-1.2.1.tgz";
        sha512 = "dcyqhDvX1C46lXZcVqCpK+FtMRQVdIMN6/Df5js2zouUsqG7I6sFxitIC+7KYK29KdXOLHdu9zL4sFnoVQnqaA==";
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
      name = "lru_cache___lru_cache_11.2.7.tgz";
      path = fetchurl {
        name = "lru_cache___lru_cache_11.2.7.tgz";
        url  = "https://registry.yarnpkg.com/lru-cache/-/lru-cache-11.2.7.tgz";
        sha512 = "aY/R+aEsRelme17KGQa/1ZSIpLpNYYrhcrepKTZgE+W3WM16YMCaPwOHLHsmopZHELU0Ojin1lPVxKR0MihncA==";
      };
    }
    {
      name = "media_typer___media_typer_1.1.0.tgz";
      path = fetchurl {
        name = "media_typer___media_typer_1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/media-typer/-/media-typer-1.1.0.tgz";
        sha512 = "aisnrDP4GNe06UcKFnV5bfMNPBUw4jsLGaWwWfnH3v02GnBuXX2MCVn5RbrWo0j3pczUilYblq7fQ7Nw2t5XKw==";
      };
    }
    {
      name = "minimatch___minimatch_10.2.5.tgz";
      path = fetchurl {
        name = "minimatch___minimatch_10.2.5.tgz";
        url  = "https://registry.yarnpkg.com/minimatch/-/minimatch-10.2.5.tgz";
        sha512 = "MULkVLfKGYDFYejP07QOurDLLQpcjk7Fw+7jXS2R2czRQzR56yHRveU5NDJEOviH+hETZKSkIk5c+T23GjFUMg==";
      };
    }
    {
      name = "minipass___minipass_7.1.3.tgz";
      path = fetchurl {
        name = "minipass___minipass_7.1.3.tgz";
        url  = "https://registry.yarnpkg.com/minipass/-/minipass-7.1.3.tgz";
        sha512 = "tEBHqDnIoM/1rXME1zgka9g6Q2lcoCkxHLuc7ODJ5BxbP5d4c2Z5cGgtXAku59200Cx7diuHTOYfSBD8n6mm8A==";
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
      name = "ms___ms_2.1.3.tgz";
      path = fetchurl {
        name = "ms___ms_2.1.3.tgz";
        url  = "https://registry.yarnpkg.com/ms/-/ms-2.1.3.tgz";
        sha512 = "6FlzubTLZG3J2a/NVCAleEhjzq5oxgHyaCU9yYXvcLsvoVaHJq/s5xXI6/XXP6tz7R9xAOtHnSO/tXtF3WRTlA==";
      };
    }
    {
      name = "music_metadata___music_metadata_11.12.3.tgz";
      path = fetchurl {
        name = "music_metadata___music_metadata_11.12.3.tgz";
        url  = "https://registry.yarnpkg.com/music-metadata/-/music-metadata-11.12.3.tgz";
        sha512 = "n6hSTZkuD59qWgHh6IP5dtDlDZQXoxk/bcA85Jywg8Z1iFrlNgl2+GTFgjZyn52W5UgQpV42V4XqrQZZAMbZTQ==";
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
      name = "package_json_from_dist___package_json_from_dist_1.0.1.tgz";
      path = fetchurl {
        name = "package_json_from_dist___package_json_from_dist_1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/package-json-from-dist/-/package-json-from-dist-1.0.1.tgz";
        sha512 = "UEZIS3/by4OC8vL3P2dTXRETpebLI2NiI5vIrjaD/5UtrkFX/tNbwjTSRAGC/+7CAo2pIcBaRgWmcBBHcsaCIw==";
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
      name = "path_scurry___path_scurry_2.0.2.tgz";
      path = fetchurl {
        name = "path_scurry___path_scurry_2.0.2.tgz";
        url  = "https://registry.yarnpkg.com/path-scurry/-/path-scurry-2.0.2.tgz";
        sha512 = "3O/iVVsJAPsOnpwWIeD+d6z/7PmqApyQePUtCndjatj/9I5LylHvt5qluFaBT3I5h3r1ejfR056c+FCv+NnNXg==";
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
      name = "rimraf___rimraf_6.1.3.tgz";
      path = fetchurl {
        name = "rimraf___rimraf_6.1.3.tgz";
        url  = "https://registry.yarnpkg.com/rimraf/-/rimraf-6.1.3.tgz";
        sha512 = "LKg+Cr2ZF61fkcaK1UdkH2yEBBKnYjTyWzTJT6KNPcSPaiT7HSdhtMXQuN5wkTX0Xu72KQ1l8S42rlmexS2hSA==";
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
      name = "split___split_0.2.10.tgz";
      path = fetchurl {
        name = "split___split_0.2.10.tgz";
        url  = "https://registry.yarnpkg.com/split/-/split-0.2.10.tgz";
        sha512 = "e0pKq+UUH2Xq/sXbYpZBZc3BawsfDZ7dgv+JtRTUPNcvF5CMR4Y9cvJqkMY0MoxWzTHvZuz1beg6pNEKlszPiQ==";
      };
    }
    {
      name = "stream_combiner___stream_combiner_0.0.2.tgz";
      path = fetchurl {
        name = "stream_combiner___stream_combiner_0.0.2.tgz";
        url  = "https://registry.yarnpkg.com/stream-combiner/-/stream-combiner-0.0.2.tgz";
        sha512 = "Z2D5hPQapscuHNqiyUgjnF1sxG/9CB7gs1a9vcS2/OvMiFwmm6EZw9IjbU34l5mPXS62RidpoBdyB83E0GXHLw==";
      };
    }
    {
      name = "stream_filter___stream_filter_1.0.0.tgz";
      path = fetchurl {
        name = "stream_filter___stream_filter_1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/stream-filter/-/stream-filter-1.0.0.tgz";
        sha512 = "FnB+RV/hfX5nU758FY1ImWwmbHRCiqTdZHMlLfnEz/rR8S1HPvt7LzcZh/poqVBvn3cgoiUTmsAipb8oN+EbFA==";
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
      name = "strtok3___strtok3_10.3.5.tgz";
      path = fetchurl {
        name = "strtok3___strtok3_10.3.5.tgz";
        url  = "https://registry.yarnpkg.com/strtok3/-/strtok3-10.3.5.tgz";
        sha512 = "ki4hZQfh5rX0QDLLkOCj+h+CVNkqmp/CMf8v8kZpkNVK6jGQooMytqzLZYUVYIZcFZ6yDB70EfD8POcFXiF5oA==";
      };
    }
    {
      name = "through___through_2.3.8.tgz";
      path = fetchurl {
        name = "through___through_2.3.8.tgz";
        url  = "https://registry.yarnpkg.com/through/-/through-2.3.8.tgz";
        sha512 = "w89qg7PI8wAdvX60bMDP+bFoD5Dvhm9oLheFp5O4a2QF0cSBGsBX4qZmadPMvVqlLJBBci+WqGGOAPvcDeNSVg==";
      };
    }
    {
      name = "to_utf8___to_utf8_0.0.1.tgz";
      path = fetchurl {
        name = "to_utf8___to_utf8_0.0.1.tgz";
        url  = "https://registry.yarnpkg.com/to-utf8/-/to-utf8-0.0.1.tgz";
        sha512 = "zks18/TWT1iHO3v0vFp5qLKOG27m67ycq/Y7a7cTiRuUNlc4gf3HGnkRgMv0NyhnfTamtkYBJl+YeD1/j07gBQ==";
      };
    }
    {
      name = "token_types___token_types_6.1.2.tgz";
      path = fetchurl {
        name = "token_types___token_types_6.1.2.tgz";
        url  = "https://registry.yarnpkg.com/token-types/-/token-types-6.1.2.tgz";
        sha512 = "dRXchy+C0IgK8WPC6xvCHFRIWYUbqqdEIKPaKo/AcTUNzwLTK6AH7RjdLWsEZcAN/TBdtfUw3PYEgPr5VPr6ww==";
      };
    }
    {
      name = "uint8array_extras___uint8array_extras_1.5.0.tgz";
      path = fetchurl {
        name = "uint8array_extras___uint8array_extras_1.5.0.tgz";
        url  = "https://registry.yarnpkg.com/uint8array-extras/-/uint8array-extras-1.5.0.tgz";
        sha512 = "rvKSBiC5zqCCiDZ9kAOszZcDvdAHwwIKJG33Ykj43OKcWsnmcBRL09YTU4nOeHZ8Y2a7l1MgTd08SBe9A8Qj6A==";
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
      name = "win_guid___win_guid_0.2.1.tgz";
      path = fetchurl {
        name = "win_guid___win_guid_0.2.1.tgz";
        url  = "https://registry.yarnpkg.com/win-guid/-/win-guid-0.2.1.tgz";
        sha512 = "gEIQU4mkgl2OPeoNrWflcJFJ3Ae2BPd4eCsHHA/XikslkIVms/nHhvnvzIZV7VLmBvtFlDOzLt9rrZT+n6D67A==";
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
