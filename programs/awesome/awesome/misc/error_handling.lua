local notifs = require("naughty")
local awesome = awesome

if awesome.startup_errors then
  notifs.notify({
      preset = notifs.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors,
  })
end

do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
      if in_error then return end

      in_error = true

      notifs.notify({
          preset = notifs.config.presets.critical,
          title = "Oops, an error happened!",
          text = tostring(err),
      })

      in_error = false
  end)
end
