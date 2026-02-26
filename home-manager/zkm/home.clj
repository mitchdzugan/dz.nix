#!/usr/bin/env zkm

(defn melee
  ([] (melee "ssbm.1_02.iso"))
  ([iso-name] ["kde-inhibit"
               "--power"
               "--screenSaver"
               "--notifications"
               "--nightLight"
               "gamemoderun"
               "/home/dz/.config/Slippi\\ Launcher/netplay/Slippi_Online-x86_64.AppImage"
               "-b"
               "-e"
               (str "/VOID/ssbm/iso/" iso-name)]))
(def uncle-punch "Training\\ Mode\\ v3.0\\ Alpha\\ 7.2.iso")
(def pick-melee
  (->> (concat ["ls /VOID/ssbm/iso | rofi-dmenu | pipe-exec"] (melee "~%"))
       (into [])))

(defn nix-develop [& args]
  (let [[cmd proj-dir attr] args]
    (str "bash -c \"cd "
             proj-dir
             " && nix develop path:$DZ_NIX_CHECKOUT_PATH"
             (if attr (str "#" attr) "")
             " --command "
             cmd
             "\"")))

(defn dz-nix-develop [& args]
  (let [[cmd sub-proj] args]
    (nix-develop cmd (str "$DZ_NIX_CHECKOUT_PATH/" (or sub-proj ".")) sub-proj)))

(defn dz-nix-gvim [& args] (apply dz-nix-develop "gvim" args))
(defn dz-nix-kitty [& args] (apply dz-nix-develop "kitty" args))

(Title "dz system")
(Cmd :w "open web browser [firefox]" "firefox")
(Cmd :return "open terminal" "kitty")
(Cmd :m "play melee (default iso)" (melee))
(Cmd :a:m "play melee (select iso)" pick-melee)
(Cmd :c:m "play melee (unclepunch)" (melee uncle-punch))
(Cmd :s:M "open slippi launcher" "/home/dz/Downloads/Slippi-Launcher-2.13.3-x86_64.AppImage")
(Col)
(Sub :k "kitty projects"
  (Cmd :n "dz-nix" (dz-nix-kitty))
  (Cmd :f "free-dom" (dz-nix-kitty "free-dom"))
  (Cmd :v "nvim-config" (dz-nix-kitty "neovim"))
  (Cmd :h "home-manager" (dz-nix-kitty "home-manager"))
  (Cmd :s:minus "__.lua" (dz-nix-kitty "__")))
(Sub :v "neovim projects"
  (Cmd :n "dz-nix" (dz-nix-gvim))
  (Cmd :f "free-dom" (dz-nix-gvim "free-dom"))
  (Cmd :v "nvim-config" (dz-nix-gvim "neovim"))
  (Cmd :h "home-manager" (dz-nix-gvim "home-manager"))
  (Cmd :s:minus "__.lua" (dz-nix-gvim "__")))
