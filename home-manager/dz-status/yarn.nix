{ fetchurl, fetchgit, linkFarm, runCommand, gnutar }: rec {
  offline_cache = linkFarm "offline" packages;
  packages = [
    {
      name = "env_paths___env_paths_4.0.0.tgz";
      path = fetchurl {
        name = "env_paths___env_paths_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/env-paths/-/env-paths-4.0.0.tgz";
        sha512 = "pxP8eL2SwwaTRi/KHYwLYXinDs7gL3jxFcBYmEdYfZmZXbaVDvdppd0XBU8qVz03rDfKZMXg1omHCbsJjZrMsw==";
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
      name = "mkdirp___mkdirp_3.0.1.tgz";
      path = fetchurl {
        name = "mkdirp___mkdirp_3.0.1.tgz";
        url  = "https://registry.yarnpkg.com/mkdirp/-/mkdirp-3.0.1.tgz";
        sha512 = "+NsyUUAZDmo6YVHzL/stxSu3t9YS1iljliy3BSDrXJ/dkn1KYdmtZODGGjLcc9XLgVVpH4KshHB8XmZgMhaBXg==";
      };
    }
  ];
}
