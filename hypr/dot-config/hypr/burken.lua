-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
  bitdepth = 10,
  vrr = 1,
})

hl.config({
  misc = {
    vrr = true,
  },
})
