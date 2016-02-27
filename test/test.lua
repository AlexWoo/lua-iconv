-- -*- coding: utf-8 -*-

local iconv = require("iconv")

-- Set your terminal encoding here
-- local termcs = "iso-8859-1"
local termcs = "utf8"

local iso88591 = "\65\111\32\108\111\110\103\101\44\32\97\111\32\108\117"
.. "\97\114\10\78\111\32\114\105\111\32\117\109\97\32\118\101\108\97\10\83"
.. "\101\114\101\110\97\32\97\32\112\97\115\115\97\114\44\10\81\117\101\32"
.. "\233\32\113\117\101\32\109\101\32\114\101\118\101\108\97\10\10\78\227"
.. "\111\32\115\101\105\44\32\109\97\115\32\109\117\101\32\115\101\114\10"
.. "\84\111\114\110\111\117\45\115\101\45\109\101\32\101\115\116\114\97\110"
.. "\104\111\44\10\69\32\101\117\32\115\111\110\104\111\32\115\101\109\32"
.. "\118\101\114\10\79\115\32\115\111\110\104\111\115\32\113\117\101\32\116"
.. "\101\110\104\111\46\10\10\81\117\101\32\97\110\103\250\115\116\105\97"
.. "\32\109\101\32\101\110\108\97\231\97\63\10\81\117\101\32\97\109\111\114"
.. "\32\110\227\111\32\115\101\32\101\120\112\108\105\99\97\63\10\201\32\97"
.. "\32\118\101\108\97\32\113\117\101\32\112\97\115\115\97\10\78\97\32\110"
.. "\111\105\116\101\32\113\117\101\32\102\105\99\97\10\10\32\32\32\32\45"
.. "\45\32\70\101\114\110\97\110\100\111\32\80\101\115\115\111\97\10"

local utf8 = "\65\111\32\108\111\110\103\101\44\32\97\111\32\108\117\97\114"
.. "\10\78\111\32\114\105\111\32\117\109\97\32\118\101\108\97\10\83\101\114"
.. "\101\110\97\32\97\32\112\97\115\115\97\114\44\10\81\117\101\32\195\169\32"
.. "\113\117\101\32\109\101\32\114\101\118\101\108\97\10\10\78\195\163\111\32"
.. "\115\101\105\44\32\109\97\115\32\109\117\101\32\115\101\114\10\84\111\114"
.. "\110\111\117\45\115\101\45\109\101\32\101\115\116\114\97\110\104\111\44"
.. "\10\69\32\101\117\32\115\111\110\104\111\32\115\101\109\32\118\101\114\10"
.. "\79\115\32\115\111\110\104\111\115\32\113\117\101\32\116\101\110\104\111"
.. "\46\10\10\81\117\101\32\97\110\103\195\186\115\116\105\97\32\109\101\32"
.. "\101\110\108\97\195\167\97\63\10\81\117\101\32\97\109\111\114\32\110\195"
.. "\163\111\32\115\101\32\101\120\112\108\105\99\97\63\10\195\137\32\97\32"
.. "\118\101\108\97\32\113\117\101\32\112\97\115\115\97\10\78\97\32\110\111"
.. "\105\116\101\32\113\117\101\32\102\105\99\97\10\10\32\32\32\32\45\45\32"
.. "\70\101\114\110\97\110\100\111\32\80\101\115\115\111\97\10"

