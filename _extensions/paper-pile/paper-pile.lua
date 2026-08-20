-- {{< paper-pile "img1.png" "img2.png" ... [stagger=0.4] [height=560px] >}}
--
-- Renders a stack of images that spin into place like dropped newspapers.
-- The first image auto-plays as soon as its slide becomes current; the rest
-- are Reveal fragments that spin in on each subsequent "next" step.
--
-- Position/rotation are computed here (not via CSS :nth-child) because
-- Pandoc wraps each shortcode-emitted image in its own <p>, which would
-- make every image match :nth-child(1) of its own paragraph.

local LEFTS = { 40, 140, 220, 320, 400 }
local TOPS  = { 20, 60, 10, 55, 15 }
local ROTS  = { -4, 3, -2, 4, -3 }

local function styleFor(i, stagger)
  local n = #LEFTS
  local cycle = math.floor((i - 1) / n)
  local left = LEFTS[((i - 1) % n) + 1] + cycle * 100
  local top  = TOPS[((i - 1) % n) + 1]
  local rot  = ROTS[((i - 1) % n) + 1]
  local delay = (i - 1) * stagger
  return string.format(
    "top:%dpx;left:%dpx;--end-rot:%ddeg;animation-delay:%.2fs;",
    top, left, rot, delay
  )
end

local function optStringify(v, default)
  if v == nil then return default end
  local s = pandoc.utils.stringify(v)
  if s == "" then return default end
  return s
end

local function paperPile(args, kwargs)
  if #args == 0 then
    return pandoc.Null()
  end

  -- Non-HTML output (e.g. a pptx target in the same doc): fall back to a
  -- plain stack of images rather than emitting raw HTML/JS that can't run.
  if not quarto.doc.is_format("html") then
    local blocks = pandoc.List({})
    for _, arg in ipairs(args) do
      blocks:insert(pandoc.Para({ pandoc.Image({}, pandoc.utils.stringify(arg)) }))
    end
    return pandoc.Div(blocks)
  end

  quarto.doc.add_html_dependency({
    name = "paper-pile",
    version = "1.0.0",
    stylesheets = { "styles.css" },
    scripts = { "effects.js" }
  })

  local stagger = tonumber(optStringify(kwargs["stagger"], "0.4"))
  local height  = optStringify(kwargs["height"], "560px")

  local html = { string.format('<div class="paper-pile" style="height:%s;">', height) }
  for i, arg in ipairs(args) do
    local src = pandoc.utils.stringify(arg)
    local fragmentClass = i == 1 and "" or " fragment"
    table.insert(html, string.format(
      '<img src="%s" class="paper-shot%s" id="shot%d" style="%s">',
      src, fragmentClass, i, styleFor(i, stagger)
    ))
  end
  table.insert(html, "</div>")

  return pandoc.RawBlock("html", table.concat(html, "\n"))
end

return {
  ["paper-pile"] = paperPile
}
