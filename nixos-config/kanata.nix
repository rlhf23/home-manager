{
  config,
  pkgs,
  ...
}: {
  # kanata
  # Enable the uinput module
  boot.kernelModules = ["uinput"];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = {};

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          ;; Home row mods QWERTY example with more complexity.
          ;; Some of the changes from the basic example:
          ;; - when a home row mod activates tap, the home row mods are disabled
          ;;   while continuing to type rapidly
          ;; - tap-hold-release helps make the hold action more responsive
          ;; - pressing another key on the same half of the keyboard
          ;;   as the home row mod will activate an early tap action

          (defsrc
           caps menu d   f   j   k   l   ;
          )
          (defvar
           ;; Note: consider using different time values for your different fingers.
           ;; For example, your pinkies might be slower to release keys and index
           ;; fingers faster.
           tap-time 200
           hold-time 150

           left-hand-keys (
             q w e r t
             a s d f g
             z x c v b
             )
           right-hand-keys (
             y u i o p
             h j k l ;
             n m , . /
             )
          )
          (deflayer base
           @escctrl lmet @d  @f  @j  @k  @l   @;
          )

          (deflayer nomods
           @escctrl lmet d   f   j   k   l   ;
          )
          (deffakekeys
           to-base (layer-switch base)
          )
          (defalias
           escctrl (tap-hold 100 100 esc lctl)

           tap (multi
             (layer-switch nomods)
             (on-idle-fakekey to-base tap 20)
             )

           a (tap-hold-release-keys $tap-time $hold-time (multi a @tap) lsft $left-hand-keys)
           s (tap-hold-release-keys $tap-time $hold-time (multi s @tap) lalt $left-hand-keys)
           d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lctl $left-hand-keys)
           f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lmet $left-hand-keys)
           j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rmet $right-hand-keys)
           k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rctl $right-hand-keys)
           l (tap-hold-release-keys $tap-time $hold-time (multi l @tap) ralt $right-hand-keys)
           ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) rsft $right-hand-keys)
          )
        '';
      };
    };
  };
}