local utf16 = "\255\254\65\0\111\0\32\0\108\0\111\0\110\0\103\0\101\0\44\0\32"
.. "\0\97\0\111\0\32\0\108\0\117\0\97\0\114\0\10\0\78\0\111\0\32\0\114\0\105"
.. "\0\111\0\32\0\117\0\109\0\97\0\32\0\118\0\101\0\108\0\97\0\10\0\83\0\101"
.. "\0\114\0\101\0\110\0\97\0\32\0\97\0\32\0\112\0\97\0\115\0\115\0\97\0\114"
.. "\0\44\0\10\0\81\0\117\0\101\0\32\0\233\0\32\0\113\0\117\0\101\0\32\0\109"
.. "\0\101\0\32\0\114\0\101\0\118\0\101\0\108\0\97\0\10\0\10\0\78\0\227\0\111"
.. "\0\32\0\115\0\101\0\105\0\44\0\32\0\109\0\97\0\115\0\32\0\109\0\117\0\101"
.. "\0\32\0\115\0\101\0\114\0\10\0\84\0\111\0\114\0\110\0\111\0\117\0\45\0\115"
.. "\0\101\0\45\0\109\0\101\0\32\0\101\0\115\0\116\0\114\0\97\0\110\0\104\0"
.. "\111\0\44\0\10\0\69\0\32\0\101\0\117\0\32\0\115\0\111\0\110\0\104\0\111"
.. "\0\32\0\115\0\101\0\109\0\32\0\118\0\101\0\114\0\10\0\79\0\115\0\32\0\115"
.. "\0\111\0\110\0\104\0\111\0\115\0\32\0\113\0\117\0\101\0\32\0\116\0\101\0"
.. "\110\0\104\0\111\0\46\0\10\0\10\0\81\0\117\0\101\0\32\0\97\0\110\0\103\0"
.. "\250\0\115\0\116\0\105\0\97\0\32\0\109\0\101\0\32\0\101\0\110\0\108\0\97"
.. "\0\231\0\97\0\63\0\10\0\81\0\117\0\101\0\32\0\97\0\109\0\111\0\114\0\32"
.. "\0\110\0\227\0\111\0\32\0\115\0\101\0\32\0\101\0\120\0\112\0\108\0\105\0"
.. "\99\0\97\0\63\0\10\0\201\0\32\0\97\0\32\0\118\0\101\0\108\0\97\0\32\0\113"
.. "\0\117\0\101\0\32\0\112\0\97\0\115\0\115\0\97\0\10\0\78\0\97\0\32\0\110"
.. "\0\111\0\105\0\116\0\101\0\32\0\113\0\117\0\101\0\32\0\102\0\105\0\99\0"
.. "\97\0\10\0\10\0\32\0\32\0\32\0\32\0\45\0\45\0\32\0\70\0\101\0\114\0\110"
.. "\0\97\0\110\0\100\0\111\0\32\0\80\0\101\0\115\0\115\0\111\0\97\0\10\0"

-- Bizarre EBCDIC-CP-ES encoding.
local ebcdic = "\193\150\64\147\150\149\135\133\107\64\129\150\64\147\164\129"
.. "\153\37\213\150\64\153\137\150\64\164\148\129\64\165\133\147\129\37\226"
.. "\133\153\133\149\129\64\129\64\151\129\162\162\129\153\107\37\216\164\133"
.. "\64\81\64\152\164\133\64\148\133\64\153\133\165\133\147\129\37\37\213\70"
.. "\150\64\162\133\137\107\64\148\129\162\64\148\164\133\64\162\133\153\37"
.. "\227\150\153\149\150\164\96\162\133\96\148\133\64\133\162\163\153\129\149"
.. "\136\150\107\37\197\64\133\164\64\162\150\149\136\150\64\162\133\148\64"
.. "\165\133\153\37\214\162\64\162\150\149\136\150\162\64\152\164\133\64\163"
.. "\133\149\136\150\75\37\37\216\164\133\64\129\149\135\222\162\163\137\129"
.. "\64\148\133\64\133\149\147\129\72\129\111\37\216\164\133\64\129\148\150"
.. "\153\64\149\70\150\64\162\133\64\133\167\151\147\137\131\129\111\37\113"
.. "\64\129\64\165\133\147\129\64\152\164\133\64\151\129\162\162\129\37\213"
.. "\129\64\149\150\137\163\133\64\152\164\133\64\134\137\131\129\37\37\64\64"
.. "\64\64\96\96\64\198\133\153\149\129\149\132\150\64\215\133\162\162\150\129"
.. "\37"


function check_one(to, from, text)
  print("\n-- Testing conversion from " .. from .. " to " .. to)
  local cd = iconv.new(to .. "//TRANSLIT", from)
  assert(cd, "Failed to create a converter object.")
  local ostr, err = cd:iconv(text)

  if err ~= nil then
    print("convert error.")
  end

  print(ostr)
end

check_one(termcs, "iso-8859-1", iso88591)
check_one(termcs, "utf8", utf8)
check_one(termcs, "utf16", utf16)
check_one(termcs, "EBCDIC-CP-ES", ebcdic)


-- The library must never crash the interpreter, even if the user tweaks
-- with the garbage collector methods.
local cd = iconv.new("iso-8859-1", "utf-8")
local s, e = cd:iconv("atenção")
assert(e == nil, "Unexpected conversion error")
--local gc = getmetatable(cd).__gc
--gc(cd)
local s, e = cd:iconv("atenção")
print(e)
assert(e == iconv.ERROR_FINALIZED, "Failed to detect double-freed objects")
--gc(cd)


-- Test expected return values
local cd = iconv.new("ascii", "utf-8")
local _, e = cd:iconv("atenção")
print(e)
--assert(e == iconv.ERROR_INVALID, "Unexpected return value for invalid conversion")


local cd = iconv.new("iso-8859-1", "utf-8")
local s, e = cd:iconv("atenção")
print(s)
assert(s == "aten\231\227o", "Unexpected result for valid conversion")
assert(e == nil, "Unexpected return value for valid conversion")
