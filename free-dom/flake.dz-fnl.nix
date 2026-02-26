{
  name = "free-dom";
  version = "0.0.1-0";
  mkLuaDeps = env: [
    (env.__.mkPkg env.pkgs)
  ];
}
