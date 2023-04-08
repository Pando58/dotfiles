local function hue2rgb(p, q, t)
  if t < 0   then t = t + 1 end
  if t > 1   then t = t - 1 end
  if t < 1/6 then return p + (q - p) * 6 * t end
  if t < 1/2 then return q end
  if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end

  return p
end

local function hsl2rgb(h, s, l)
  h = h / 360
  s = s / 100
  l = l / 100

  local r, g, b

  if s == 0 then
    r, g, b = l, l, l
  else
    local q
    if l < 0.5 then q = l * (1 + s) else q = l + s - l * s end
    local p = 2 * l - q

    r = hue2rgb(p, q, h + 1/3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1/3)
  end

  return { r * 255, g * 255, b * 255 } -- , a * 255
end

local function rgb2hex(r, g, b)
  local rr = string.format("%02x", r)
  local gg = string.format("%02x", g)
  local bb = string.format("%02x", b)

  return "#" .. rr .. gg .. bb
end

local function create_palette(h, s)
  local colors = {}

  local step = 50

  for i = step, 1000 - step, step do
    local rgb = hsl2rgb(h, s, 100 - i / 10)
    local hex = rgb2hex(table.unpack(rgb))

    colors[tostring(i)] = hex
  end

  return colors
end

return {
  create_palette = create_palette,
}
