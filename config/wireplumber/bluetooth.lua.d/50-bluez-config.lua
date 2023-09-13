bluez_monitor.properties = {
    ["bluez5.headset-roles"] = "[ hsp_hs hfp_hf ]"
}

bluez_monitor.rules = {
  matches = {
    {
      { "device.name", "matches", "bluez_card.*" }
    }
  }
}
