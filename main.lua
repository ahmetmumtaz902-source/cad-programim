-- =============================================================================
-- PROFESYONEL MODÜLER 2D CAD SİSTEMİ (LÖVE2D)
-- GELİŞMİŞ VE DOĞRUDAN YAKALAYAN AKILLI OSNAP + ORTHO DIMENSION + GÜVENLİ JSON
-- =============================================================================

CAD = {
    temelIzgaraBoyutu = 50,
    mod = "SEC",
    orthoModu = false,
    komutGirdisi = "",
    osnapMesafe = 22, -- Daha rahat ve akıcı yakalama için tolerans artırıldı
    aktifRenkId = "beyaz",
    aktifCizgiTuru = "surekli",
    aktifFontBoyutu = 14,
    birimCarpanlari = { mm = 1, cm = 10, m = 1000 },
    
    -- Sekmeler Arası Ortak Pano (Clipboard)
    pano = {},
    panoMerkez = { x = 0, y = 0 },

    -- Komut Parametreleri
    filletRadius = 15,
    filletSecilenler = {},
    mirrorEksen = nil,
    offsetMesafesi = 0,
    offsetHedefObje = nil,
    geciciCizgi = nil,
    geciciCember = nil,
    geciciDikdortgen = nil,
    geciciYay = nil,
    geciciDim = nil,
    sonDimBilgi = nil,
    geciciText = nil,
    manipulasyonBase = nil,
    aktifOsnap = nil,
    secimKutusu = nil,
    
    -- Scale (Ölçek) Parametreleri
    scaleBase = nil,
    scaleRefP1 = nil,
    scaleRefLen = nil,
    
    -- Array Parametreleri
    arrayTur = nil,
    arrayRows = 3,
    arrayCols = 3,
    polarAdet = 6,
    polarAci = 360,
    pathAdet = 5,
    
    -- Çoklu Sekme (Tabs) Yönetimi
    aktifSekmeIndex = 1,
    sekmeler = {
        {
            isim = "Cizim 1",
            sekliller = {},
            seciliObjeler = {},
            kamera = { x = 0, y = 0, zoom = 1.0, surukleniyor = false, sonFareX = 0, sonFareY = 0 },
            aktifBirim = "mm",
            dosyaYolu = nil
        }
    },
    
    butonlar = {
        { id = "mm", x = 20, y = 20, w = 45, h = 30, etiket = "MM" },
        { id = "cm", x = 70, y = 20, w = 45, h = 30, etiket = "CM" },
        { id = "m",  x = 120, y = 20, w = 45, h = 30, etiket = "M" }
    },
    renkSözlüğü = {
        beyaz={1,1,1,1}, mavi={0.1,0.4,1,1}, yesil={0.1,0.8,0.2,1}, mor={0.6,0.2,0.8,1},
        sari={1,0.9,0,1}, turuncu={1,0.5,0,1}, turkuaz={0,0.8,0.8,1}, pembe={1,0.3,0.6,1}
    },
    renkButonlari = {
        { id = "beyaz",   x = 180, y = 12, w = 40, h = 20, etiket = "BYZ", renk = { 1, 1, 1 } },
        { id = "mavi",    x = 225, y = 12, w = 40, h = 20, etiket = "MAV", renk = { 0.2, 0.5, 1 } },
        { id = "yesil",   x = 270, y = 12, w = 40, h = 20, etiket = "YSL", renk = { 0.2, 0.8, 0.3 } },
        { id = "mor",     x = 315, y = 12, w = 40, h = 20, etiket = "MOR", renk = { 0.7, 0.3, 0.8 } },
        { id = "sari",    x = 180, y = 37, w = 40, h = 20, etiket = "SAR", renk = { 1, 0.9, 0 } },
        { id = "turuncu", x = 225, y = 37, w = 40, h = 20, etiket = "TRN", renk = { 1, 0.5, 0 } },
        { id = "turkuaz", x = 270, y = 37, w = 40, h = 20, etiket = "TKZ", renk = { 0, 0.8, 0.8 } },
        { id = "pembe",   x = 315, y = 37, w = 40, h = 20, etiket = "PMB", renk = { 1, 0.3, 0.6 } }
    },
    cizgiTuruButonlari = {
        { id = "surekli", x = 370, y = 12, w = 75, h = 20, etiket = "SUREKLI" },
        { id = "aks",     x = 450, y = 12, w = 75, h = 20, etiket = "AKS (-.-)" },
        { id = "kesikli", x = 370, y = 37, w = 75, h = 20, etiket = "KESIKLI" }
    },
    fontButonlari = {
        { id = "font_down", x = 540, y = 12, w = 24, h = 20, etiket = "-" },
        { id = "font_val",  x = 568, y = 12, w = 46, h = 20, etiket = "F:14" },
        { id = "font_up",   x = 618, y = 12, w = 24, h = 20, etiket = "+" }
    },
    aracButonlari = {
        { id = "btn_explode", x = 655, y = 12, w = 75, h = 20, etiket = "EXPLODE" },
        { id = "btn_array",   x = 735, y = 12, w = 65, h = 20, etiket = "ARRAY" },
        { id = "btn_fillet",  x = 655, y = 37, w = 75, h = 20, etiket = "FILLET" },
        { id = "exp_pdf",     x = 735, y = 37, w = 115, h = 20, etiket = "PDF (A4 YATAY)" }
    },
    dosyaButonlari = {
        { id = "save_json", x = 860, y = 12, w = 95, h = 20, etiket = "SAVE JSON" },
        { id = "load_json", x = 960, y = 12, w = 95, h = 20, etiket = "LOAD JSON" },
        { id = "exp_dxf",   x = 860, y = 37, w = 95, h = 20, etiket = "EXPORT DXF" },
        { id = "imp_dxf",   x = 960, y = 37, w = 95, h = 20, etiket = "IMPORT DXF" }
    }
}

CAD.sekliller = CAD.sekmeler[1].sekliller
CAD.seciliObjeler = CAD.sekmeler[1].seciliObjeler
CAD.kamera = CAD.sekmeler[1].kamera
CAD.aktifBirim = CAD.sekmeler[1].aktifBirim

-- =============================================================================
-- SPATIAL HASH GRID MOTORU
-- =============================================================================
local Grid = { boyut = 250, hucreler = {} }
function Grid:temizle() self.hucreler = {} end

function CAD.nesneAABB(s)
    if s.tip == "cizgi" or s.tip == "dimension" then
        local x1 = s.x1 or 0
        local x2 = s.x2 or x1
        local y1 = s.y1 or 0
        local y2 = s.y2 or y1
        if s.tip == "dimension" and s.offset then
            local dx, dy = x2 - x1, y2 - y1
            local len = math.sqrt(dx*dx + dy*dy)
            if len > 0 then
                local nx, ny = -dy / len, dx / len
                local ox1, oy1 = x1 + nx * s.offset, y1 + ny * s.offset
                local ox2, oy2 = x2 + nx * s.offset, y2 + ny * s.offset
                return math.min(x1, x2, ox1, ox2), math.max(x1, x2, ox1, ox2), math.min(y1, y2, oy1, oy2), math.max(y1, y2, oy1, oy2)
            end
        end
        return math.min(x1, x2), math.max(x1, x2), math.min(y1, y2), math.max(y1, y2)
    elseif s.tip == "dikdortgen" then
        return math.min(s.x1, s.x2 or s.x1), math.max(s.x1, s.x2 or s.x1), math.min(s.y1, s.y2 or s.y1), math.max(s.y1, s.y2 or s.y1)
    elseif s.tip == "cember" or s.tip == "yay" then
        local r = s.r or 0
        return (s.cx or 0) - r, (s.cx or 0) + r, (s.cy or 0) - r, (s.cy or 0) + r
    elseif s.tip == "text" then
        local tx, ty = s.tx or 0, s.ty or 0
        return tx, tx + 80, ty - 10, ty + 30
    end
    return 0, 0, 0, 0
end

function Grid:ekle(s)
    local minX, maxX, minY, maxY = CAD.nesneAABB(s)
    local gX1 = math.floor(minX / self.boyut)
    local gX2 = math.floor(maxX / self.boyut)
    local gY1 = math.floor(minY / self.boyut)
    local gY2 = math.floor(maxY / self.boyut)

    if (gX2 - gX1) * (gY2 - gY1) > 200 then
        gX2 = math.min(gX2, gX1 + 14)
        gY2 = math.min(gY2, gY1 + 14)
    end

    for gx = gX1, gX2 do
        for gy = gY1, gY2 do
            local k = gx .. "_" .. gy
            local h = self.hucreler[k]
            if not h then h = {} self.hucreler[k] = h end
            h[#h + 1] = s
        end
    end
end

function Grid:yenile()
    self:temizle()
    for i = 1, #CAD.sekliller do self:ekle(CAD.sekliller[i]) end
end

function Grid:sorgulaKutu(minX, maxX, minY, maxY)
    local gX1 = math.floor(minX / self.boyut)
    local gX2 = math.floor(maxX / self.boyut)
    local gY1 = math.floor(minY / self.boyut)
    local gY2 = math.floor(maxY / self.boyut)
    local list, seen = {}, {}
    for gx = gX1, gX2 do
        for gy = gY1, gY2 do
            local h = self.hucreler[gx .. "_" .. gy]
            if h then
                for i = 1, #h do
                    local item = h[i]
                    if not seen[item] then seen[item] = true list[#list + 1] = item end
                end
            end
        end
    end
    return list
end

function Grid:sorgulaNokta(x, y, r)
    return self:sorgulaKutu(x - r, x + r, y - r, y + r)
end

-- =============================================================================
-- YARDIMCI FONKSİYONLAR
-- =============================================================================
local fontCache = {}
local function getCachedFont(size)
    local s = math.max(6, math.floor(size or 14))
    if not fontCache[s] then fontCache[s] = love.graphics.newFont(s) end
    return fontCache[s]
end

local function latinize(str)
    local rep = {
        ["ı"]="i", ["İ"]="I", ["ş"]="s", ["Ş"]="S", ["ğ"]="g", ["Ğ"]="G",
        ["ü"]="u", ["Ü"]="U", ["ö"]="o", ["Ö"]="O", ["ç"]="c", ["Ç"]="C"
    }
    return (str:gsub("[%z\1-\127\194-\244][\128-\191]*", function(c) return rep[c] or c end))
end

local function konumSecKaydet(varsayilanAd, filtre)
    local yol = nil
    if os.getenv("WINDIR") then
        local pscmd = string.format([[powershell -NoProfile -Command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $g = New-Object System.Windows.Forms.SaveFileDialog; $g.Filter = '%s'; $g.FileName = '%s'; if($g.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){ Write-Output $g.FileName }"]], filtre, varsayilanAd)
        local handle = io.popen(pscmd)
        if handle then yol = handle:read("*a"):gsub("[\r\n]", "") handle:close() end
    else
        local cmd = string.format([[osascript -e 'tell application (path to frontmost application as text) to set theFile to choose file name with prompt "Dosya Konumu Secin:" default name "%s"' 2>/dev/null]], varsayilanAd)
        local handle = io.popen(cmd)
        if handle then yol = handle:read("*a"):gsub("alias ", ""):gsub("[\r\n]", "") handle:close() end
    end
    return (yol and yol ~= "") and yol or nil
end

local function konumSecYukle(filtre)
    local yol = nil
    if os.getenv("WINDIR") then
        local pscmd = string.format([[powershell -NoProfile -Command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $g = New-Object System.Windows.Forms.OpenFileDialog; $g.Filter = '%s'; if($g.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){ Write-Output $g.FileName }"]], filtre)
        local handle = io.popen(pscmd)
        if handle then yol = handle:read("*a"):gsub("[\r\n]", "") handle:close() end
    else
        local cmd = [[osascript -e 'tell application (path to frontmost application as text) to choose file with prompt "Dosya Secin:"' 2>/dev/null]]
        local handle = io.popen(cmd)
        if handle then yol = handle:read("*a"):gsub("alias ", ""):gsub("[\r\n]", "") handle:close() end
    end
    return (yol and yol ~= "") and yol or nil
end

local function arrayMi(t)
    local i = 0 for _ in pairs(t) do i = i + 1 if t[i] == nil then return false end end return i > 0
end

local function tabloyuSeriYap(t)
    if type(t) ~= "table" then
        if type(t) == "string" then
            return string.format('"%s"', t:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n'):gsub('\r', '\\r'):gsub('\t', '\\t'))
        elseif type(t) == "boolean" then
            return t and "true" or "false"
        elseif type(t) == "number" then
            if t ~= t or t == math.huge or t == -math.huge then return "0" end
            return tostring(t)
        else
            return "null"
        end
    end
    if arrayMi(t) then
        local u = {}
        for _, v in ipairs(t) do table.insert(u, tabloyuSeriYap(v)) end
        return "[" .. table.concat(u, ",") .. "]"
    else
        local u = {}
        for k, v in pairs(t) do
            if type(v) ~= "function" and type(v) ~= "userdata" and type(v) ~= "thread" then
                table.insert(u, string.format('"%s":%s', tostring(k), tabloyuSeriYap(v)))
            end
        end
        return "{" .. table.concat(u, ",") .. "}"
    end
end

local function guvenliDosyaYaz(yol, icerik)
    if not yol or yol == "" then return false, "Gecersiz dosya yolu" end
    local ok, err = pcall(function()
        local dosya = io.open(yol, "wb")
        if not dosya then error("Dosya yazma icin acilamadi!") end
        dosya:write(icerik)
        dosya:flush()
        dosya:close()
    end)
    return ok, err
end

local function parseJSON(str)
    local pos = 1
    local len = #str
    local function skipWhitespace() while pos <= len and str:sub(pos, pos):match("%s") do pos = pos + 1 end end
    local parseValue
    local function parseString()
        pos = pos + 1
        local chars = {}
        while pos <= len do
            local c = str:sub(pos, pos)
            if c == '"' then pos = pos + 1 return table.concat(chars)
            elseif c == '\\' then
                pos = pos + 1
                local esc = str:sub(pos, pos)
                if esc == '"' or esc == '\\' or esc == '/' then table.insert(chars, esc)
                elseif esc == 'n' then table.insert(chars, '\n')
                elseif esc == 't' then table.insert(chars, '\t')
                elseif esc == 'r' then table.insert(chars, '\r')
                else table.insert(chars, esc) end
                pos = pos + 1
            else table.insert(chars, c) pos = pos + 1 end
        end
        return table.concat(chars)
    end
    local function parseNumber()
        local start = pos
        if str:sub(pos, pos) == '-' then pos = pos + 1 end
        while pos <= len and str:sub(pos, pos):match("[%d%.eE%+%-]") do pos = pos + 1 end
        return tonumber(str:sub(start, pos - 1))
    end
    local function parseArray()
        pos = pos + 1
        local arr = {}
        skipWhitespace()
        if pos <= len and str:sub(pos, pos) == ']' then pos = pos + 1 return arr end
        while pos <= len do
            table.insert(arr, parseValue())
            skipWhitespace()
            local c = str:sub(pos, pos)
            if c == ']' then pos = pos + 1 return arr
            elseif c == ',' then pos = pos + 1 skipWhitespace()
            else break end
        end
        return arr
    end
    local function parseObject()
        pos = pos + 1
        local obj = {}
        skipWhitespace()
        if pos <= len and str:sub(pos, pos) == '}' then pos = pos + 1 return obj end
        while pos <= len do
            skipWhitespace()
            if str:sub(pos, pos) ~= '"' then break end
            local key = parseString()
            skipWhitespace()
            if str:sub(pos, pos) == ':' then pos = pos + 1 end
            skipWhitespace()
            obj[key] = parseValue()
            skipWhitespace()
            local c = str:sub(pos, pos)
            if c == '}' then pos = pos + 1 return obj
            elseif c == ',' then pos = pos + 1 skipWhitespace()
            else break end
        end
        return obj
    end
    parseValue = function()
        skipWhitespace()
        if pos > len then return nil end
        local c = str:sub(pos, pos)
        if c == '"' then return parseString()
        elseif c == '{' then return parseObject()
        elseif c == '[' then return parseArray()
        elseif c == 't' and str:sub(pos, pos + 3) == "true" then pos = pos + 4 return true
        elseif c == 'f' and str:sub(pos, pos + 4) == "false" then pos = pos + 5 return false
        elseif c == 'n' and str:sub(pos, pos + 3) == "null" then pos = pos + 4 return nil
        else return parseNumber() end
    end
    return parseValue()
end

-- =============================================================================
-- ÇOKLU SEKME VE KAMERA
-- =============================================================================
function CAD.aktifSekme() return CAD.sekmeler[CAD.aktifSekmeIndex] end

function CAD.sekmeDegistir(idx)
    if idx >= 1 and idx <= #CAD.sekmeler then
        local esk = CAD.sekmeler[CAD.aktifSekmeIndex]
        esk.aktifBirim = CAD.aktifBirim
        CAD.aktifSekmeIndex = idx
        local s = CAD.sekmeler[idx]
        CAD.sekliller = s.sekliller
        CAD.seciliObjeler = s.seciliObjeler
        CAD.kamera = s.kamera
        CAD.aktifBirim = s.aktifBirim
        CAD.komutGirdisi = ""
        CAD.mod = "SEC"
        CAD.geciciDim = nil
        CAD.sonDimBilgi = nil
        Grid:yenile()
    end
end

function CAD.yeniSekme()
    local no = #CAD.sekmeler + 1
    local yeni = {
        isim = "Cizim " .. no,
        sekliller = {},
        seciliObjeler = {},
        kamera = { x = 0, y = 0, zoom = 1.0, surukleniyor = false, sonFareX = 0, sonFareY = 0 },
        aktifBirim = CAD.aktifBirim or "mm",
        dosyaYolu = nil
    }
    table.insert(CAD.sekmeler, yeni)
    CAD.sekmeDegistir(#CAD.sekmeler)
    CAD.komutGirdisi = "YENI SEKME ACILDI: " .. yeni.isim
end

function CAD.sekmeKapat(idx)
    if #CAD.sekmeler <= 1 then
        CAD.sekmeler[1].sekliller = {}
        CAD.sekmeler[1].seciliObjeler = {}
        CAD.sekmeler[1].dosyaYolu = nil
        CAD.sekmeler[1].isim = "Cizim 1"
        CAD.sekliller = CAD.sekmeler[1].sekliller
        CAD.seciliObjeler = CAD.sekmeler[1].seciliObjeler
        Grid:yenile()
        CAD.komutGirdisi = "CIZIM ALANI TEMIZLENDI"
        return
    end
    table.remove(CAD.sekmeler, idx)
    if CAD.aktifSekmeIndex > #CAD.sekmeler then CAD.aktifSekmeIndex = #CAD.sekmeler end
    CAD.sekmeDegistir(CAD.aktifSekmeIndex)
end

dunyaFareX, dunyaFareY = 0, 0

function CAD.ekrandanDunyaya(ex, ey)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    return (ex - w / 2) / CAD.kamera.zoom + CAD.kamera.x, (ey - h / 2) / CAD.kamera.zoom + CAD.kamera.y
end

function CAD.zoomYap(y)
    local fx, fy = love.mouse.getPosition()
    local dx_once, dy_once = CAD.ekrandanDunyaya(fx, fy)
    local zoomFaktoru = 1.15
    if y > 0 then
        if CAD.kamera.zoom < 100 then CAD.kamera.zoom = CAD.kamera.zoom * zoomFaktoru end
    elseif y < 0 then
        if CAD.kamera.zoom > 0.0001 then CAD.kamera.zoom = CAD.kamera.zoom / zoomFaktoru end
    end
    local dx_sonra, dy_sonra = CAD.ekrandanDunyaya(fx, fy)
    CAD.kamera.x = CAD.kamera.x + (dx_once - dx_sonra)
    CAD.kamera.y = CAD.kamera.y + (dy_once - dy_sonra)
end

function CAD.kameraGuncelle(fx, fy)
    if CAD.kamera.surukleniyor then
        local dx = fx - CAD.kamera.sonFareX
        local dy = fy - CAD.kamera.sonFareY
        CAD.kamera.x = CAD.kamera.x - dx / CAD.kamera.zoom
        CAD.kamera.y = CAD.kamera.y - dy / CAD.kamera.zoom
        CAD.kamera.sonFareX, CAD.kamera.sonFareY = fx, fy
    end
end

function CAD.cizimiOrtala()
    if #CAD.sekliller == 0 then return end
    local minX, maxX = 1e12, -1e12
    local minY, maxY = 1e12, -1e12
    for _, s in ipairs(CAD.sekliller) do
        local x1, x2, y1, y2 = CAD.nesneAABB(s)
        minX, maxX = math.min(minX, x1), math.max(maxX, x2)
        minY, maxY = math.min(minY, y1), math.max(maxY, y2)
    end
    if minX < 1e11 then
        CAD.kamera.x = (minX + maxX) / 2
        CAD.kamera.y = (minY + maxY) / 2
        local genislik = maxX - minX
        local yukseklik = maxY - minY
        if genislik > 0 and yukseklik > 0 then
            local ekranW = love.graphics.getWidth() - 100
            local ekranH = love.graphics.getHeight() - 160
            CAD.kamera.zoom = math.max(0.0001, math.min(50, math.min(ekranW / genislik, ekranH / yukseklik)))
        end
    end
end

function CAD.fontBoyutuAyarla(yeniBoyut)
    CAD.aktifFontBoyutu = math.max(6, math.min(72, math.floor(yeniBoyut)))
    for _, s in ipairs(CAD.seciliObjeler) do
        if s.tip == "text" or s.tip == "dimension" then s.punto = CAD.aktifFontBoyutu end
    end
end

function CAD.kutuKesişiyorMu(sx1, sy1, sx2, sy2, ox1, oy1, ox2, oy2)
    local minKx, maxKx = math.min(sx1, sx2), math.max(sx1, sx2)
    local minKy, maxKy = math.min(sy1, sy2), math.max(sy1, sy2)
    local minOx, maxOx = math.min(ox1, ox2), math.max(ox1, ox2)
    local minOy, maxOy = math.min(oy1, oy2), math.max(oy1, oy2)
    return not (maxKx < minOx or minKx > maxOx or maxKy < minOy or minKy > maxOy)
end

function CAD.secimKutusuUygula()
    if not CAD.secimKutusu then return end
    CAD.seciliObjeler = {}
    local k = CAD.secimKutusu
    local kMinX, kMaxX = math.min(k.x1, k.x2), math.max(k.x1, k.x2)
    local kMinY, kMaxY = math.min(k.y1, k.y2), math.max(k.y1, k.y2)

    local adaylar = Grid:sorgulaKutu(kMinX, kMaxX, kMinY, kMaxY)
    for _, s in ipairs(CAD.sekliller) do s.secili = false end

    for _, s in ipairs(adaylar) do
        local x1, x2, y1, y2 = CAD.nesneAABB(s)
        if CAD.kutuKesişiyorMu(k.x1, k.y1, k.x2, k.y2, x1, y1, x2, y2) then
            s.secili = true
            table.insert(CAD.seciliObjeler, s)
        end
    end
    CAD.aktifSekme().seciliObjeler = CAD.seciliObjeler
end

function CAD.ucNoktadanCember(x1, y1, x2, y2, x3, y3)
    local d = 2 * (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2))
    if math.abs(d) < 0.00001 then return nil end
    local ux = ((x1*x1 + y1*y1) * (y2 - y3) + (x2*x2 + y2*y2) * (y3 - y1) + (x3*x3 + y3*y3) * (y1 - y2)) / d
    local uy = ((x1*x1 + y1*y1) * (x3 - x2) + (x2*x2 + y2*y2) * (x1 - x3) + (x3*x3 + y3*y3) * (x2 - x1)) / d
    local r = math.sqrt((x1 - ux)^2 + (y1 - uy)^2)
    local a1 = math.atan2(y1 - uy, x1 - ux)
    local a2 = math.atan2(y2 - uy, x2 - ux)
    local a3 = math.atan2(y3 - uy, x3 - ux)
    if a1 < 0 then a1 = a1 + 2 * math.pi end
    if a2 < 0 then a2 = a2 + 2 * math.pi end
    if a3 < 0 then a3 = a3 + 2 * math.pi end
    local diff = (a3 - a1) % (2 * math.pi)
    local diff2 = (a2 - a1) % (2 * math.pi)
    if diff2 > diff then a1, a3 = a3, a1 end
    return ux, uy, r, a1, a3
end

function CAD.geciciSekilleriGuncelle(dfx, dfy)
    local snapVar = (CAD.aktifOsnap ~= nil)

    if CAD.mod == "CIZGI" and CAD.geciciCizgi then
        if CAD.orthoModu and not snapVar then
            local dx = math.abs(dfx - CAD.geciciCizgi.x1)
            local dy = math.abs(dfy - CAD.geciciCizgi.y1)
            if dx > dy then
                CAD.geciciCizgi.x2 = dfx
                CAD.geciciCizgi.y2 = CAD.geciciCizgi.y1
            else
                CAD.geciciCizgi.x2 = CAD.geciciCizgi.x1
                CAD.geciciCizgi.y2 = dfy
            end
        else
            CAD.geciciCizgi.x2 = dfx
            CAD.geciciCizgi.y2 = dfy
        end
    end
    if CAD.mod == "DIM_2" and CAD.geciciDim then
        if CAD.orthoModu and not snapVar then
            local dx = math.abs(dfx - CAD.geciciDim.x1)
            local dy = math.abs(dfy - CAD.geciciDim.y1)
            if dx > dy then
                CAD.geciciDim.x2 = dfx
                CAD.geciciDim.y2 = CAD.geciciDim.y1
            else
                CAD.geciciDim.x2 = CAD.geciciDim.x1
                CAD.geciciDim.y2 = dfy
            end
        else
            CAD.geciciDim.x2 = dfx
            CAD.geciciDim.y2 = dfy
        end
    end
    if CAD.mod == "CEMBER" and CAD.geciciCember then
        CAD.geciciCember.r = math.sqrt((dfx - CAD.geciciCember.cx)^2 + (dfy - CAD.geciciCember.cy)^2)
    end
    if CAD.mod == "DIKDORTGEN" and CAD.geciciDikdortgen then
        CAD.geciciDikdortgen.x2 = dfx
        CAD.geciciDikdortgen.y2 = dfy
    end
    if CAD.mod == "DIM_CONT" and CAD.geciciDim then
        if CAD.orthoModu and not snapVar then
            local dx = math.abs(dfx - CAD.geciciDim.x1)
            local dy = math.abs(dfy - CAD.geciciDim.y1)
            if dx > dy then
                CAD.geciciDim.x2 = dfx
                CAD.geciciDim.y2 = CAD.geciciDim.y1
            else
                CAD.geciciDim.x2 = CAD.geciciDim.x1
                CAD.geciciDim.y2 = dfy
            end
        else
            CAD.geciciDim.x2 = dfx
            CAD.geciciDim.y2 = dfy
        end
    end
end

-- =============================================================================
-- GELİŞMİŞ VE DOĞRUDAN KİLİTLENEN OSNAP MOTORU
-- =============================================================================
function CAD.osnapHesapla(hamX, hamY)
    CAD.aktifOsnap = nil
    local zoom = CAD.kamera.zoom
    local enYakinPikselMesafe = CAD.osnapMesafe

    -- Ekran piksel mesafesini dünya koordinat farkı üzerinden doğrudan ve hatasız hesaplar
    local function testNokta(nx, ny, tip)
        local dx = (nx - hamX) * zoom
        local dy = (ny - hamY) * zoom
        local pikselMesafe = math.sqrt(dx * dx + dy * dy)
        if pikselMesafe <= enYakinPikselMesafe then
            enYakinPikselMesafe = pikselMesafe
            CAD.aktifOsnap = { x = nx, y = ny, tip = tip }
            return true
        end
        return false
    end

    local aramaYaricapi = (CAD.osnapMesafe + 25) / zoom
    -- 1500 nesneye kadar tüm nesneleri tarayarak spatial hash kısıtlamasından kaynaklı atlamaları önler
    local adaylar = (#CAD.sekliller <= 1500) and CAD.sekliller or Grid:sorgulaNokta(hamX, hamY, aramaYaricapi)

    -- 1. ÖNCELİK: Uç Nokta, Köşe, Orta Nokta, Merkez ve Dörtgen Kutup Noktaları
    for i = 1, #adaylar do
        local s = adaylar[i]
        if s.tip == "cizgi" then
            testNokta(s.x1, s.y1, "Uc Nokta")
            testNokta(s.x2, s.y2, "Uc Nokta")
            testNokta((s.x1 + s.x2) * 0.5, (s.y1 + s.y2) * 0.5, "Orta Nokta")
        elseif s.tip == "dikdortgen" then
            local xmin, xmax = math.min(s.x1, s.x2), math.max(s.x1, s.x2)
            local ymin, ymax = math.min(s.y1, s.y2), math.max(s.y1, s.y2)
            testNokta(xmin, ymin, "Kose")
            testNokta(xmax, ymin, "Kose")
            testNokta(xmax, ymax, "Kose")
            testNokta(xmin, ymax, "Kose")
            testNokta((xmin + xmax) * 0.5, ymin, "Orta Nokta")
            testNokta((xmin + xmax) * 0.5, ymax, "Orta Nokta")
            testNokta(xmin, (ymin + ymax) * 0.5, "Orta Nokta")
            testNokta(xmax, (ymin + ymax) * 0.5, "Orta Nokta")
            testNokta((xmin + xmax) * 0.5, (ymin + ymax) * 0.5, "Merkez")
        elseif s.tip == "cember" or s.tip == "yay" then
            testNokta(s.cx, s.cy, "Merkez")
            testNokta(s.cx, s.cy - s.r, "Kutup (K)")
            testNokta(s.cx, s.cy + s.r, "Kutup (G)")
            testNokta(s.cx + s.r, s.cy, "Kutup (D)")
            testNokta(s.cx - s.r, s.cy, "Kutup (B)")
            if s.tip == "yay" then
                local ax1 = s.cx + s.r * math.cos(s.a1)
                local ay1 = s.cy + s.r * math.sin(s.a1)
                local ax2 = s.cx + s.r * math.cos(s.a2)
                local ay2 = s.cy + s.r * math.sin(s.a2)
                local amid = (s.a1 + s.a2) * 0.5
                testNokta(ax1, ay1, "Yay Ucu")
                testNokta(ax2, ay2, "Yay Ucu")
                testNokta(s.cx + s.r * math.cos(amid), s.cy + s.r * math.sin(amid), "Yay Tepe")
            end
        elseif s.tip == "dimension" then
            testNokta(s.x1, s.y1, "Olcu Basi")
            testNokta(s.x2, s.y2, "Olcu Sonu")
            local dx, dy = s.x2 - s.x1, s.y2 - s.y1
            local len = math.sqrt(dx*dx + dy*dy)
            if len > 0 then
                local nx, ny = -dy / len, dx / len
                local off = s.offset or 25
                local ox1, oy1 = s.x1 + nx * off, s.y1 + ny * off
                local ox2, oy2 = s.x2 + nx * off, s.y2 + ny * off
                testNokta(ox1, oy1, "Olcu Ucu")
                testNokta(ox2, oy2, "Olcu Ucu")
                testNokta((ox1 + ox2) * 0.5, (oy1 + oy2) * 0.5, "Olcu Merkezi")
            end
        elseif s.tip == "text" then
            testNokta(s.tx, s.ty, "Yazi Noktasi")
        end
    end

    -- 2. ÖNCELİK: Her Türlü Çizgi ve Kenar Boyunca "EN YAKIN NOKTA (NEAREST)"
    if not CAD.aktifOsnap then
        local function testSegmentNearest(x1, y1, x2, y2)
            local l2 = (x2 - x1)^2 + (y2 - y1)^2
            if l2 > 0.00001 then
                local t = math.max(0, math.min(1, ((hamX - x1) * (x2 - x1) + (hamY - y1) * (y2 - y1)) / l2))
                local px = x1 + t * (x2 - x1)
                local py = y1 + t * (y2 - y1)
                testNokta(px, py, "En Yakin (Cizgi)")
            end
        end

        for i = 1, #adaylar do
            local s = adaylar[i]
            if s.tip == "cizgi" then
                testSegmentNearest(s.x1, s.y1, s.x2, s.y2)
            elseif s.tip == "dikdortgen" then
                local xmin, xmax = math.min(s.x1, s.x2), math.max(s.x1, s.x2)
                local ymin, ymax = math.min(s.y1, s.y2), math.max(s.y1, s.y2)
                testSegmentNearest(xmin, ymin, xmax, ymin)
                testSegmentNearest(xmax, ymin, xmax, ymax)
                testSegmentNearest(xmax, ymax, xmin, ymax)
                testSegmentNearest(xmin, ymax, xmin, ymin)
            elseif s.tip == "cember" then
                local d = math.sqrt((hamX - s.cx)^2 + (hamY - s.cy)^2)
                if d > 0.0001 then
                    local px = s.cx + (hamX - s.cx) / d * s.r
                    local py = s.cy + (hamY - s.cy) / d * s.r
                    testNokta(px, py, "En Yakin (Daire)")
                end
            elseif s.tip == "yay" then
                local d = math.sqrt((hamX - s.cx)^2 + (hamY - s.cy)^2)
                if d > 0.0001 then
                    local px = s.cx + (hamX - s.cx) / d * s.r
                    local py = s.cy + (hamY - s.cy) / d * s.r
                    local ang = (math.atan2(hamY - s.cy, hamX - s.cx) % (2 * math.pi) + 2 * math.pi) % (2 * math.pi)
                    local a1 = (s.a1 % (2 * math.pi) + 2 * math.pi) % (2 * math.pi)
                    local a2 = (s.a2 % (2 * math.pi) + 2 * math.pi) % (2 * math.pi)
                    local icinde = (a1 <= a2) and (ang >= a1 and ang <= a2) or (ang >= a1 or ang <= a2)
                    if icinde then testNokta(px, py, "En Yakin (Yay)") end
                end
            end
        end
    end
end

function CAD.objeBul(dfx, dfy)
    local tol = 15 / CAD.kamera.zoom
    local adaylar = Grid:sorgulaNokta(dfx, dfy, tol * 2)

    for i = #adaylar, 1, -1 do
        local s = adaylar[i]
        if s.tip == "cember" or s.tip == "yay" then
            local dist = math.sqrt((dfx - s.cx)^2 + (dfy - s.cy)^2)
            if math.abs(dist - s.r) < tol then
                if s.tip == "yay" then
                    local ang = math.atan2(dfy - s.cy, dfx - s.cx)
                    local a1 = (s.a1 % (2 * math.pi) + 2 * math.pi) % (2 * math.pi)
                    local a2 = (s.a2 % (2 * math.pi) + 2 * math.pi) % (2 * math.pi)
                    local mAng = (ang % (2 * math.pi) + 2 * math.pi) % (2 * math.pi)
                    local inRange = (a1 <= a2) and (mAng >= a1 - 0.05 and mAng <= a2 + 0.05) or (mAng >= a1 - 0.05 or mAng <= a2 + 0.05)
                    if inRange then return s end
                else
                    return s
                end
            end
        elseif s.tip == "cizgi" then
            local l2 = (s.x1 - s.x2)^2 + (s.y1 - s.y2)^2
            if l2 ~= 0 then
                local t = math.max(0, math.min(1, ((dfx - s.x1) * (s.x2 - s.x1) + (dfy - s.y1) * (s.y2 - s.y1)) / l2))
                local px = s.x1 + t * (s.x2 - s.x1)
                local py = s.y1 + t * (s.y2 - s.y1)
                if math.sqrt((dfx - px)^2 + (dfy - py)^2) < tol then return s end
            end
        elseif s.tip == "dimension" then
            local dx, dy = s.x2 - s.x1, s.y2 - s.y1
            local len = math.sqrt(dx*dx + dy*dy)
            if len > 0 then
                local nx, ny = -dy / len, dx / len
                local ox1 = s.x1 + nx * s.offset
                local oy1 = s.y1 + ny * s.offset
                local ox2 = s.x2 + nx * s.offset
                local oy2 = s.y2 + ny * s.offset
                local l2 = (ox1 - ox2)^2 + (oy1 - oy2)^2
                if l2 ~= 0 then
                    local t = math.max(0, math.min(1, ((dfx - ox1) * (ox2 - ox1) + (dfy - oy1) * (oy2 - oy1)) / l2))
                    local px = ox1 + t * (ox2 - ox1)
                    local py = oy1 + t * (oy2 - oy1)
                    if math.sqrt((dfx - px)^2 + (dfy - py)^2) < tol then return s end
                end
            end
        elseif s.tip == "dikdortgen" then
            local minX, maxX = math.min(s.x1, s.x2), math.max(s.x1, s.x2)
            local minY, maxY = math.min(s.y1, s.y2), math.max(s.y1, s.y2)
            local kenarda = (math.abs(dfx - minX) < tol or math.abs(dfx - maxX) < tol) and (dfy >= minY - tol and dfy <= maxY + tol)
                         or (math.abs(dfy - minY) < tol or math.abs(dfy - maxY) < tol) and (dfx >= minX - tol and dfx <= maxX + tol)
            if kenarda then return s end
        elseif s.tip == "text" then
            if math.abs(dfx - s.tx) < 60 / CAD.kamera.zoom and math.abs(dfy - s.ty) < 25 / CAD.kamera.zoom then
                return s
            end
        end
    end
    return nil
end

-- =============================================================================
-- KOPYALAMA, DÖNDÜRME VE SCALE MATEMATİĞİ
-- =============================================================================
local function kopyaKaydir(s, dx, dy)
    if s.tip == "cizgi" or s.tip == "dimension" then
        return { tip = s.tip, x1 = s.x1 + dx, y1 = s.y1 + dy, x2 = s.x2 + dx, y2 = s.y2 + dy, offset = s.offset, metin = s.metin, punto = s.punto, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "dikdortgen" then
        return { tip = "dikdortgen", x1 = s.x1 + dx, y1 = s.y1 + dy, x2 = s.x2 + dx, y2 = s.y2 + dy, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "cember" or s.tip == "yay" then
        return { tip = s.tip, cx = s.cx + dx, cy = s.cy + dy, r = s.r, a1 = s.a1, a2 = s.a2, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "text" then
        return { tip = "text", tx = s.tx + dx, ty = s.ty + dy, metin = s.metin, punto = s.punto, renk = s.renk }
    end
    return nil
end

local function kopyaDondur(s, cx, cy, aci)
    local cosA, sinA = math.cos(aci), math.sin(aci)
    local function rotPt(px, py)
        local dx, dy = px - cx, py - cy
        return cx + dx * cosA - dy * sinA, cy + dx * sinA + dy * cosA
    end
    if s.tip == "cizgi" or s.tip == "dimension" then
        local rx1, ry1 = rotPt(s.x1, s.y1)
        local rx2, ry2 = rotPt(s.x2, s.y2)
        return { tip = s.tip, x1 = rx1, y1 = ry1, x2 = rx2, y2 = ry2, offset = s.offset, metin = s.metin, punto = s.punto, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "dikdortgen" then
        local rx1, ry1 = rotPt(s.x1, s.y1)
        local rx2, ry2 = rotPt(s.x2, s.y2)
        return { tip = "dikdortgen", x1 = rx1, y1 = ry1, x2 = rx2, y2 = ry2, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "cember" then
        local rcx, rcy = rotPt(s.cx, s.cy)
        return { tip = "cember", cx = rcx, cy = rcy, r = s.r, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "yay" then
        local rcx, rcy = rotPt(s.cx, s.cy)
        return { tip = "yay", cx = rcx, cy = rcy, r = s.r, a1 = s.a1 + aci, a2 = s.a2 + aci, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "text" then
        local rtx, rty = rotPt(s.tx, s.ty)
        return { tip = "text", tx = rtx, ty = rty, metin = s.metin, punto = s.punto, renk = s.renk }
    end
    return nil
end

function CAD.olcekUygula(factor, bx, by)
    if not factor or factor <= 0 or math.abs(factor - 1) < 0.0000001 then return end
    local carpan = CAD.birimCarpanlari[CAD.aktifBirim] or 1
    
    for _, s in ipairs(CAD.seciliObjeler) do
        if s.tip == "cizgi" then
            s.x1 = bx + (s.x1 - bx) * factor
            s.y1 = by + (s.y1 - by) * factor
            s.x2 = bx + (s.x2 - bx) * factor
            s.y2 = by + (s.y2 - by) * factor
        elseif s.tip == "dikdortgen" then
            s.x1 = bx + (s.x1 - bx) * factor
            s.y1 = by + (s.y1 - by) * factor
            s.x2 = bx + (s.x2 - bx) * factor
            s.y2 = by + (s.y2 - by) * factor
        elseif s.tip == "cember" or s.tip == "yay" then
            s.cx = bx + (s.cx - bx) * factor
            s.cy = by + (s.cy - by) * factor
            s.r  = s.r * factor
        elseif s.tip == "text" then
            s.tx = bx + (s.tx - bx) * factor
            s.ty = by + (s.ty - by) * factor
        elseif s.tip == "dimension" then
            s.x1 = bx + (s.x1 - bx) * factor
            s.y1 = by + (s.y1 - by) * factor
            s.x2 = bx + (s.x2 - bx) * factor
            s.y2 = by + (s.y2 - by) * factor
            if s.offset then s.offset = s.offset * factor end
            local dx = s.x2 - s.x1
            local dy = s.y2 - s.y1
            local yeniLen = math.sqrt(dx * dx + dy * dy)
            s.metin = string.format("%.2f %s", yeniLen / carpan, CAD.aktifBirim)
        end
    end
    Grid:yenile()
end

function CAD.kopyala()
    if #CAD.seciliObjeler == 0 then CAD.komutGirdisi = "KOPYALA: Secili nesne yok!" return end
    CAD.pano = {}
    local minX, maxX, minY, maxY = 1e12, -1e12, 1e12, -1e12
    for _, s in ipairs(CAD.seciliObjeler) do
        local kopya = {}
        for k, v in pairs(s) do
            if type(v) == "table" then
                local tbl = {} for subK, subV in pairs(v) do tbl[subK] = subV end kopya[k] = tbl
            else kopya[k] = v end
        end
        kopya.secili = false
        table.insert(CAD.pano, kopya)
        local x1, x2, y1, y2 = CAD.nesneAABB(s)
        minX, maxX = math.min(minX, x1), math.max(maxX, x2)
        minY, maxY = math.min(minY, y1), math.max(maxY, y2)
    end
    CAD.panoMerkez = { x = (minX + maxX) / 2, y = (minY + maxY) / 2 }
    CAD.komutGirdisi = string.format("PANOYA KOPYALANDI (%d Nesne)", #CAD.pano)
end

function CAD.yapistir(hedefX, hedefY)
    if #CAD.pano == 0 then CAD.komutGirdisi = "PANO BOS! Once nesne secip Ctrl+C yapin." return end
    local hX, hY = hedefX or dunyaFareX, hedefY or dunyaFareY
    local dx, dy = hX - CAD.panoMerkez.x, hY - CAD.panoMerkez.y
    for _, s in ipairs(CAD.sekliller) do s.secili = false end
    CAD.seciliObjeler = {}
    for _, s in ipairs(CAD.pano) do
        local nObj = kopyaKaydir(s, dx, dy)
        if nObj then
            nObj.secili = true
            table.insert(CAD.sekliller, nObj)
            table.insert(CAD.seciliObjeler, nObj)
            Grid:ekle(nObj)
        end
    end
    CAD.aktifSekme().seciliObjeler = CAD.seciliObjeler
    CAD.komutGirdisi = string.format("YAPISTIRILDI (%d Nesne)", #CAD.seciliObjeler)
end

function CAD.explodeUygula()
    if #CAD.seciliObjeler == 0 then CAD.komutGirdisi = "EXPLODE: Once patlatilacak dikdortgeni secin!" return end
    local sayac = 0
    local yeniSekiller, silinecekler = {}, {}
    for _, s in ipairs(CAD.seciliObjeler) do
        if s.tip == "dikdortgen" then
            table.insert(silinecekler, s)
            table.insert(yeniSekiller, { tip = "cizgi", x1 = s.x1, y1 = s.y1, x2 = s.x2, y2 = s.y1, renk = s.renk, cizgiTuru = s.cizgiTuru })
            table.insert(yeniSekiller, { tip = "cizgi", x1 = s.x2, y1 = s.y1, x2 = s.x2, y2 = s.y2, renk = s.renk, cizgiTuru = s.cizgiTuru })
            table.insert(yeniSekiller, { tip = "cizgi", x1 = s.x2, y1 = s.y2, x2 = s.x1, y2 = s.y2, renk = s.renk, cizgiTuru = s.cizgiTuru })
            table.insert(yeniSekiller, { tip = "cizgi", x1 = s.x1, y1 = s.y2, x2 = s.x1, y2 = s.y1, renk = s.renk, cizgiTuru = s.cizgiTuru })
            sayac = sayac + 1
        end
    end
    for _, sil in ipairs(silinecekler) do
        for i = #CAD.sekliller, 1, -1 do
            if CAD.sekliller[i] == sil then table.remove(CAD.sekliller, i) break end
        end
    end
    for _, yeni in ipairs(yeniSekiller) do table.insert(CAD.sekliller, yeni) end
    CAD.seciliObjeler = {}
    CAD.aktifSekme().seciliObjeler = {}
    for _, s in ipairs(CAD.sekliller) do s.secili = false end
    CAD.mod = "SEC"
    Grid:yenile()
    CAD.komutGirdisi = (sayac > 0) and string.format("EXPLODE: %d dikdortgen patlatildi!", sayac) or "EXPLODE: Dikdortgen yok!"
end

function CAD.arrayBaslat()
    if #CAD.seciliObjeler == 0 then CAD.komutGirdisi = "ARRAY: Once nesneleri secin!" return end
    CAD.mod = "ARRAY_MENU"
    CAD.komutGirdisi = ""
end

function CAD.arrayUygulaRect(rows, cols, aralikX, aralikY)
    for r = 0, rows - 1 do
        for c = 0, cols - 1 do
            if not (r == 0 and c == 0) then
                local dx, dy = c * aralikX, -r * aralikY
                for _, s in ipairs(CAD.seciliObjeler) do
                    local nObj = kopyaKaydir(s, dx, dy)
                    if nObj then table.insert(CAD.sekliller, nObj) Grid:ekle(nObj) end
                end
            end
        end
    end
    for _, s in ipairs(CAD.sekliller) do s.secili = false end
    CAD.seciliObjeler = {}
    CAD.aktifSekme().seciliObjeler = {}
    CAD.mod = "SEC"
    CAD.komutGirdisi = string.format("RECT ARRAY: %dx%d adet cogaltildi!", rows, cols)
end

function CAD.arrayUygulaPolar(adet, aciDeg, cx, cy)
    if adet < 2 then adet = 2 end
    local toplamRad = math.rad(aciDeg)
    local adimRad = (math.abs(aciDeg - 360) < 0.1) and (toplamRad / adet) or (toplamRad / (adet - 1))
    for i = 1, adet - 1 do
        local theta = i * adimRad
        for _, s in ipairs(CAD.seciliObjeler) do
            local nObj = kopyaDondur(s, cx, cy, theta)
            if nObj then table.insert(CAD.sekliller, nObj) Grid:ekle(nObj) end
        end
    end
    for _, s in ipairs(CAD.sekliller) do s.secili = false end
    CAD.seciliObjeler = {}
    CAD.aktifSekme().seciliObjeler = {}
    CAD.mod = "SEC"
    CAD.komutGirdisi = string.format("POLAR ARRAY: %d adet dairesel cogaltildi!", adet)
end

function CAD.arrayUygulaPath(adet, yolObj)
    if adet < 2 then adet = 2 end
    if yolObj.tip == "cizgi" then
        local x1, y1, x2, y2 = yolObj.x1, yolObj.y1, yolObj.x2, yolObj.y2
        for i = 1, adet - 1 do
            local t = i / (adet - 1)
            local dx, dy = (x2 - x1) * t, (y2 - y1) * t
            for _, s in ipairs(CAD.seciliObjeler) do
                local nObj = kopyaKaydir(s, dx, dy)
                if nObj then table.insert(CAD.sekliller, nObj) Grid:ekle(nObj) end
            end
        end
    elseif yolObj.tip == "yay" then
        local cx, cy, r, a1, a2 = yolObj.cx, yolObj.cy, yolObj.r, yolObj.a1, yolObj.a2
        local basX, basY = cx + r * math.cos(a1), cy + r * math.sin(a1)
        for i = 1, adet - 1 do
            local t = i / (adet - 1)
            local ang = a1 + (a2 - a1) * t
            local ptX, ptY = cx + r * math.cos(ang), cy + r * math.sin(ang)
            local dx, dy = ptX - basX, ptY - basY
            for _, s in ipairs(CAD.seciliObjeler) do
                local nObj = kopyaKaydir(s, dx, dy)
                if nObj then table.insert(CAD.sekliller, nObj) Grid:ekle(nObj) end
            end
        end
    end
    for _, s in ipairs(CAD.sekliller) do s.secili = false end
    CAD.seciliObjeler = {}
    CAD.aktifSekme().seciliObjeler = {}
    CAD.mod = "SEC"
    CAD.komutGirdisi = string.format("PATH ARRAY: %d adet hat boyu cogaltildi!", adet)
end

function CAD.offsetHesapla(s, dfx, dfy, mesafe)
    if s.tip == "cember" then
        local dist = math.sqrt((dfx - s.cx)^2 + (dfy - s.cy)^2)
        return { tip = "cember", cx = s.cx, cy = s.cy, r = math.max(1, (dist > s.r) and (s.r + mesafe) or (s.r - mesafe)), renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "yay" then
        local dist = math.sqrt((dfx - s.cx)^2 + (dfy - s.cy)^2)
        return { tip = "yay", cx = s.cx, cy = s.cy, r = math.max(1, (dist > s.r) and (s.r + mesafe) or (s.r - mesafe)), a1 = s.a1, a2 = s.a2, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "cizgi" then
        local dx, dy = s.x2 - s.x1, s.y2 - s.y1
        local len = math.sqrt(dx * dx + dy * dy)
        if len == 0 then return nil end
        local nx, ny = -dy / len, dx / len
        if ((dfx - s.x1) * (s.y2 - s.y1) - (dfy - s.y1) * (s.x2 - s.x1)) < 0 then nx, ny = -nx, -ny end
        return { tip = "cizgi", x1 = s.x1 + nx * mesafe, y1 = s.y1 + ny * mesafe, x2 = s.x2 + nx * mesafe, y2 = s.y2 + ny * mesafe, renk = s.renk, cizgiTuru = s.cizgiTuru }
    elseif s.tip == "dikdortgen" then
        local mx, my = (s.x1 + s.x2) / 2, (s.y1 + s.y2) / 2
        local m = (math.sqrt((dfx - mx)^2 + (dfy - my)^2) > math.sqrt((s.x1 - mx)^2 + (s.y1 - my)^2)) and mesafe or -mesafe
        return { tip = "dikdortgen", x1 = s.x1 + ((s.x1 < s.x2) and -m or m), y1 = s.y1 + ((s.y1 < s.y2) and -m or m), x2 = s.x2 + ((s.x2 > s.x1) and m or -m), y2 = s.y2 + ((s.y2 > s.y1) and m or -m), renk = s.renk, cizgiTuru = s.cizgiTuru }
    end
    return nil
end

local function mirrorHesapla(x1, y1, x2, y2, px, py)
    local dx, dy = x2 - x1, y2 - y1
    local len = math.sqrt(dx * dx + dy * dy)
    if len == 0 then return px, py end
    local nx, ny = dx / len, dy / len
    local ax, ay = px - x1, py - y1
    local dot = ax * nx + ay * ny
    return 2 * (x1 + dot * nx) - px, 2 * (y1 + dot * ny) - py
end

local function mirrorOnizlemeCiz(x1, y1, x2, y2)
    love.graphics.setColor(0, 1, 0, 0.4)
    love.graphics.setLineWidth(1 / CAD.kamera.zoom)
    love.graphics.line(x1, y1, x2, y2)
    love.graphics.setColor(1, 1, 0, 0.6)
    local axisAngle = math.atan2(y2 - y1, x2 - x1)
    
    for _, s in ipairs(CAD.seciliObjeler) do
        if s.tip == "cizgi" or s.tip == "dimension" then
            local rx1, ry1 = mirrorHesapla(x1, y1, x2, y2, s.x1, s.y1)
            local rx2, ry2 = mirrorHesapla(x1, y1, x2, y2, s.x2, s.y2)
            love.graphics.line(rx1, ry1, rx2, ry2)
        elseif s.tip == "cember" then
            local rcx, rcy = mirrorHesapla(x1, y1, x2, y2, s.cx, s.cy)
            love.graphics.circle("line", rcx, rcy, s.r)
        elseif s.tip == "yay" then
            local rcx, rcy = mirrorHesapla(x1, y1, x2, y2, s.cx, s.cy)
            local sweep = (s.a2 - s.a1) % (2 * math.pi)
            if sweep <= 0 then sweep = sweep + 2 * math.pi end
            local na1 = (2 * axisAngle - s.a2) % (2 * math.pi)
            if na1 < 0 then na1 = na1 + 2 * math.pi end
            local na2 = na1 + sweep
            love.graphics.arc("line", "open", rcx, rcy, s.r, na1, na2)
        elseif s.tip == "dikdortgen" then
            local p1x, p1y = mirrorHesapla(x1, y1, x2, y2, s.x1, s.y1)
            local p2x, p2y = mirrorHesapla(x1, y1, x2, y2, s.x2, s.y1)
            local p3x, p3y = mirrorHesapla(x1, y1, x2, y2, s.x2, s.y2)
            local p4x, p4y = mirrorHesapla(x1, y1, x2, y2, s.x1, s.y2)
            love.graphics.line(p1x, p1y, p2x, p2y)
            love.graphics.line(p2x, p2y, p3x, p3y)
            love.graphics.line(p3x, p3y, p4x, p4y)
            love.graphics.line(p4x, p4y, p1x, p1y)
        end
    end
end

function CAD.mirrorUygula(dfx, dfy)
    if not CAD.mirrorEksen then
        CAD.mirrorEksen = { x1 = dfx, y1 = dfy }
        CAD.komutGirdisi = "MIRROR: Eksenin 2. Noktasini Tiklayin"
    else
        local x1, y1 = CAD.mirrorEksen.x1, CAD.mirrorEksen.y1
        local x2, y2 = dfx, dfy
        if x1 == x2 and y1 == y2 then CAD.mirrorEksen = nil CAD.mod = "SEC" return end
        local axisAngle = math.atan2(y2 - y1, x2 - x1)
        
        for _, s in ipairs(CAD.seciliObjeler) do
            local nObj = nil
            if s.tip == "cizgi" or s.tip == "dimension" then
                local rx1, ry1 = mirrorHesapla(x1, y1, x2, y2, s.x1, s.y1)
                local rx2, ry2 = mirrorHesapla(x1, y1, x2, y2, s.x2, s.y2)
                nObj = { tip = s.tip, x1 = rx1, y1 = ry1, x2 = rx2, y2 = ry2, offset = s.offset, metin = s.metin, punto = s.punto, renk = s.renk, cizgiTuru = s.cizgiTuru }
            elseif s.tip == "cember" then
                local rcx, rcy = mirrorHesapla(x1, y1, x2, y2, s.cx, s.cy)
                nObj = { tip = s.tip, cx = rcx, cy = rcy, r = s.r, renk = s.renk, cizgiTuru = s.cizgiTuru }
            elseif s.tip == "yay" then
                local rcx, rcy = mirrorHesapla(x1, y1, x2, y2, s.cx, s.cy)
                local sweep = (s.a2 - s.a1) % (2 * math.pi)
                if sweep <= 0 then sweep = sweep + 2 * math.pi end
                local na1 = (2 * axisAngle - s.a2) % (2 * math.pi)
                if na1 < 0 then na1 = na1 + 2 * math.pi end
                local na2 = na1 + sweep
                nObj = { tip = "yay", cx = rcx, cy = rcy, r = s.r, a1 = na1, a2 = na2, renk = s.renk, cizgiTuru = s.cizgiTuru }
            elseif s.tip == "dikdortgen" then
                local p1x, p1y = mirrorHesapla(x1, y1, x2, y2, s.x1, s.y1)
                local p2x, p2y = mirrorHesapla(x1, y1, x2, y2, s.x2, s.y1)
                local p3x, p3y = mirrorHesapla(x1, y1, x2, y2, s.x2, s.y2)
                local p4x, p4y = mirrorHesapla(x1, y1, x2, y2, s.x1, s.y2)
                local isOrthogonal = (math.abs(x2 - x1) < 0.0001 or math.abs(y2 - y1) < 0.0001)
                if isOrthogonal then
                    nObj = { tip = "dikdortgen", x1 = math.min(p1x, p2x, p3x, p4x), y1 = math.min(p1y, p2y, p3y, p4y), x2 = math.max(p1x, p2x, p3x, p4x), y2 = math.max(p1y, p2y, p3y, p4y), renk = s.renk, cizgiTuru = s.cizgiTuru }
                else
                    table.insert(CAD.sekliller, { tip = "cizgi", x1 = p1x, y1 = p1y, x2 = p2x, y2 = p2y, renk = s.renk, cizgiTuru = s.cizgiTuru })
                    table.insert(CAD.sekliller, { tip = "cizgi", x1 = p2x, y1 = p2y, x2 = p3x, y2 = p3y, renk = s.renk, cizgiTuru = s.cizgiTuru })
                    table.insert(CAD.sekliller, { tip = "cizgi", x1 = p3x, y1 = p3y, x2 = p4x, y2 = p4y, renk = s.renk, cizgiTuru = s.cizgiTuru })
                    table.insert(CAD.sekliller, { tip = "cizgi", x1 = p4x, y1 = p4y, x2 = p1x, y2 = p1y, renk = s.renk, cizgiTuru = s.cizgiTuru })
                end
            elseif s.tip == "text" then
                local rtx, rty = mirrorHesapla(x1, y1, x2, y2, s.tx, s.ty)
                nObj = { tip = "text", tx = rtx, ty = rty, metin = s.metin, punto = s.punto, renk = s.renk }
            end
            if nObj then table.insert(CAD.sekliller, nObj) Grid:ekle(nObj) end
        end
        for _, s in ipairs(CAD.sekliller) do s.secili = false end
        CAD.seciliObjeler = {}
        CAD.aktifSekme().seciliObjeler = {}
        CAD.mirrorEksen = nil
        CAD.mod = "SEC"
        Grid:yenile()
        CAD.komutGirdisi = "MIRROR TAMAMLANDI"
    end
end

function CAD.filletUygula(dfx, dfy)
    local hedef = CAD.objeBul(dfx, dfy)
    if not hedef then return end
    
    if hedef.tip == "dikdortgen" then
        local minX, maxX = math.min(hedef.x1, hedef.x2), math.max(hedef.x1, hedef.x2)
        local minY, maxY = math.min(hedef.y1, hedef.y2), math.max(hedef.y1, hedef.y2)
        local l1 = { tip = "cizgi", x1 = minX, y1 = minY, x2 = maxX, y2 = minY, renk = hedef.renk, cizgiTuru = hedef.cizgiTuru }
        local l2 = { tip = "cizgi", x1 = maxX, y1 = minY, x2 = maxX, y2 = maxY, renk = hedef.renk, cizgiTuru = hedef.cizgiTuru }
        local l3 = { tip = "cizgi", x1 = maxX, y1 = maxY, x2 = minX, y2 = maxY, renk = hedef.renk, cizgiTuru = hedef.cizgiTuru }
        local l4 = { tip = "cizgi", x1 = minX, y1 = maxY, x2 = minX, y2 = minY, renk = hedef.renk, cizgiTuru = hedef.cizgiTuru }
        for i, s in ipairs(CAD.sekliller) do if s == hedef then table.remove(CAD.sekliller, i) break end end
        table.insert(CAD.sekliller, l1) table.insert(CAD.sekliller, l2) table.insert(CAD.sekliller, l3) table.insert(CAD.sekliller, l4)
        Grid:yenile()
        hedef = CAD.objeBul(dfx, dfy)
        if not hedef or hedef.tip ~= "cizgi" then return end
    end
    
    if hedef.tip ~= "cizgi" then CAD.komutGirdisi = "FILLET: Lutfen bir cizgi veya dikdortgen kenari secin!" return end
    
    if #CAD.filletSecilenler == 0 then
        table.insert(CAD.filletSecilenler, { obj = hedef, cx = dfx, cy = dfy })
        hedef.secili = true
        CAD.komutGirdisi = string.format("FILLET (R=%.1f): 2. Cizgiyi/Kenari Secin", CAD.filletRadius or 0)
        return
    elseif #CAD.filletSecilenler == 1 then
        if CAD.filletSecilenler[1].obj == hedef then return end
        table.insert(CAD.filletSecilenler, { obj = hedef, cx = dfx, cy = dfy })
        hedef.secili = true
    end
    
    local f1, f2 = CAD.filletSecilenler[1], CAD.filletSecilenler[2]
    local l1, l2 = f1.obj, f2.obj
    local dx1, dy1 = l1.x2 - l1.x1, l1.y2 - l1.y1
    local dx2, dy2 = l2.x2 - l2.x1, l2.y2 - l2.y1
    local den = dx1 * dy2 - dy1 * dx2
    
    if math.abs(den) < 0.00001 then
        CAD.komutGirdisi = "FILLET: Cizgiler paralel!"
        l1.secili, l2.secili = false, false
        CAD.filletSecilenler = {}
        CAD.mod = "SEC"
        return
    end
    
    local dx3, dy3 = l1.x1 - l2.x1, l1.y1 - l2.y1
    local t1 = (dx2 * dy3 - dy2 * dx3) / den
    local Px = l1.x1 + t1 * dx1
    local Py = l1.y1 + t1 * dy1
    
    local v1x, v1y = f1.cx - Px, f1.cy - Py
    local len1 = math.sqrt(v1x * v1x + v1y * v1y)
    if len1 < 0.001 then
        local d1 = (l1.x1 - Px)^2 + (l1.y1 - Py)^2
        local d2 = (l1.x2 - Px)^2 + (l1.y2 - Py)^2
        v1x = (d1 > d2) and (l1.x1 - Px) or (l1.x2 - Px)
        v1y = (d1 > d2) and (l1.y1 - Py) or (l1.y2 - Py)
        len1 = math.sqrt(v1x * v1x + v1y * v1y)
    end
    local u1x, u1y = v1x / len1, v1y / len1
    
    local v2x, v2y = f2.cx - Px, f2.cy - Py
    local len2 = math.sqrt(v2x * v2x + v2y * v2y)
    if len2 < 0.001 then
        local d1 = (l2.x1 - Px)^2 + (l2.y1 - Py)^2
        local d2 = (l2.x2 - Px)^2 + (l2.y2 - Py)^2
        v2x = (d1 > d2) and (l2.x1 - Px) or (l2.x2 - Px)
        v2y = (d1 > d2) and (l2.y1 - Py) or (l2.y2 - Py)
        len2 = math.sqrt(v2x * v2x + v2y * v2y)
    end
    local u2x, u2y = v2x / len2, v2y / len2
    
    local dot = math.max(-0.99999, math.min(0.99999, u1x * u2x + u1y * u2y))
    local theta = math.acos(dot)
    
    if theta < 0.001 or theta > math.pi - 0.001 then
        CAD.komutGirdisi = "FILLET: Cizgiler duz hat olusturuyor!"
        l1.secili, l2.secili = false, false
        CAD.filletSecilenler = {}
        CAD.mod = "SEC"
        return
    end
    
    local R = CAD.filletRadius or 0
    local function cizgiBudaveUzat(l, P_x, P_y, u_x, u_y, T_x, T_y)
        local p1 = (l.x1 - P_x) * u_x + (l.y1 - P_y) * u_y
        local p2 = (l.x2 - P_x) * u_x + (l.y2 - P_y) * u_y
        if p1 > p2 then l.x2, l.y2 = T_x, T_y else l.x1, l.y1 = T_x, T_y end
    end
    
    if R <= 0 then
        cizgiBudaveUzat(l1, Px, Py, u1x, u1y, Px, Py)
        cizgiBudaveUzat(l2, Px, Py, u2x, u2y, Px, Py)
        CAD.komutGirdisi = "FILLET: Kose Birlestirildi (R=0)"
    else
        local dT = R / math.tan(theta / 2)
        local T1x, T1y = Px + dT * u1x, Py + dT * u1y
        local T2x, T2y = Px + dT * u2x, Py + dT * u2y
        local bx, by = u1x + u2x, u1y + u2y
        local blen = math.sqrt(bx * bx + by * by)
        bx, by = bx / blen, by / blen
        local dC = R / math.sin(theta / 2)
        local Cx, Cy = Px + dC * bx, Py + dC * by
        
        local a1 = math.atan2(T1y - Cy, T1x - Cx)
        local a2 = math.atan2(T2y - Cy, T2x - Cx)
        local aM = math.atan2(-by, -bx)
        local function norm(ang) return (ang % (2 * math.pi) + 2 * math.pi) % (2 * math.pi) end
        a1, a2, aM = norm(a1), norm(a2), norm(aM)
        local diff2 = norm(a2 - a1)
        local diffM = norm(aM - a1)
        local arc_start, arc_end
        if diffM < diff2 then arc_start = a1 arc_end = a1 + diff2
        else arc_start = a2 arc_end = a2 + norm(a1 - a2) end
        
        cizgiBudaveUzat(l1, Px, Py, u1x, u1y, T1x, T1y)
        cizgiBudaveUzat(l2, Px, Py, u2x, u2y, T2x, T2y)
        
        local yayObj = { tip = "yay", cx = Cx, cy = Cy, r = R, a1 = arc_start, a2 = arc_end, renk = l1.renk, cizgiTuru = "surekli" }
        table.insert(CAD.sekliller, yayObj)
        Grid:ekle(yayObj)
        CAD.komutGirdisi = string.format("FILLET TAMAMLANDI (R=%.1f)", R)
    end
    
    l1.secili, l2.secili = false, false
    CAD.filletSecilenler = {}
    CAD.mod = "SEC"
    Grid:yenile()
end

function CAD.hatchUygula(dfx, dfy)
    local tiklanan = CAD.objeBul(dfx, dfy)
    local rClr = CAD.renkSözlüğü[CAD.aktifRenkId]
    if tiklanan and tiklanan.tip == "dikdortgen" then
        local xMin, xMax = math.min(tiklanan.x1, tiklanan.x2), math.max(tiklanan.x1, tiklanan.x2)
        local yMin, yMax = math.min(tiklanan.y1, tiklanan.y2), math.max(tiklanan.y1, tiklanan.y2)
        for k = (xMin - (yMax - yMin)), xMax, 12 do
            local sx1 = math.max(xMin, k)
            local sy1 = yMin + (sx1 - k)
            local sx2 = math.min(xMax, k + (yMax - yMin))
            local sy2 = yMin + (sx2 - k)
            if sy1 <= yMax and sy2 <= yMax and sx1 <= xMax then
                local lObj = { tip = "cizgi", x1 = sx1, y1 = sy1, x2 = sx2, y2 = sy2, renk = rClr, cizgiTuru = "surekli" }
                table.insert(CAD.sekliller, lObj)
                Grid:ekle(lObj)
            end
        end
        CAD.komutGirdisi = "HATCH TARANDI!"
        CAD.mod = "SEC"
        return
    end
    
    local xMin, xMax, yMin, yMax = dfx - 150, dfx + 150, dfy - 150, dfy + 150
    for k = (xMin - (yMax - yMin)), xMax, 12 do
        local lObj = {
            tip = "cizgi",
            x1 = math.max(xMin, k),
            y1 = yMin + (math.max(xMin, k) - k),
            x2 = math.min(xMax, k + (yMax - yMin)),
            y2 = yMin + (math.min(xMax, k + (yMax - yMin)) - k),
            renk = rClr,
            cizgiTuru = "surekli"
        }
        table.insert(CAD.sekliller, lObj)
        Grid:ekle(lObj)
    end
    CAD.komutGirdisi = "SERBEST ALAN TARANDI!"
    CAD.mod = "SEC"
end

-- =============================================================================
-- TRIM MOTORU
-- =============================================================================
local function cizgiKesisimBul(l1, l2)
    local dx1, dy1 = l1.x2 - l1.x1, l1.y2 - l1.y1
    local dx2, dy2 = l2.x2 - l2.x1, l2.y2 - l2.y1
    local den = dx1 * dy2 - dy1 * dx2
    if math.abs(den) < 0.00001 then return nil end
    local dx3, dy3 = l1.x1 - l2.x1, l1.y1 - l2.y1
    local t1 = (dx2 * dy3 - dy2 * dx3) / den
    local t2 = (dx1 * dy3 - dy1 * dx3) / den
    if t1 >= -0.0001 and t1 <= 1.0001 and t2 >= -0.0001 and t2 <= 1.0001 then
        return { x = l1.x1 + t1 * dx1, y = l1.y1 + t1 * dy1, t = t1 }
    end
    return nil
end

local function cemberCizgiKesisim(cx, cy, r, x1, y1, x2, y2)
    local pts = {}
    local dx, dy = x2 - x1, y2 - y1
    local fx, fy = x1 - cx, y1 - cy
    local A = dx*dx + dy*dy
    local B = 2 * (fx*dx + fy*dy)
    local C = fx*fx + fy*fy - r*r
    if A < 0.00001 then return pts end
    local disc = B*B - 4*A*C
    if disc >= 0 then
        local sq = math.sqrt(disc)
        local t1 = (-B - sq) / (2*A)
        local t2 = (-B + sq) / (2*A)
        if t1 >= -0.0001 and t1 <= 1.0001 then table.insert(pts, { x = x1 + t1*dx, y = y1 + t1*dy }) end
        if t2 >= -0.0001 and t2 <= 1.0001 and math.abs(t2 - t1) > 0.0001 then table.insert(pts, { x = x1 + t2*dx, y = y1 + t2*dy }) end
    end
    return pts
end

local function cemberCemberKesisim(c1x, c1y, r1, c2x, c2y, r2)
    local pts = {}
    local dx, dy = c2x - c1x, c2y - c1y
    local d = math.sqrt(dx*dx + dy*dy)
    if d > r1 + r2 + 0.001 or d < math.abs(r1 - r2) - 0.001 or d < 0.0001 then return pts end
    local a = (r1*r1 - r2*r2 + d*d) / (2*d)
    local h2 = math.max(0, r1*r1 - a*a)
    local h = math.sqrt(h2)
    local x0 = c1x + a * dx / d
    local y0 = c1y + a * dy / d
    local rx = -dy * (h / d)
    local ry = dx * (h / d)
    table.insert(pts, { x = x0 + rx, y = y0 + ry })
    if h > 0.001 then table.insert(pts, { x = x0 - rx, y = y0 - ry }) end
    return pts
end

function CAD.trimUygula(dfx, dfy)
    local hedef = CAD.objeBul(dfx, dfy)
    if not hedef then return end
    
    if hedef.tip == "cizgi" then
        local x1, x2, y1, y2 = CAD.nesneAABB(hedef)
        local adaylar = Grid:sorgulaKutu(x1, x2, y1, y2)
        local kesisimler = {}
        for _, s in ipairs(adaylar) do
            if s ~= hedef then
                if s.tip == "cizgi" then
                    local pt = cizgiKesisimBul(hedef, s)
                    if pt then table.insert(kesisimler, pt) end
                elseif s.tip == "dikdortgen" then
                    local minX, maxX = math.min(s.x1, s.x2), math.max(s.x1, s.x2)
                    local minY, maxY = math.min(s.y1, s.y2), math.max(s.y1, s.y2)
                    local kenarlar = { {x1=minX, y1=minY, x2=maxX, y2=minY}, {x1=maxX, y1=minY, x2=maxX, y2=maxY}, {x1=maxX, y1=maxY, x2=minX, y2=maxY}, {x1=minX, y1=maxY, x2=minX, y2=minY} }
                    for _, k in ipairs(kenarlar) do local pt = cizgiKesisimBul(hedef, k) if pt then table.insert(kesisimler, pt) end end
                elseif s.tip == "cember" or s.tip == "yay" then
                    local pts = cemberCizgiKesisim(s.cx, s.cy, s.r, hedef.x1, hedef.y1, hedef.x2, hedef.y2)
                    local lLen2 = (hedef.x2 - hedef.x1)^2 + (hedef.y2 - hedef.y1)^2
                    for _, p in ipairs(pts) do
                        local t = ((p.x - hedef.x1)*(hedef.x2 - hedef.x1) + (p.y - hedef.y1)*(hedef.y2 - hedef.y1)) / lLen2
                        table.insert(kesisimler, { x = p.x, y = p.y, t = t })
                    end
                end
            end
        end
        if #kesisimler == 0 then
            for i, s in ipairs(CAD.sekliller) do if s == hedef then table.remove(CAD.sekliller, i) break end end
            Grid:yenile()
            CAD.komutGirdisi = "TRIM: Cizgi silindi!"
            return
        end
        table.sort(kesisimler, function(a, b) return a.t < b.t end)
        local l2 = (hedef.x1 - hedef.x2)^2 + (hedef.y1 - hedef.y2)^2
        local t_fare = ((dfx - hedef.x1) * (hedef.x2 - hedef.x1) + (dfy - hedef.y1) * (hedef.y2 - hedef.y1)) / l2
        for i, s in ipairs(CAD.sekliller) do if s == hedef then table.remove(CAD.sekliller, i) break end end
        local noktalar = { { x = hedef.x1, y = hedef.y1, t = 0 } }
        for _, pt in ipairs(kesisimler) do table.insert(noktalar, pt) end
        table.insert(noktalar, { x = hedef.x2, y = hedef.y2, t = 1 })
        for i = 1, #noktalar - 1 do
            local p1, p2 = noktalar[i], noktalar[i+1]
            if not (t_fare >= p1.t and t_fare <= p2.t) then
                table.insert(CAD.sekliller, { tip = "cizgi", x1 = p1.x, y1 = p1.y, x2 = p2.x, y2 = p2.y, renk = hedef.renk, cizgiTuru = hedef.cizgiTuru })
            end
        end
        Grid:yenile()
        CAD.komutGirdisi = "TRIM: Cizgi budandi!"
        return
    elseif hedef.tip == "cember" or hedef.tip == "yay" then
        local x1, x2, y1, y2 = CAD.nesneAABB(hedef)
        local adaylar = Grid:sorgulaKutu(x1, x2, y1, y2)
        local kesisimNoktalari = {}
        for _, s in ipairs(adaylar) do
            if s ~= hedef then
                if s.tip == "cizgi" then
                    local pts = cemberCizgiKesisim(hedef.cx, hedef.cy, hedef.r, s.x1, s.y1, s.x2, s.y2)
                    for _, p in ipairs(pts) do table.insert(kesisimNoktalari, p) end
                elseif s.tip == "dikdortgen" then
                    local minX, maxX = math.min(s.x1, s.x2), math.max(s.x1, s.x2)
                    local minY, maxY = math.min(s.y1, s.y2), math.max(s.y1, s.y2)
                    local kenarlar = { {x1=minX, y1=minY, x2=maxX, y2=minY}, {x1=maxX, y1=minY, x2=maxX, y2=maxY}, {x1=maxX, y1=maxY, x2=minX, y2=maxY}, {x1=minX, y1=maxY, x2=minX, y2=minY} }
                    for _, k in ipairs(kenarlar) do
                        local pts = cemberCizgiKesisim(hedef.cx, hedef.cy, hedef.r, k.x1, k.y1, k.x2, k.y2)
                        for _, p in ipairs(pts) do table.insert(kesisimNoktalari, p) end
                    end
                elseif s.tip == "cember" or s.tip == "yay" then
                    local pts = cemberCemberKesisim(hedef.cx, hedef.cy, hedef.r, s.cx, s.cy, s.r)
                    for _, p in ipairs(pts) do table.insert(kesisimNoktalari, p) end
                end
            end
        end
        local function norm(ang) return (ang % (2 * math.pi) + 2 * math.pi) % (2 * math.pi) end
        local acilar = {}
        for _, p in ipairs(kesisimNoktalari) do
            local ang = norm(math.atan2(p.y - hedef.cy, p.x - hedef.cx))
            local duplicate = false
            for _, varolan in ipairs(acilar) do if math.abs(norm(ang - varolan)) < 0.005 then duplicate = true break end end
            if not duplicate then table.insert(acilar, ang) end
        end
        if hedef.tip == "cember" then
            if #acilar < 2 then CAD.komutGirdisi = "TRIM: Daireyi kesecek en az 2 kesisim noktasi yok!" return end
            table.sort(acilar)
            local fareAci = norm(math.atan2(dfy - hedef.cy, dfx - hedef.cx))
            local parcalar = {}
            local k = #acilar
            for i = 1, k do
                local a_start = acilar[i]
                local a_end = (i == k) and (acilar[1] + 2 * math.pi) or acilar[i+1]
                table.insert(parcalar, { start = a_start, finish = a_end })
            end
            local silinecekIndex = nil
            for i, seg in ipairs(parcalar) do
                local sA, eA = seg.start, seg.finish
                local mAng = fareAci
                if mAng < sA then mAng = mAng + 2 * math.pi end
                if mAng >= sA and mAng <= eA then silinecekIndex = i break end
            end
            for i, s in ipairs(CAD.sekliller) do if s == hedef then table.remove(CAD.sekliller, i) break end end
            for i, seg in ipairs(parcalar) do
                if i ~= silinecekIndex then
                    local yayObj = { tip = "yay", cx = hedef.cx, cy = hedef.cy, r = hedef.r, a1 = norm(seg.start), a2 = norm(seg.finish), renk = hedef.renk, cizgiTuru = hedef.cizgiTuru }
                    table.insert(CAD.sekliller, yayObj)
                end
            end
            Grid:yenile()
            CAD.komutGirdisi = "TRIM: Daire budandi!"
            return
        elseif hedef.tip == "yay" then
            if #acilar == 0 then
                for i, s in ipairs(CAD.sekliller) do if s == hedef then table.remove(CAD.sekliller, i) break end end
                Grid:yenile()
                CAD.komutGirdisi = "TRIM: Yay silindi!"
                return
            end
            local hA1, hA2 = norm(hedef.a1), norm(hedef.a2)
            local sweep = norm(hA2 - hA1)
            local yayAcilari = {}
            for _, a in ipairs(acilar) do
                local rel = norm(a - hA1)
                if rel > 0.005 and rel < sweep - 0.005 then table.insert(yayAcilari, rel) end
            end
            if #yayAcilari == 0 then CAD.komutGirdisi = "TRIM: Yayi kesen nokta yok!" return end
            table.sort(yayAcilari)
            local fareRel = norm(norm(math.atan2(dfy - hedef.cy, dfx - hedef.cx)) - hA1)
            local nokts = { 0 }
            for _, v in ipairs(yayAcilari) do table.insert(nokts, v) end
            table.insert(nokts, sweep)
            for i, s in ipairs(CAD.sekliller) do if s == hedef then table.remove(CAD.sekliller, i) break end end
            for i = 1, #nokts - 1 do
                local pStart, pEnd = nokts[i], nokts[i+1]
                if not (fareRel >= pStart and fareRel <= pEnd) then
                    table.insert(CAD.sekliller, { tip = "yay", cx = hedef.cx, cy = hedef.cy, r = hedef.r, a1 = norm(hA1 + pStart), a2 = norm(hA1 + pEnd), renk = hedef.renk, cizgiTuru = hedef.cizgiTuru })
                end
            end
            Grid:yenile()
            CAD.komutGirdisi = "TRIM: Yay budandi!"
            return
        end
    end
end

-- =============================================================================
-- ÇİZİM VE ARAYÜZ (RENDER) MOTORU
-- =============================================================================
ARAYUZ = {}

function ARAYUZ.stilliCizgiCiz(x1, y1, x2, y2, tur)
    if not tur or tur == "surekli" or CAD.kamera.zoom < 0.25 then love.graphics.line(x1, y1, x2, y2) return end
    local dx, dy = x2 - x1, y2 - y1
    local uzaklik = math.sqrt(dx * dx + dy * dy)
    if uzaklik == 0 then return end
    local nx, ny = dx / uzaklik, dy / uzaklik
    local mevcut, adim = 0, 0
    while mevcut < uzaklik do
        if tur == "kesikli" then
            local segment = math.min(8, uzaklik - mevcut)
            if segment <= 0 then break end
            if adim % 2 == 0 then love.graphics.line(x1 + nx * mevcut, y1 + ny * mevcut, x1 + nx * (mevcut + segment), y1 + ny * (mevcut + segment)) end
            mevcut = mevcut + segment adim = adim + 1
        elseif tur == "aks" then
            if adim == 0 then
                local seg = math.min(15, uzaklik - mevcut)
                if seg <= 0 then break end
                love.graphics.line(x1 + nx * mevcut, y1 + ny * mevcut, x1 + nx * (mevcut + seg), y1 + ny * (mevcut + seg))
                mevcut = mevcut + seg adim = 1
            elseif adim == 1 or adim == 3 then
                local b = math.min(5, uzaklik - mevcut)
                if b <= 0 then break end
                mevcut = mevcut + b adim = (adim == 1) and 2 or 0
            elseif adim == 2 then
                local seg = math.min(3, uzaklik - mevcut)
                if seg <= 0 then break end
                love.graphics.line(x1 + nx * mevcut, y1 + ny * mevcut, x1 + nx * (mevcut + seg), y1 + ny * (mevcut + seg))
                mevcut = mevcut + seg adim = 3
            end
        else
            love.graphics.line(x1, y1, x2, y2) break
        end
    end
end

function ARAYUZ.olcuOkuCiz(x1, y1, x2, y2, offset, metin, punto, renk)
    local dx, dy = x2 - x1, y2 - y1
    local len = math.sqrt(dx * dx + dy * dy)
    if len == 0 then return end
    local nx, ny = -dy / len, dx / len
    local off = offset or 25
    if math.abs(off) < 0.001 then off = 25 end
    
    local ox1, oy1 = x1 + nx * off, y1 + ny * off
    local ox2, oy2 = x2 + nx * off, y2 + ny * off
    
    love.graphics.setColor(renk or {1, 1, 1, 1})
    local lWidth = math.max(1, 1.5 / CAD.kamera.zoom)
    love.graphics.setLineWidth(lWidth)
    
    -- Ana Ölçü Çizgisi
    love.graphics.line(ox1, oy1, ox2, oy2)
    local asim = (off >= 0 and 6 or -6) / CAD.kamera.zoom
    -- Bağlantı Bacakları
    love.graphics.line(x1, y1, ox1 + nx * asim, oy1 + ny * asim)
    love.graphics.line(x2, y2, ox2 + nx * asim, oy2 + ny * asim)
    
    -- Mimari Çentikler (Ticks)
    local tx, ty = dx / len, dy / len
    local bSize = 6 / CAD.kamera.zoom
    love.graphics.line(ox1 - tx*bSize - nx*bSize, oy1 - ty*bSize - ny*bSize, ox1 + tx*bSize + nx*bSize, oy1 + ty*bSize + ny*bSize)
    love.graphics.line(ox2 - tx*bSize - nx*bSize, oy2 - ty*bSize - ny*bSize, ox2 + tx*bSize + nx*bSize, oy2 + ty*bSize + ny*bSize)
    
    -- Dikey/Yatay Metin Yerleşimi
    local p = punto or CAD.aktifFontBoyutu or 14
    local f = getCachedFont(p)
    love.graphics.setFont(f)
    local cx, cy = (ox1 + ox2) / 2, (oy1 + oy2) / 2
    local txtW = f:getWidth(metin)
    local txtH = f:getHeight()

    local aci = math.atan2(dy, dx)
    if aci > math.pi * 0.5 + 0.0001 then aci = aci - math.pi
    elseif aci < -math.pi * 0.5 + 0.0001 then aci = aci + math.pi end
    
    love.graphics.push()
    love.graphics.translate(cx, cy)
    love.graphics.rotate(aci)
    love.graphics.print(metin, -txtW / 2, -txtH - (3 / CAD.kamera.zoom))
    love.graphics.pop()
end

function ARAYUZ.dunyaCiz(dfx, dfy)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local sol, ust = CAD.ekrandanDunyaya(0, 0)
    local sag, alt = CAD.ekrandanDunyaya(w, h)
    local vMinX, vMaxX = math.min(sol, sag), math.max(sol, sag)
    local vMinY, vMaxY = math.min(ust, alt), math.max(ust, alt)
    
    local dinamikIzgara = CAD.temelIzgaraBoyutu * CAD.birimCarpanlari[CAD.aktifBirim]
    love.graphics.setLineWidth(1 / CAD.kamera.zoom)
    love.graphics.setColor(0.18, 0.18, 0.18)
    for x = math.floor(vMinX / dinamikIzgara) * dinamikIzgara, vMaxX, dinamikIzgara do love.graphics.line(x, vMinY, x, vMaxY) end
    for y = math.floor(vMinY / dinamikIzgara) * dinamikIzgara, vMaxY, dinamikIzgara do love.graphics.line(vMinX, y, vMaxX, y) end
    
    love.graphics.setLineWidth(1.5 / CAD.kamera.zoom)
    love.graphics.setColor(0.6, 0.2, 0.2) love.graphics.line(vMinX, 0, vMaxX, 0)
    love.graphics.setColor(0.2, 0.6, 0.2) love.graphics.line(0, vMinY, 0, vMaxY)
    
    local cizilecekler = Grid:sorgulaKutu(vMinX, vMaxX, vMinY, vMaxY)
    
    for i = 1, #cizilecekler do
        local s = cizilecekler[i]
        if s.secili then
            love.graphics.setColor(1, 0.2, 0.2)
            love.graphics.setLineWidth(2.5 / CAD.kamera.zoom)
        else
            love.graphics.setColor(s.renk or {1, 1, 1, 1})
            love.graphics.setLineWidth(1.8 / CAD.kamera.zoom)
        end
        
        if s.tip == "cizgi" then
            ARAYUZ.stilliCizgiCiz(s.x1, s.y1, s.x2, s.y2, s.cizgiTuru)
        elseif s.tip == "dikdortgen" then
            ARAYUZ.stilliCizgiCiz(s.x1, s.y1, s.x2, s.y1, s.cizgiTuru)
            ARAYUZ.stilliCizgiCiz(s.x2, s.y1, s.x2, s.y2, s.cizgiTuru)
            ARAYUZ.stilliCizgiCiz(s.x2, s.y2, s.x1, s.y2, s.cizgiTuru)
            ARAYUZ.stilliCizgiCiz(s.x1, s.y2, s.x1, s.y1, s.cizgiTuru)
        elseif s.tip == "cember" then
            love.graphics.circle("line", s.cx, s.cy, s.r)
        elseif s.tip == "yay" then
            love.graphics.arc("line", "open", s.cx, s.cy, s.r, s.a1, s.a2)
        elseif s.tip == "dimension" then
            local c = s.secili and {1, 0.2, 0.2, 1} or (s.renk or {1, 1, 1, 1})
            ARAYUZ.olcuOkuCiz(s.x1, s.y1, s.x2, s.y2, s.offset, s.metin, s.punto, c)
        elseif s.tip == "text" then
            love.graphics.setColor(s.renk or {1, 1, 1, 1})
            local f = getCachedFont(s.punto or CAD.aktifFontBoyutu)
            love.graphics.setFont(f)
            love.graphics.print(s.metin, s.tx, s.ty)
        end
    end
    
    if CAD.mod == "MIRROR" and CAD.mirrorEksen then
        mirrorOnizlemeCiz(CAD.mirrorEksen.x1, CAD.mirrorEksen.y1, dfx, dfy)
    end

    if CAD.mod == "SCALE_REF_2" and CAD.scaleRefP1 then
        love.graphics.setColor(0.1, 0.8, 1, 0.8)
        love.graphics.setLineWidth(1.8 / CAD.kamera.zoom)
        love.graphics.line(CAD.scaleRefP1.x, CAD.scaleRefP1.y, dfx, dfy)
        local curDist = math.sqrt((dfx - CAD.scaleRefP1.x)^2 + (dfy - CAD.scaleRefP1.y)^2)
        local carpan = CAD.birimCarpanlari[CAD.aktifBirim] or 1
        local f = getCachedFont(14)
        love.graphics.setFont(f)
        love.graphics.print(string.format("Referans Mesafe: %.2f %s", curDist / carpan, CAD.aktifBirim), dfx + 15 / CAD.kamera.zoom, dfy - 15 / CAD.kamera.zoom)
    end
    
    if (CAD.mod == "SCALE_FACTOR" or CAD.mod == "SCALE_REF_1" or CAD.mod == "SCALE_REF_2" or CAD.mod == "SCALE_NEW_LEN") and CAD.scaleBase then
        love.graphics.setColor(1, 0.3, 0.1, 0.9)
        local sB = 10 / CAD.kamera.zoom
        love.graphics.circle("line", CAD.scaleBase.x, CAD.scaleBase.y, sB)
        love.graphics.line(CAD.scaleBase.x - sB, CAD.scaleBase.y, CAD.scaleBase.x + sB, CAD.scaleBase.y)
        love.graphics.line(CAD.scaleBase.x, CAD.scaleBase.y - sB, CAD.scaleBase.x, CAD.scaleBase.y + sB)
    end
    
    if CAD.mod == "ROTATE" and CAD.manipulasyonBase then
        local bx, by = CAD.manipulasyonBase.x, CAD.manipulasyonBase.y
        local rawAngle = math.atan2(dfy - by, dfx - bx)
        local deg = math.deg(rawAngle)
        local snapDeg = (math.floor((deg + 45) / 90) * 90) % 360
        local snapRad = math.rad(snapDeg)
        love.graphics.setColor(1, 0.8, 0, 0.4)
        love.graphics.setLineWidth(1 / CAD.kamera.zoom)
        local rayLen = math.max(120 / CAD.kamera.zoom, math.sqrt((dfx - bx)^2 + (dfy - by)^2))
        love.graphics.line(bx, by, bx + rayLen * math.cos(snapRad), by + rayLen * math.sin(snapRad))
        love.graphics.setColor(1, 0.9, 0.2)
        local f = getCachedFont(16)
        love.graphics.setFont(f)
        love.graphics.print(string.format("ROTATE: %d°", snapDeg), dfx + 18 / CAD.kamera.zoom, dfy - 18 / CAD.kamera.zoom)
        love.graphics.setColor(1, 0.8, 0.2, 0.65)
        love.graphics.setLineWidth(2 / CAD.kamera.zoom)
        for _, s in ipairs(CAD.seciliObjeler) do
            local g = kopyaDondur(s, bx, by, snapRad)
            if g then
                if g.tip == "cizgi" then love.graphics.line(g.x1, g.y1, g.x2, g.y2)
                elseif g.tip == "dikdortgen" then love.graphics.rectangle("line", math.min(g.x1, g.x2), math.min(g.y1, g.y2), math.abs(g.x2 - g.x1), math.abs(g.y2 - g.y1))
                elseif g.tip == "cember" then love.graphics.circle("line", g.cx, g.cy, g.r)
                elseif g.tip == "yay" then love.graphics.arc("line", "open", g.cx, g.cy, g.r, g.a1, g.a2)
                elseif g.tip == "dimension" then ARAYUZ.olcuOkuCiz(g.x1, g.y1, g.x2, g.y2, g.offset, g.metin, g.punto, {1, 0.8, 0.2, 0.7})
                elseif g.tip == "text" then love.graphics.print(g.metin, g.tx, g.ty) end
            end
        end
    elseif (CAD.mod == "MOVE" or CAD.mod == "COPY" or CAD.mod == "ARRAY_POLAR_CENTER") and CAD.manipulasyonBase then
        love.graphics.setColor(1, 1, 0, 0.5)
        love.graphics.setLineWidth(1 / CAD.kamera.zoom)
        love.graphics.line(CAD.manipulasyonBase.x, CAD.manipulasyonBase.y, dfx, dfy)
    end
    
    love.graphics.setColor(1, 0.5, 0)
    love.graphics.setLineWidth(2 / CAD.kamera.zoom)
    if CAD.mod == "CIZGI" and CAD.geciciCizgi then
        ARAYUZ.stilliCizgiCiz(CAD.geciciCizgi.x1, CAD.geciciCizgi.y1, CAD.geciciCizgi.x2, CAD.geciciCizgi.y2, CAD.aktifCizgiTuru)
    end
    if CAD.mod == "CEMBER" and CAD.geciciCember then
        love.graphics.circle("line", CAD.geciciCember.cx, CAD.geciciCember.cy, CAD.geciciCember.r)
    end
    if CAD.mod == "DIKDORTGEN" and CAD.geciciDikdortgen then
        local g = CAD.geciciDikdortgen
        ARAYUZ.stilliCizgiCiz(g.x1, g.y1, g.x2, g.y1, CAD.aktifCizgiTuru)
        ARAYUZ.stilliCizgiCiz(g.x2, g.y1, g.x2, g.y2, CAD.aktifCizgiTuru)
        ARAYUZ.stilliCizgiCiz(g.x2, g.y2, g.x1, g.y2, CAD.aktifCizgiTuru)
        ARAYUZ.stilliCizgiCiz(g.x1, g.y2, g.x1, g.y1, CAD.aktifCizgiTuru)
    end
    if CAD.mod == "YAY" and CAD.geciciYay then
        love.graphics.setColor(1, 0.5, 0, 0.7)
        if CAD.geciciYay.x2 then
            local ux, uy, r, a1, a3 = CAD.ucNoktadanCember(CAD.geciciYay.x1, CAD.geciciYay.y1, CAD.geciciYay.x2, CAD.geciciYay.y2, dfx, dfy)
            if ux then love.graphics.arc("line", "open", ux, uy, r, a1, a3) end
        else
            love.graphics.line(CAD.geciciYay.x1, CAD.geciciYay.y1, dfx, dfy)
        end
    end
    if CAD.mod == "DIM_2" and CAD.geciciDim then
        love.graphics.setColor(1, 0.5, 0, 0.6)
        love.graphics.line(CAD.geciciDim.x1, CAD.geciciDim.y1, CAD.geciciDim.x2 or dfx, CAD.geciciDim.y2 or dfy)
    elseif CAD.mod == "DIM_3" and CAD.geciciDim then
        local g = CAD.geciciDim
        local dx, dy = g.x2 - g.x1, g.y2 - g.y1
        local len = math.sqrt(dx * dx + dy * dy)
        if len > 0 then
            local nx, ny = -dy / len, dx / len
            local dist = (dfx - g.x1) * nx + (dfy - g.y1) * ny
            local carpan = CAD.birimCarpanlari[CAD.aktifBirim]
            local metin = string.format("%.2f %s", len / carpan, CAD.aktifBirim)
            ARAYUZ.olcuOkuCiz(g.x1, g.y1, g.x2, g.y2, dist, metin, CAD.aktifFontBoyutu, { 1, 0.5, 0, 0.8 })
        end
    elseif CAD.mod == "DIM_CONT" and CAD.geciciDim and CAD.sonDimBilgi then
        local g = CAD.geciciDim
        local dx, dy = g.x2 - g.x1, g.y2 - g.y1
        local len = math.sqrt(dx * dx + dy * dy)
        if len > 0.001 then
            local carpan = CAD.birimCarpanlari[CAD.aktifBirim]
            local metin = string.format("%.2f %s", len / carpan, CAD.aktifBirim)
            ARAYUZ.olcuOkuCiz(g.x1, g.y1, g.x2, g.y2, CAD.sonDimBilgi.offset, metin, CAD.aktifFontBoyutu, { 1, 0.6, 0.1, 0.85 })
        end
    end
    
    if CAD.secimKutusu then
        love.graphics.setColor(0.1, 0.5, 1, 0.2)
        love.graphics.rectangle("fill", CAD.secimKutusu.x1, CAD.secimKutusu.y1, dfx - CAD.secimKutusu.x1, dfy - CAD.secimKutusu.y1)
        love.graphics.setColor(0.1, 0.6, 1, 0.8)
        love.graphics.rectangle("line", CAD.secimKutusu.x1, CAD.secimKutusu.y1, dfx - CAD.secimKutusu.x1, dfy - CAD.secimKutusu.y1)
    end

    -- OSNAP GÖRSEL İŞARETÇİSİ (CANLI VE NET)
    if CAD.aktifOsnap then
        love.graphics.setColor(0, 1, 0.2, 1)
        love.graphics.setLineWidth(2.2 / CAD.kamera.zoom)
        local sB = 10 / CAD.kamera.zoom
        local ox, oy = CAD.aktifOsnap.x, CAD.aktifOsnap.y
        if CAD.aktifOsnap.tip and CAD.aktifOsnap.tip:find("En Yakin") then
            -- En Yakın (Nearest) -> Kum saati ikonu
            love.graphics.line(ox - sB/2, oy - sB/2, ox + sB/2, oy + sB/2)
            love.graphics.line(ox - sB/2, oy + sB/2, ox + sB/2, oy - sB/2)
            love.graphics.line(ox - sB/2, oy - sB/2, ox + sB/2, oy - sB/2)
            love.graphics.line(ox - sB/2, oy + sB/2, ox + sB/2, oy + sB/2)
        elseif CAD.aktifOsnap.tip and (CAD.aktifOsnap.tip:find("Merkez") or CAD.aktifOsnap.tip:find("Kutup")) then
            -- Dairesel Merkez / Kutup -> Daire ikonu
            love.graphics.circle("line", ox, oy, sB/2)
            love.graphics.line(ox - sB/2, oy, ox + sB/2, oy)
            love.graphics.line(ox, oy - sB/2, ox, oy + sB/2)
        elseif CAD.aktifOsnap.tip and CAD.aktifOsnap.tip:find("Orta") then
            -- Orta Nokta (Midpoint) -> Üçgen ikonu
            love.graphics.polygon("line", ox, oy - sB*0.6, ox + sB*0.6, oy + sB*0.5, ox - sB*0.6, oy + sB*0.5)
        else
            -- Köşe ve Uç Nokta -> Kare ikonu
            love.graphics.rectangle("line", ox - sB/2, oy - sB/2, sB, sB)
        end
        love.graphics.setColor(0, 1, 0.2, 0.8)
        local f = getCachedFont(12)
        love.graphics.setFont(f)
        love.graphics.print(CAD.aktifOsnap.tip or "", ox + 10 / CAD.kamera.zoom, oy - 14 / CAD.kamera.zoom)
    end
end

function ARAYUZ.panelleriCiz(dfx, dfy)
    local h, w = love.graphics.getHeight(), love.graphics.getWidth()
    local fx, fy = love.mouse.getPosition()
    local carpan = CAD.birimCarpanlari[CAD.aktifBirim]
    
    -- Alt Durum Çubuğu
    love.graphics.setColor(0.08, 0.08, 0.08, 0.95)
    love.graphics.rectangle("fill", 0, h - 35, w, 35)
    love.graphics.setColor(0.9, 0.9, 0.9)
    love.graphics.print(string.format("X: %.2f | Y: %.2f (%s) | FPS: %d", dfx / carpan, dfy / carpan, CAD.aktifBirim, love.timer.getFPS()), 20, h - 25)
    love.graphics.setColor(0, 1, 0)
    love.graphics.print(CAD.aktifOsnap and "OSNAP: " .. (CAD.aktifOsnap.tip or "Bosta") or "OSNAP: BOSTA", w - 550, h - 25)
    love.graphics.setColor(1, 0.4, 0.4)
    love.graphics.print("SECILI: " .. #CAD.seciliObjeler .. " / TOPLAM: " .. #CAD.sekliller, w - 400, h - 25)
    love.graphics.setColor(0.9, 0.9, 0.9)
    love.graphics.print("ORTHO (F8): " .. (CAD.orthoModu and "ACIK" or "KAPALI"), w - 170, h - 25)
    
    -- Üst Menü Paneli
    love.graphics.setColor(0.05, 0.05, 0.05, 0.88)
    love.graphics.rectangle("fill", 10, 5, 1060, 58, 4, 4)
    
    for _, b in ipairs(CAD.butonlar) do
        if CAD.aktifBirim == b.id then love.graphics.setColor(0.1, 0.6, 0.1)
        elseif fx >= b.x and fx <= b.x + b.w and fy >= b.y + 9 and fy <= b.y + 9 + b.h then love.graphics.setColor(0.3, 0.3, 0.3)
        else love.graphics.setColor(0.15, 0.15, 0.15) end
        love.graphics.rectangle("fill", b.x, b.y + 9, b.w, b.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(b.etiket, b.x + 10, b.y + 17)
    end
    for _, b in ipairs(CAD.renkButonlari) do
        if CAD.aktifRenkId == b.id then love.graphics.setColor(0.1, 0.5, 0.1)
        elseif fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then love.graphics.setColor(0.25, 0.25, 0.25)
        else love.graphics.setColor(0.12, 0.12, 0.12) end
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h, 3, 3)
        love.graphics.setColor(b.renk)
        love.graphics.print(b.etiket, b.x + 6, b.y + 3)
    end
    for _, b in ipairs(CAD.cizgiTuruButonlari) do
        if CAD.aktifCizgiTuru == b.id then love.graphics.setColor(0, 0.6, 0.5)
        elseif fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then love.graphics.setColor(0.25, 0.25, 0.25)
        else love.graphics.setColor(0.12, 0.12, 0.12) end
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h, 3, 3)
        love.graphics.setColor(0.9, 0.9, 0.9)
        love.graphics.print(b.etiket, b.x + 4, b.y + 3)
    end
    for _, b in ipairs(CAD.fontButonlari) do
        if fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then love.graphics.setColor(0.3, 0.3, 0.3)
        else love.graphics.setColor(0.16, 0.16, 0.16) end
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h, 3, 3)
        love.graphics.setColor(1, 0.9, 0.4)
        love.graphics.print(b.etiket, b.x + 5, b.y + 3)
    end
    for _, b in ipairs(CAD.aracButonlari) do
        if fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then
            if b.id == "exp_pdf" then love.graphics.setColor(0.8, 0.2, 0.2) else love.graphics.setColor(0.7, 0.3, 0.1) end
        else
            if b.id == "exp_pdf" then love.graphics.setColor(0.35, 0.12, 0.12) else love.graphics.setColor(0.22, 0.18, 0.16) end
        end
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(b.etiket, b.x + 6, b.y + 3)
    end
    for _, b in ipairs(CAD.dosyaButonlari) do
        if fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then love.graphics.setColor(0, 0.4, 0.8)
        else love.graphics.setColor(0.16, 0.16, 0.16) end
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(b.etiket, b.x + 6, b.y + 3)
    end
    
    -- Komut Konsolu
    love.graphics.setColor(0.05, 0.05, 0.05, 0.88)
    love.graphics.rectangle("fill", 10, 68, 1060, 40, 4, 4)
    love.graphics.setColor(1, 1, 1)
    if CAD.mod == "SEC" then
        love.graphics.print("Komutlar (L, C, REC, A, DIM, T, TR, F, MI, H, M, RO, SC, CO, O, EX, AR, FS, PDF, E) | Ctrl+S / Ctrl+C/V: " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "SCALE_BASE" then
        love.graphics.setColor(0.2, 0.9, 1)
        love.graphics.print("SCALE: Olcekleme Merkez / Referans (Taban) Noktasini Tiklayin!", 20, 80)
    elseif CAD.mod == "SCALE_FACTOR" then
        love.graphics.setColor(1, 0.9, 0.2)
        love.graphics.print("SCALE: Olcek Carpani girin VEYA Referans Modu icin 'R' yazip Enter: " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "SCALE_REF_1" then
        love.graphics.setColor(0.2, 0.9, 1)
        love.graphics.print("SCALE (Referans): 1. Noktayi Tiklayin (veya mevcut boyutu yazin): " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "SCALE_REF_2" then
        love.graphics.setColor(0.2, 0.9, 1)
        love.graphics.print("SCALE (Referans): 2. Noktayi Tiklayin:", 20, 80)
    elseif CAD.mod == "SCALE_NEW_LEN" then
        love.graphics.setColor(0.2, 1, 0.4)
        local carpan = CAD.birimCarpanlari[CAD.aktifBirim] or 1
        local refGoster = CAD.scaleRefLen and string.format("(Mevcut: %.2f %s)", CAD.scaleRefLen / carpan, CAD.aktifBirim) or ""
        love.graphics.print(string.format("SCALE: Hedef Boyutu Girin %s ve Enter: %s", refGoster, CAD.komutGirdisi), 20, 80)
    elseif CAD.mod == "TRIM" then
        love.graphics.setColor(1, 0.4, 0.4)
        love.graphics.print("TRIM MODU: Budanacak cizgiye veya daire yayina tiklayin!", 20, 80)
    elseif CAD.mod == "ROTATE" then
        love.graphics.setColor(1, 0.9, 0.2)
        love.graphics.print("ROTATE MODU: Fareyi hareket ettirin (0, 90, 180, 270 kilitli). Tiklayarak sabitleyin!", 20, 80)
    elseif CAD.mod == "FILLET" then
        love.graphics.setColor(0.2, 1, 0.4)
        love.graphics.print("FILLET (R=" .. CAD.filletRadius .. "): Yuvarlanacak cizgileri tiklayin", 20, 80)
    elseif CAD.mod == "FILLET_RAD" then
        love.graphics.print("Yeni Fillet Yaricapi girin (Kose icin 0) ve Enter: " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "FONT_SIZE" then
        love.graphics.print("Yeni Font Boyutu Girin (6-72) ve Enter: " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "ARRAY_MENU" then
        love.graphics.setColor(1, 0.9, 0.2)
        love.graphics.print("ARRAY: [1] Rectangular (Izgara)  [2] Polar (Dairesel)  [3] Path (Yol)", 20, 80)
    elseif CAD.mod == "ARRAY_RECT_COUNTS" then
        love.graphics.print("Rect Array: Satir,Sutun girin (Orn: 3,3) ve Enter: " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "ARRAY_RECT_SPACING" then
        love.graphics.print("Rect Array: X,Y araligi (Orn: 50,50) ve Enter: " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "ARRAY_POLAR_PARAMS" then
        love.graphics.print("Polar Array: Adet,Aci (Orn: 6,360) ve Enter: " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "ARRAY_POLAR_CENTER" then
        love.graphics.print("Polar Array: Donus Merkez Noktasini Tiklayin!", 20, 80)
    elseif CAD.mod == "ARRAY_PATH_COUNT" then
        love.graphics.print("Path Array: Adet girin ve Enter: " .. CAD.komutGirdisi, 20, 80)
    elseif CAD.mod == "ARRAY_PATH_SELECT" then
        love.graphics.print("Path Array: Yol cizgisini tiklayin!", 20, 80)
    elseif CAD.mod == "DIM_1" then
        love.graphics.setColor(0.2, 0.9, 1)
        love.graphics.print("DIM: 1. Noktayi Tiklayin (F8: Ortho Modu " .. (CAD.orthoModu and "ACIK" or "KAPALI") .. ")", 20, 80)
    elseif CAD.mod == "DIM_2" then
        love.graphics.setColor(0.2, 0.9, 1)
        love.graphics.print("DIM: 2. Noktayi Tiklayin (F8: Ortho Kilitli " .. (CAD.orthoModu and "[AKTIF]" or "[PASIF]") .. ")", 20, 80)
    elseif CAD.mod == "DIM_3" then
        love.graphics.setColor(1, 0.8, 0.2)
        love.graphics.print("DIM: Olcu Cizgisi Konumunu Tiklayin (Hizalamak icin baska olcuye de tiklayabilirsiniz)", 20, 80)
    elseif CAD.mod == "DIM_CONT" then
        love.graphics.setColor(0.2, 1, 0.4)
        love.graphics.print("SERI OLCU (DIM CONT): Sonraki noktayi tiklayin (F8: Ortho " .. (CAD.orthoModu and "ACIK" or "KAPALI") .. " | Cikis: ESC / Sag Tik)", 20, 80)
    elseif CAD.mod == "TEXT_INPUT" then
        love.graphics.print("Yazi Girin ve Enter: " .. CAD.komutGirdisi, 20, 80)
    else
        love.graphics.print("Mod: " .. CAD.mod .. " | " .. CAD.komutGirdisi, 20, 80)
    end
    
    -- ÇOKLU SEKME ÇUBUĞU
    love.graphics.setColor(0.04, 0.04, 0.04, 0.95)
    love.graphics.rectangle("fill", 10, 112, 1060, 30, 4, 4)
    for i, sekme in ipairs(CAD.sekmeler) do
        local tx = 15 + (i - 1) * 125
        local tw, th, ty = 120, 24, 115
        if i == CAD.aktifSekmeIndex then love.graphics.setColor(0.12, 0.35, 0.65)
        elseif fx >= tx and fx <= tx + tw and fy >= ty and fy <= ty + th then love.graphics.setColor(0.22, 0.22, 0.22)
        else love.graphics.setColor(0.12, 0.12, 0.12) end
        love.graphics.rectangle("fill", tx, ty, tw, th, 3, 3)
        love.graphics.setColor(1, 1, 1)
        local etiket = sekme.isim
        if #etiket > 10 then etiket = string.sub(etiket, 1, 9) .. ".." end
        love.graphics.print(etiket, tx + 8, ty + 5)
        love.graphics.setColor(0.7, 0.3, 0.3)
        love.graphics.print("x", tx + tw - 16, ty + 3)
    end
    
    local plusX = 15 + (#CAD.sekmeler) * 125
    if plusX <= 1040 then
        love.graphics.setColor((fx >= plusX and fx <= plusX + 28 and fy >= 115 and fy <= 139) and {0.25, 0.5, 0.25} or {0.15, 0.25, 0.15})
        love.graphics.rectangle("fill", plusX, 115, 28, 24, 3, 3)
        love.graphics.setColor(0.8, 1, 0.8)
        love.graphics.print("+", plusX + 9, 118)
    end
end

function love.load()
    love.window.setTitle("Profesyonel 2D CAD (Ortho Dimension & Akilli Osnap)")
    love.window.setMode(1250, 750, { resizable = true, vsync = true })
    Grid:yenile()
end

function love.update(dt)
    local fx, fy = love.mouse.getPosition()
    local hamX, hamY = CAD.ekrandanDunyaya(fx, fy)
    CAD.osnapHesapla(hamX, hamY)
    
    -- OSNAP kilitlendiğinde doğrudan hedefin dünya koordinatına yapışır
    if CAD.aktifOsnap and CAD.mod ~= "TEXT_INPUT" and CAD.mod ~= "FILLET" then
        dunyaFareX, dunyaFareY = CAD.aktifOsnap.x, CAD.aktifOsnap.y
    else
        dunyaFareX, dunyaFareY = hamX, hamY
    end

    CAD.kameraGuncelle(fx, fy)
    CAD.geciciSekilleriGuncelle(dunyaFareX, dunyaFareY)
    CAD.fontButonlari[2].etiket = "F:" .. tostring(CAD.aktifFontBoyutu)
end

function love.draw()
    love.graphics.push()
    love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    love.graphics.scale(CAD.kamera.zoom, CAD.kamera.zoom)
    love.graphics.translate(-CAD.kamera.x, -CAD.kamera.y)
    ARAYUZ.dunyaCiz(dunyaFareX, dunyaFareY)
    love.graphics.pop()
    ARAYUZ.panelleriCiz(dunyaFareX, dunyaFareY)
end

-- =============================================================================
-- GÜVENLİ PROJE KAYDET / YÜKLE (JSON)
-- =============================================================================
function CAD.saveProjectJSON()
    local sekme = CAD.aktifSekme()
    local varsayilanAd = (sekme.isim or "proje") .. ".json"
    local secilenYol = konumSecKaydet(varsayilanAd, "JSON Dosyalari (*.json)|*.json")
    if not secilenYol or secilenYol == "" then CAD.komutGirdisi = "KAYIT IPTAL EDILDI" return end
    if not secilenYol:lower():match("%.json$") then secilenYol = secilenYol .. ".json" end
    sekme.dosyaYolu = secilenYol
    sekme.isim = secilenYol:match("([^/\\]+)%.%w+$") or sekme.isim
    local kayitVerisi = {
        aktifBirim = CAD.aktifBirim,
        aktifFontBoyutu = CAD.aktifFontBoyutu,
        sekliller = CAD.sekliller
    }
    local jsonString = tabloyuSeriYap(kayitVerisi)
    local ok, err = guvenliDosyaYaz(secilenYol, jsonString)
    if ok then
        CAD.komutGirdisi = "JSON KAYDEDILDI: " .. sekme.isim
    else
        CAD.komutGirdisi = "YAZMA HATASI: " .. tostring(err)
    end
end

function CAD.loadProjectJSON()
    local secilenYol = konumSecYukle("JSON Dosyalari (*.json)|*.json")
    if not secilenYol or secilenYol == "" then CAD.komutGirdisi = "YUKLEME IPTAL EDILDI" return end
    local dosya = io.open(secilenYol, "rb")
    if not dosya then CAD.komutGirdisi = "DOSYA OKUNAMADI!" return end
    local jsonString = dosya:read("*a")
    dosya:close()
    local veri = parseJSON(jsonString)
    if veri and type(veri) == "table" then
        CAD.sekliller = veri.sekliller or {}
        CAD.aktifBirim = veri.aktifBirim or "mm"
        CAD.aktifFontBoyutu = veri.aktifFontBoyutu or 14
        local sekme = CAD.aktifSekme()
        sekme.sekliller = CAD.sekliller
        sekme.aktifBirim = CAD.aktifBirim
        sekme.dosyaYolu = secilenYol
        sekme.isim = secilenYol:match("([^/\\]+)%.%w+$") or sekme.isim
        CAD.cizimiOrtala()
        Grid:yenile()
        CAD.komutGirdisi = "JSON PROJE YUKLENDI: " .. sekme.isim
    else
        CAD.komutGirdisi = "JSON COZUMLEME HATASI!"
    end
end

-- =============================================================================
-- DXF EXPORT VE IMPORT MOTORU
-- =============================================================================
function CAD.exportDXF()
    local secilenYol = konumSecKaydet("cizim.dxf", "AutoCAD DXF Dosyalari (*.dxf)|*.dxf")
    if not secilenYol or secilenYol == "" then CAD.komutGirdisi = "DXF IPTAL EDILDI" return end
    if not secilenYol:lower():match("%.dxf$") then secilenYol = secilenYol .. ".dxf" end
    
    local lines = {}
    local function add(code, val) table.insert(lines, tostring(code)) table.insert(lines, tostring(val)) end
    
    add(0, "SECTION") add(2, "HEADER")
    add(9, "$ACADVER") add(1, "AC1009")
    add(9, "$INSUNITS") add(70, "4")
    add(9, "$MEASUREMENT") add(70, "1")
    add(9, "$DIMTXT") add(40, string.format("%.4f", CAD.aktifFontBoyutu or 14))
    add(9, "$DIMASZ") add(40, "3.5")
    add(9, "$DIMSCALE") add(40, "1.0")
    add(9, "$TEXTSIZE") add(40, string.format("%.4f", CAD.aktifFontBoyutu or 14))
    add(9, "$DIMSTYLE") add(2, "STANDARD")
    add(0, "ENDSEC")
    
    add(0, "SECTION") add(2, "TABLES")
    add(0, "TABLE") add(2, "STYLE") add(70, "1")
    add(0, "STYLE") add(2, "STANDARD") add(70, "0")
    add(40, string.format("%.4f", CAD.aktifFontBoyutu or 14)) add(41, "1.0") add(50, "0.0") add(71, "0")
    add(42, string.format("%.4f", CAD.aktifFontBoyutu or 14)) add(3, "txt") add(4, "")
    add(0, "ENDTAB")
    add(0, "TABLE") add(2, "DIMSTYLE") add(70, "1")
    add(0, "DIMSTYLE") add(2, "STANDARD") add(70, "0")
    add(40, "1.0") add(41, "3.5") add(140, string.format("%.4f", CAD.aktifFontBoyutu or 14))
    add(0, "ENDTAB")
    add(0, "ENDSEC")
    
    add(0, "SECTION") add(2, "ENTITIES")
    for _, s in ipairs(CAD.sekliller) do
        if s.tip == "cizgi" then
            add(0, "LINE") add(8, "0")
            add(10, string.format("%.4f", s.x1)) add(20, string.format("%.4f", -s.y1))
            add(11, string.format("%.4f", s.x2)) add(21, string.format("%.4f", -s.y2))
        elseif s.tip == "cember" then
            add(0, "CIRCLE") add(8, "0")
            add(10, string.format("%.4f", s.cx)) add(20, string.format("%.4f", -s.cy))
            add(40, string.format("%.4f", s.r))
        elseif s.tip == "yay" then
            add(0, "ARC") add(8, "0")
            add(10, string.format("%.4f", s.cx)) add(20, string.format("%.4f", -s.cy))
            add(40, string.format("%.4f", s.r))
            add(50, string.format("%.4f", math.deg(-s.a2))) add(51, string.format("%.4f", math.deg(-s.a1)))
        elseif s.tip == "dikdortgen" then
            add(0, "LINE") add(8, "0") add(10, string.format("%.4f", s.x1)) add(20, string.format("%.4f", -s.y1)) add(11, string.format("%.4f", s.x2)) add(21, string.format("%.4f", -s.y1))
            add(0, "LINE") add(8, "0") add(10, string.format("%.4f", s.x2)) add(20, string.format("%.4f", -s.y1)) add(11, string.format("%.4f", s.x2)) add(21, string.format("%.4f", -s.y2))
            add(0, "LINE") add(8, "0") add(10, string.format("%.4f", s.x2)) add(20, string.format("%.4f", -s.y2)) add(11, string.format("%.4f", s.x1)) add(21, string.format("%.4f", -s.y2))
            add(0, "LINE") add(8, "0") add(10, string.format("%.4f", s.x1)) add(20, string.format("%.4f", -s.y2)) add(11, string.format("%.4f", s.x1)) add(21, string.format("%.4f", -s.y1))
        elseif s.tip == "text" then
            add(0, "TEXT") add(8, "0") add(10, string.format("%.4f", s.tx)) add(20, string.format("%.4f", -s.ty))
            add(40, string.format("%.4f", s.punto or 14)) add(1, s.metin)
        elseif s.tip == "dimension" then
            local dx, dy = s.x2 - s.x1, s.y2 - s.y1
            local len = math.sqrt(dx * dx + dy * dy)
            local nx, ny = 0, 0
            if len > 0 then nx, ny = -dy / len, dx / len end
            local off = s.offset or 25
            local midX, midY = (s.x1 + s.x2) / 2, (s.y1 + s.y2) / 2
            local ox = midX + nx * off
            local oy = midY + ny * off
            local punto = s.punto or CAD.aktifFontBoyutu or 14
            local metin = s.metin or string.format("%.2f", len)
            local aciDeg = math.deg(math.atan2(-dy, dx))
            if aciDeg > 90 then aciDeg = aciDeg - 180 elseif aciDeg < -90 then aciDeg = aciDeg + 180 end
            
            add(0, "DIMENSION") add(8, "DIMENSIONS") add(3, "STANDARD") add(70, "1")
            add(10, string.format("%.4f", s.x1 + nx * off)) add(20, string.format("%.4f", -(s.y1 + ny * off)))
            add(11, string.format("%.4f", ox)) add(21, string.format("%.4f", -oy))
            add(13, string.format("%.4f", s.x1)) add(23, string.format("%.4f", -s.y1))
            add(14, string.format("%.4f", s.x2)) add(24, string.format("%.4f", -s.y2))
            add(40, string.format("%.4f", punto)) add(42, string.format("%.4f", len))
            add(50, string.format("%.4f", aciDeg)) add(1, metin)
            
            local asim = (off >= 0 and 6 or -6)
            add(0, "LINE") add(8, "DIM_GEOM")
            add(10, string.format("%.4f", s.x1 + nx * off)) add(20, string.format("%.4f", -(s.y1 + ny * off)))
            add(11, string.format("%.4f", s.x2 + nx * off)) add(21, string.format("%.4f", -(s.y2 + ny * off)))
            add(0, "LINE") add(8, "DIM_GEOM")
            add(10, string.format("%.4f", s.x1)) add(20, string.format("%.4f", -s.y1))
            add(11, string.format("%.4f", s.x1 + nx * (off + asim))) add(21, string.format("%.4f", -(s.y1 + ny * (off + asim))))
            add(0, "LINE") add(8, "DIM_GEOM")
            add(10, string.format("%.4f", s.x2)) add(20, string.format("%.4f", -s.y2))
            add(11, string.format("%.4f", s.x2 + nx * (off + asim))) add(21, string.format("%.4f", -(s.y2 + ny * (off + asim))))
            add(0, "TEXT") add(8, "DIM_GEOM")
            add(10, string.format("%.4f", ox)) add(20, string.format("%.4f", -oy))
            add(40, string.format("%.4f", punto)) add(1, metin) add(50, string.format("%.4f", aciDeg))
        end
    end
    add(0, "ENDSEC") add(0, "EOF")
    
    local ok, err = guvenliDosyaYaz(secilenYol, table.concat(lines, "\r\n") .. "\r\n")
    if ok then CAD.komutGirdisi = "DXF AKTARILDI!" else CAD.komutGirdisi = "DXF YAZMA HATASI: " .. tostring(err) end
end

function CAD.importDXF()
    local secilenYol = konumSecYukle("AutoCAD DXF Dosyalari (*.dxf)|*.dxf")
    if not secilenYol or secilenYol == "" then CAD.komutGirdisi = "DXF IPTAL EDILDI" return end
    local dosya = io.open(secilenYol, "r")
    if not dosya then CAD.komutGirdisi = "DOSYA OKUNAMADI!" return end
    local icerik = dosya:read("*a")
    dosya:close()
    
    local satirlar = {}
    for satir in string.gmatch(icerik, "[^\r\n]+") do
        local temiz = satir:match("^%s*(.-)%s*$")
        if temiz and temiz ~= "" then table.insert(satirlar, temiz) end
    end
    
    local pairsList = {}
    local p = 1
    while p <= #satirlar do
        local code = tonumber(satirlar[p])
        local val = satirlar[p+1] or ""
        if code ~= nil then table.insert(pairsList, { code = code, val = val }) p = p + 2
        else p = p + 1 end
    end
    
    local bloklar, cizimSekilleri = {}, {}
    local aktifBlok = nil
    local icerideBlok = false
    local k = 1
    local len = #pairsList
    
    local function entityOku(idx)
        local entType = pairsList[idx].val:upper()
        idx = idx + 1
        local raw = {}
        while idx <= len and pairsList[idx].code ~= 0 do table.insert(raw, pairsList[idx]) idx = idx + 1 end
        return entType, raw, idx
    end
    
    local function entityCozumle(entType, raw)
        local objeler = {}
        local layer = ""
        for _, tag in ipairs(raw) do if tag.code == 8 then layer = tag.val:upper() end end
        if layer == "DIM_GEOM" then return objeler end
        
        if entType == "LINE" then
            local x1, y1, x2, y2 = 0, 0, 0, 0
            for _, tag in ipairs(raw) do
                if tag.code == 10 then x1 = tonumber(tag.val) or 0
                elseif tag.code == 20 then y1 = -(tonumber(tag.val) or 0)
                elseif tag.code == 11 then x2 = tonumber(tag.val) or 0
                elseif tag.code == 21 then y2 = -(tonumber(tag.val) or 0) end
            end
            table.insert(objeler, { tip = "cizgi", x1 = x1, y1 = y1, x2 = x2, y2 = y2, renk = {1,1,1,1}, cizgiTuru = "surekli" })
        elseif entType == "LWPOLYLINE" then
            local pts, kapali = {}, false
            local curX, curY = nil, nil
            for _, tag in ipairs(raw) do
                if tag.code == 70 then kapali = ((tonumber(tag.val) or 0) % 2 == 1)
                elseif tag.code == 10 then curX = tonumber(tag.val) or 0
                elseif tag.code == 20 then
                    curY = -(tonumber(tag.val) or 0)
                    if curX and curY then table.insert(pts, { x = curX, y = curY }) curX, curY = nil, nil end
                end
            end
            if #pts >= 2 then
                for i = 1, #pts - 1 do
                    table.insert(objeler, { tip = "cizgi", x1 = pts[i].x, y1 = pts[i].y, x2 = pts[i+1].x, y2 = pts[i+1].y, renk = {1,1,1,1}, cizgiTuru = "surekli" })
                end
                if kapali and #pts > 2 then
                    table.insert(objeler, { tip = "cizgi", x1 = pts[#pts].x, y1 = pts[#pts].y, x2 = pts[1].x, y2 = pts[1].y, renk = {1,1,1,1}, cizgiTuru = "surekli" })
                end
            end
        elseif entType == "CIRCLE" then
            local cx, cy, r = 0, 0, 0
            for _, tag in ipairs(raw) do
                if tag.code == 10 then cx = tonumber(tag.val) or 0
                elseif tag.code == 20 then cy = -(tonumber(tag.val) or 0)
                elseif tag.code == 40 then r = tonumber(tag.val) or 0 end
            end
            table.insert(objeler, { tip = "cember", cx = cx, cy = cy, r = r, renk = {1,1,1,1}, cizgiTuru = "surekli" })
        elseif entType == "ARC" then
            local cx, cy, r, a1, a2 = 0, 0, 0, 0, 0
            for _, tag in ipairs(raw) do
                if tag.code == 10 then cx = tonumber(tag.val) or 0
                elseif tag.code == 20 then cy = -(tonumber(tag.val) or 0)
                elseif tag.code == 40 then r = tonumber(tag.val) or 0
                elseif tag.code == 50 then a1 = tonumber(tag.val) or 0
                elseif tag.code == 51 then a2 = tonumber(tag.val) or 0 end
            end
            table.insert(objeler, { tip = "yay", cx = cx, cy = cy, r = r, a1 = math.rad(-a2), a2 = math.rad(-a1), renk = {1,1,1,1}, cizgiTuru = "surekli" })
        elseif entType == "TEXT" or entType == "MTEXT" then
            local tx, ty, punto, metin = 0, 0, 14, ""
            for _, tag in ipairs(raw) do
                if tag.code == 10 then tx = tonumber(tag.val) or 0
                elseif tag.code == 20 then ty = -(tonumber(tag.val) or 0)
                elseif tag.code == 40 then punto = tonumber(tag.val) or 14
                elseif tag.code == 1 then metin = tag.val end
            end
            metin = metin:gsub("\\A%d+;", ""):gsub("\\[Pp]", " "):gsub("{", ""):gsub("}", ""):gsub("%%%%[cC]", "O"):gsub("%%%%[dD]", "°")
            table.insert(objeler, { tip = "text", tx = tx, ty = ty, punto = math.max(8, punto), metin = metin, renk = {1,1,1,1} })
        elseif entType == "DIMENSION" then
            local x1, y1, x2, y2, ox, oy = 0, 0, 0, 0, nil, nil
            local has13, has14 = false, false
            local metin, punto = "", 14
            for _, tag in ipairs(raw) do
                if tag.code == 13 then x1 = tonumber(tag.val) or 0 has13 = true
                elseif tag.code == 23 then y1 = -(tonumber(tag.val) or 0)
                elseif tag.code == 14 then x2 = tonumber(tag.val) or 0 has14 = true
                elseif tag.code == 24 then y2 = -(tonumber(tag.val) or 0)
                elseif tag.code == 10 then ox = tonumber(tag.val) or 0
                elseif tag.code == 20 then oy = -(tonumber(tag.val) or 0)
                elseif tag.code == 1 then metin = tag.val
                elseif tag.code == 40 then punto = tonumber(tag.val) or 14 end
            end
            if has13 and has14 then
                local dx, dy = x2 - x1, y2 - y1
                local len = math.sqrt(dx * dx + dy * dy)
                if len > 0.001 then
                    local nx, ny = -dy / len, dx / len
                    local offset = 25
                    if ox and oy then offset = (ox - x1) * nx + (oy - y1) * ny end
                    if math.abs(offset) < 0.001 then offset = 25 end
                    if not metin or metin == "" or metin:find("<>") then
                        local carpan = CAD.birimCarpanlari[CAD.aktifBirim] or 1
                        local valStr = string.format("%.2f %s", len / carpan, CAD.aktifBirim)
                        metin = (metin and metin:find("<>")) and metin:gsub("<>", valStr) or valStr
                    end
                    metin = metin:gsub("\\A%d+;", ""):gsub("\\[Pp]", " "):gsub("{", ""):gsub("}", "")
                    table.insert(objeler, { tip = "dimension", x1 = x1, y1 = y1, x2 = x2, y2 = y2, offset = offset, metin = metin, punto = math.max(8, punto), renk = {1, 1, 1, 1}, cizgiTuru = "surekli" })
                end
            end
        end
        return objeler
    end
    
    while k <= len do
        local r = pairsList[k]
        if r.code == 0 then
            local tip = r.val:upper()
            if tip == "SECTION" then k = k + 1
            elseif tip == "BLOCK" then
                icerideBlok = true
                aktifBlok = { isim = "", objeler = {}, bx = 0, by = 0 }
                k = k + 1
                while k <= len and pairsList[k].code ~= 0 do
                    if pairsList[k].code == 2 then aktifBlok.isim = pairsList[k].val:upper()
                    elseif pairsList[k].code == 10 then aktifBlok.bx = tonumber(pairsList[k].val) or 0
                    elseif pairsList[k].code == 20 then aktifBlok.by = -(tonumber(pairsList[k].val) or 0) end
                    k = k + 1
                end
            elseif tip == "ENDBLK" then
                if aktifBlok and aktifBlok.isim ~= "" then bloklar[aktifBlok.isim] = aktifBlok end
                icerideBlok = false
                aktifBlok = nil
                k = k + 1
            elseif tip == "POLYLINE" then
                local pts, kapali = {}, false
                k = k + 1
                while k <= len and pairsList[k].code ~= 0 do
                    if pairsList[k].code == 70 then kapali = ((tonumber(pairsList[k].val) or 0) % 2 == 1) end
                    k = k + 1
                end
                while k <= len do
                    if pairsList[k].code == 0 then
                        local sub = pairsList[k].val:upper()
                        if sub == "VERTEX" then
                            k = k + 1
                            local vx, vy = 0, 0
                            while k <= len and pairsList[k].code ~= 0 do
                                if pairsList[k].code == 10 then vx = tonumber(pairsList[k].val) or 0
                                elseif pairsList[k].code == 20 then vy = -(tonumber(pairsList[k].val) or 0) end
                                k = k + 1
                            end
                            table.insert(pts, { x = vx, y = vy })
                        elseif sub == "SEQEND" then k = k + 1 break
                        else break end
                    else k = k + 1 end
                end
                if #pts >= 2 then
                    for i = 1, #pts - 1 do
                        local seg = { tip = "cizgi", x1 = pts[i].x, y1 = pts[i].y, x2 = pts[i+1].x, y2 = pts[i+1].y, renk = {1,1,1,1}, cizgiTuru = "surekli" }
                        if icerideBlok and aktifBlok then table.insert(aktifBlok.objeler, seg) else table.insert(cizimSekilleri, seg) end
                    end
                    if kapali and #pts > 2 then
                        local seg = { tip = "cizgi", x1 = pts[#pts].x, y1 = pts[#pts].y, x2 = pts[1].x, y2 = pts[1].y, renk = {1,1,1,1}, cizgiTuru = "surekli" }
                        if icerideBlok and aktifBlok then table.insert(aktifBlok.objeler, seg) else table.insert(cizimSekilleri, seg) end
                    end
                end
            elseif tip == "INSERT" and not icerideBlok then
                local bName, ix, iy, sx, sy, rot = "", 0, 0, 1, 1, 0
                k = k + 1
                while k <= len and pairsList[k].code ~= 0 do
                    local cd, vl = pairsList[k].code, pairsList[k].val
                    if cd == 2 then bName = vl:upper()
                    elseif cd == 10 then ix = tonumber(vl) or 0
                    elseif cd == 20 then iy = -(tonumber(vl) or 0)
                    elseif cd == 41 then sx = tonumber(vl) or 1
                    elseif cd == 42 then sy = tonumber(vl) or 1
                    elseif cd == 50 then rot = math.rad(-(tonumber(vl) or 0)) end
                    k = k + 1
                end
                if not bName:match("^%*D") and bloklar[bName] then
                    local blk = bloklar[bName]
                    local cosR, sinR = math.cos(rot), math.sin(rot)
                    for _, bo in ipairs(blk.objeler) do
                        if bo.tip == "cizgi" then
                            local px1 = (bo.x1 - blk.bx) * sx
                            local py1 = (bo.y1 - blk.by) * sy
                            local px2 = (bo.x2 - blk.bx) * sx
                            local py2 = (bo.y2 - blk.by) * sy
                            table.insert(cizimSekilleri, {
                                tip = "cizgi",
                                x1 = ix + px1 * cosR - py1 * sinR, y1 = iy + px1 * sinR + py1 * cosR,
                                x2 = ix + px2 * cosR - py2 * sinR, y2 = iy + px2 * sinR + py2 * cosR,
                                renk = {1,1,1,1}, cizgiTuru = "surekli"
                            })
                        elseif bo.tip == "cember" then
                            local pcx = (bo.cx - blk.bx) * sx
                            local pcy = (bo.cy - blk.by) * sy
                            table.insert(cizimSekilleri, {
                                tip = "cember",
                                cx = ix + pcx * cosR - pcy * sinR, cy = iy + pcx * sinR + pcy * cosR,
                                r = bo.r * math.abs(sx), renk = {1,1,1,1}, cizgiTuru = "surekli"
                            })
                        end
                    end
                end
            else
                local entType, raw, nextK = entityOku(k)
                k = nextK
                local olusanlar = entityCozumle(entType, raw)
                if icerideBlok and aktifBlok then for _, o in ipairs(olusanlar) do table.insert(aktifBlok.objeler, o) end
                elseif not icerideBlok then for _, o in ipairs(olusanlar) do table.insert(cizimSekilleri, o) end end
            end
        else k = k + 1 end
    end
    
    if #cizimSekilleri == 0 then CAD.komutGirdisi = "DXF ICINDE UYGUN 2D GEOMETRI BULUNAMADI!" return end
    CAD.sekliller = cizimSekilleri
    local sekme = CAD.aktifSekme()
    sekme.sekliller = CAD.sekliller
    sekme.dosyaYolu = secilenYol
    sekme.isim = secilenYol:match("([^/\\]+)%.%w+$") or sekme.isim
    CAD.cizimiOrtala()
    Grid:yenile()
    CAD.mod = "SEC"
    CAD.komutGirdisi = string.format("DXF YUKLENDI: %s (%d Nesne)", sekme.isim, #CAD.sekliller)
end

-- =============================================================================
-- SAF LUA A4 LANDSCAPE VEKTÖREL PDF MOTORU
-- =============================================================================
function CAD.exportPDF()
    local sekme = CAD.aktifSekme()
    local varsayilanAd = (sekme.isim or "cizim") .. "_A4_Yatay.pdf"
    local secilenYol = konumSecKaydet(varsayilanAd, "PDF Dokumanlari (*.pdf)|*.pdf")
    if not secilenYol or secilenYol == "" then CAD.komutGirdisi = "PDF IPTAL EDILDI" return end
    if not secilenYol:lower():match("%.pdf$") then secilenYol = secilenYol .. ".pdf" end
    
    local hedefler = {}
    if #CAD.seciliObjeler > 0 then
        for _, s in ipairs(CAD.seciliObjeler) do table.insert(hedefler, s) end
    else
        for _, s in ipairs(CAD.sekliller) do table.insert(hedefler, s) end
    end
    if #hedefler == 0 then CAD.komutGirdisi = "PDF: Aktarilacak cizim bulunamadi!" return end
    
    local minX, maxX, minY, maxY = 1e12, -1e12, 1e12, -1e12
    for _, s in ipairs(hedefler) do
        local x1, x2, y1, y2 = CAD.nesneAABB(s)
        minX, maxX = math.min(minX, x1), math.max(maxX, x2)
        minY, maxY = math.min(minY, y1), math.max(maxY, y2)
    end
    
    local farkX, farkY = maxX - minX, maxY - minY
    local payX, payY = math.max(25, farkX * 0.1), math.max(25, farkY * 0.1)
    minX, maxX = minX - payX, maxX + payX
    minY, maxY = minY - payY, maxY + payY
    
    local pageW, pageH = 841.89, 595.28
    local kenarBosluk = 36
    local cizimAlaniW = pageW - 2 * kenarBosluk
    local cizimAlaniH = pageH - 2 * kenarBosluk - 25
    local cizimW, cizimH = math.max(10, maxX - minX), math.max(10, maxY - minY)
    local scale = math.min(cizimAlaniW / cizimW, cizimAlaniH / cizimH)
    local oturanW, oturanH = cizimW * scale, cizimH * scale
    local baslangicX = kenarBosluk + (cizimAlaniW - oturanW) / 2
    local baslangicY = kenarBosluk + 25 + (cizimAlaniH - oturanH) / 2
    
    local function toPDF(wx, wy)
        return baslangicX + (wx - minX) * scale, baslangicY + oturanH - (wy - minY) * scale
    end
    
    local cmds = { "q", "1 J 1 j" }
    table.insert(cmds, "0.15 0.15 0.15 RG 1.5 w")
    table.insert(cmds, string.format("%.2f %.2f %.2f %.2f re S", kenarBosluk/2, kenarBosluk/2, pageW - kenarBosluk, pageH - kenarBosluk))
    
    for _, s in ipairs(hedefler) do
        local c = s.renk or {0.1, 0.1, 0.1, 1}
        local cr, cg, cb = c[1] or 0.1, c[2] or 0.1, c[3] or 0.1
        if cr > 0.8 and cg > 0.8 and cb > 0.8 then cr, cg, cb = 0.08, 0.08, 0.08 end
        table.insert(cmds, string.format("%.3f %.3f %.3f RG", cr, cg, cb))
        table.insert(cmds, "1.2 w")
        
        if s.tip == "cizgi" then
            local px1, py1 = toPDF(s.x1, s.y1)
            local px2, py2 = toPDF(s.x2, s.y2)
            table.insert(cmds, string.format("%.2f %.2f m %.2f %.2f l S", px1, py1, px2, py2))
        elseif s.tip == "dikdortgen" then
            local p1x, p1y = toPDF(s.x1, s.y1)
            local p2x, p2y = toPDF(s.x2, s.y1)
            local p3x, p3y = toPDF(s.x2, s.y2)
            local p4x, p4y = toPDF(s.x1, s.y2)
            table.insert(cmds, string.format("%.2f %.2f m %.2f %.2f l %.2f %.2f l %.2f %.2f l h S", p1x, p1y, p2x, p2y, p3x, p3y, p4x, p4y))
        elseif s.tip == "cember" then
            local pcx, pcy = toPDF(s.cx, s.cy)
            local pr = s.r * scale
            local kx = pr * 0.5522847498
            table.insert(cmds, string.format("%.2f %.2f m", pcx + pr, pcy))
            table.insert(cmds, string.format("%.2f %.2f %.2f %.2f %.2f %.2f c", pcx + pr, pcy + kx, pcx + kx, pcy + pr, pcx, pcy + pr))
            table.insert(cmds, string.format("%.2f %.2f %.2f %.2f %.2f %.2f c", pcx - kx, pcy + pr, pcx - pr, pcy + kx, pcx - pr, pcy))
            table.insert(cmds, string.format("%.2f %.2f %.2f %.2f %.2f %.2f c", pcx - pr, pcy - kx, pcx - kx, pcy - pr, pcx, pcy - pr))
            table.insert(cmds, string.format("%.2f %.2f %.2f %.2f %.2f %.2f c h S", pcx + kx, pcy - pr, pcx + pr, pcy - kx, pcx + pr, pcy))
        elseif s.tip == "yay" then
            local N = math.max(16, math.floor(math.abs(s.a2 - s.a1) * 32))
            for i = 0, N do
                local t = i / N
                local ang = s.a1 + (s.a2 - s.a1) * t
                local px, py = toPDF(s.cx + s.r * math.cos(ang), s.cy + s.r * math.sin(ang))
                if i == 0 then table.insert(cmds, string.format("%.2f %.2f m", px, py))
                else table.insert(cmds, string.format("%.2f %.2f l", px, py)) end
            end
            table.insert(cmds, "S")
        elseif s.tip == "dimension" then
            table.insert(cmds, "0.8 w")
            local dx, dy = s.x2 - s.x1, s.y2 - s.y1
            local len = math.sqrt(dx * dx + dy * dy)
            if len > 0 then
                local nx, ny = -dy / len, dx / len
                local ox1, oy1 = s.x1 + nx * s.offset, s.y1 + ny * s.offset
                local ox2, oy2 = s.x2 + nx * s.offset, y2 + ny * s.offset
                local pox1, poy1 = toPDF(ox1, oy1)
                local pox2, poy2 = toPDF(ox2, oy2)
                local px1, py1   = toPDF(s.x1, s.y1)
                local px2, py2   = toPDF(s.x2, s.y2)
                table.insert(cmds, string.format("%.2f %.2f m %.2f %.2f l S", pox1, poy1, pox2, poy2))
                table.insert(cmds, string.format("%.2f %.2f m %.2f %.2f l S", px1, py1, pox1, poy1))
                table.insert(cmds, string.format("%.2f %.2f m %.2f %.2f l S", px2, py2, pox2, poy2))
                
                local pmx, pmy = (pox1 + pox2) / 2, (poy1 + poy2) / 2
                local punto = math.max(6, math.min(18, (s.punto or 14) * scale))
                local yazi = latinize(s.metin or string.format("%.2f", len))
                local yaziW = #yazi * punto * 0.52
                
                local dpx, dpy = pox2 - pox1, poy2 - poy1
                local pac = math.atan2(dpy, dpx)
                if pac > math.pi * 0.5 + 0.0001 then pac = pac - math.pi
                elseif pac < -math.pi * 0.5 + 0.0001 then pac = pac + math.pi end
                local cosA, sinA = math.cos(pac), math.sin(pac)
                local txP = pmx - (yaziW / 2) * cosA + (punto * 0.3) * (-sinA)
                local tyP = pmy - (yaziW / 2) * sinA + (punto * 0.3) * cosA
                
                table.insert(cmds, "BT")
                table.insert(cmds, string.format("/F1 %.2f Tf", punto))
                table.insert(cmds, string.format("%.4f %.4f %.4f %.4f %.2f %.2f Tm", cosA, sinA, -sinA, cosA, txP, tyP))
                table.insert(cmds, string.format("(%s) Tj", yazi:gsub('\\','\\\\'):gsub('%(','\\('):gsub('%)','\\)')))
                table.insert(cmds, "ET")
            end
        end
    end
    table.insert(cmds, "Q")
    local streamData = table.concat(cmds, "\n")
    
    local pdfParts, offsets, curPos = {}, {}, 0
    local function pWrite(str) table.insert(pdfParts, str) curPos = curPos + #str end
    local function pStartObj(id) offsets[id] = curPos pWrite(string.format("%d 0 obj\n", id)) end
    local function pEndObj() pWrite("endobj\n") end
    
    pWrite("%PDF-1.4\n%\xE2\xE3\xCF\xD3\n")
    pStartObj(1) pWrite("<< /Type /Catalog /Pages 2 0 R >>\n") pEndObj()
    pStartObj(2) pWrite("<< /Type /Pages /Kids [3 0 R] /Count 1 >>\n") pEndObj()
    pStartObj(3) pWrite(string.format("<< /Type /Page /Parent 2 0 R /MediaBox [0 0 %.2f %.2f] /Contents 4 0 R >>\n", pageW, pageH)) pEndObj()
    pStartObj(4) pWrite(string.format("<< /Length %d >>\nstream\n%s\nendstream\n", #streamData, streamData)) pEndObj()
    
    local xrefOffset = curPos
    pWrite("xref\n0 5\n0000000000 65535 f \n")
    for i = 1, 4 do pWrite(string.format("%010d 00000 n \n", offsets[i])) end
    pWrite(string.format("trailer\n<< /Size 5 /Root 1 0 R >>\nstartxref\n%d\n%%%%EOF\n", xrefOffset))
    
    local ok, err = guvenliDosyaYaz(secilenYol, table.concat(pdfParts))
    if ok then CAD.komutGirdisi = "PDF AKTARILDI: " .. sekme.isim else CAD.komutGirdisi = "PDF YAZMA HATASI: " .. tostring(err) end
end

-- =============================================================================
-- KLAVYE VE KOMUT DİNLENMESİ
-- =============================================================================
function love.keypressed(key)
    -- GÜVENLİ STANDART KAYIT (CTRL+S)
    if key == "s" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then CAD.saveProjectJSON() return end
    if key == "t" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then CAD.yeniSekme() return end
    if key == "w" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then CAD.sekmeKapat(CAD.aktifSekmeIndex) return end
    if key == "c" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) and CAD.mod == "SEC" then CAD.kopyala() return end
    if key == "v" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then CAD.yapistir(dunyaFareX, dunyaFareY) return end
    if key == "z" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then
        if #CAD.sekliller > 0 then table.remove(CAD.sekliller, #CAD.sekliller) Grid:yenile() end
        return
    end
    if key == "f8" then CAD.orthoModu = not CAD.orthoModu return end
    if key == "escape" then
        if CAD.offsetHedefObje then CAD.offsetHedefObje.secili = false end
        if CAD.filletSecilenler then for _, item in ipairs(CAD.filletSecilenler) do if item.obj then item.obj.secili = false end end end
        CAD.mod = "SEC"
        CAD.geciciCizgi, CAD.geciciCember, CAD.geciciDikdortgen, CAD.geciciYay, CAD.geciciDim, CAD.geciciText = nil, nil, nil, nil, nil, nil
        CAD.sonDimBilgi = nil
        CAD.offsetHedefObje = nil
        CAD.manipulasyonBase = nil
        CAD.scaleBase = nil
        CAD.scaleRefP1 = nil
        CAD.scaleRefLen = nil
        CAD.seciliObjeler = {}
        CAD.aktifSekme().seciliObjeler = {}
        CAD.filletSecilenler = {}
        CAD.mirrorEksen = nil
        CAD.secimKutusu = nil
        for _, s in ipairs(CAD.sekliller) do s.secili = false end
        CAD.komutGirdisi = ""
        return
    end
    if key == "delete" then
        local i = 1
        while i <= #CAD.sekliller do
            if CAD.sekliller[i].secili then table.remove(CAD.sekliller, i) else i = i + 1 end
        end
        CAD.seciliObjeler = {}
        CAD.aktifSekme().seciliObjeler = {}
        Grid:yenile()
        return
    end
    
    if CAD.mod == "ARRAY_MENU" then
        if key == "1" or key == "kp1" then CAD.arrayTur = "RECT" CAD.mod = "ARRAY_RECT_COUNTS" CAD.komutGirdisi = "3,3" return
        elseif key == "2" or key == "kp2" then CAD.arrayTur = "POLAR" CAD.mod = "ARRAY_POLAR_PARAMS" CAD.komutGirdisi = "6,360" return
        elseif key == "3" or key == "kp3" then CAD.arrayTur = "PATH" CAD.mod = "ARRAY_PATH_COUNT" CAD.komutGirdisi = "5" return end
    end
    
    if key == "return" or key == "kpenter" then
        local rClr = CAD.renkSözlüğü[CAD.aktifRenkId]
        local lType = CAD.aktifCizgiTuru
        if CAD.mod == "SEC" then
            local cmd = CAD.komutGirdisi:lower():gsub("%s+", "")
            if cmd == "l" then CAD.mod = "CIZGI"
            elseif cmd == "c" then CAD.mod = "CEMBER"
            elseif cmd == "rec" then CAD.mod = "DIKDORTGEN"
            elseif cmd == "a" then CAD.mod = "YAY" CAD.komutGirdisi = "YAY: 1. Noktayi Tiklayin" return
            elseif cmd == "dim" then CAD.mod = "DIM_1" CAD.komutGirdisi = "DIM: 1. Noktayi Tiklayin" return
            elseif cmd == "t" then CAD.mod = "TEXT" CAD.komutGirdisi = "TEXT: Metin Konumunu Tiklayin" return
            elseif cmd == "tr" or cmd == "trim" then CAD.mod = "TRIM" CAD.komutGirdisi = "TRIM: Budanacak Cizgi veya Yayi Tiklayin" return
            elseif cmd == "f" or cmd == "fillet" then CAD.mod = "FILLET_RAD" CAD.komutGirdisi = tostring(CAD.filletRadius) return
            elseif cmd == "mi" then CAD.mod = "MIRROR" CAD.komutGirdisi = "MIRROR: Eksenin 1. Noktasini Tiklayin" return
            elseif cmd == "h" then CAD.mod = "HATCH" CAD.komutGirdisi = "HATCH: Taranacak Alana Tiklayin" return
            elseif cmd == "o" then CAD.mod = "OFFSET_MESAFE" CAD.komutGirdisi = "" return
            elseif cmd == "ex" or cmd == "explode" or cmd == "x" then CAD.explodeUygula() return
            elseif cmd == "ar" or cmd == "array" then CAD.arrayBaslat() return
            elseif cmd == "pdf" or cmd == "plot" or cmd == "print" then CAD.exportPDF() return
            elseif cmd == "fs" or cmd == "font" then CAD.mod = "FONT_SIZE" CAD.komutGirdisi = tostring(CAD.aktifFontBoyutu) return
            elseif cmd == "m" and #CAD.seciliObjeler > 0 then CAD.mod = "MOVE" CAD.komutGirdisi = "MOVE: Referans Noktayi Tiklayin" return
            elseif (cmd == "co" or cmd == "cp") and #CAD.seciliObjeler > 0 then CAD.mod = "COPY" CAD.komutGirdisi = "COPY: Referans Noktayi Tiklayin" return
            elseif (cmd == "ro" or cmd == "rotate") and #CAD.seciliObjeler > 0 then CAD.mod = "ROTATE" CAD.komutGirdisi = "ROTATE: Merkez Noktayi Tiklayin" return
            elseif (cmd == "sc" or cmd == "scale") and #CAD.seciliObjeler > 0 then CAD.mod = "SCALE_BASE" CAD.komutGirdisi = "SCALE: Referans Noktayi Tiklayin" return
            elseif (cmd == "sc" or cmd == "scale") and #CAD.seciliObjeler == 0 then CAD.komutGirdisi = "SCALE: Once nesneleri secin!" return
            elseif cmd == "e" then
                local i = 1
                while i <= #CAD.sekliller do
                    if CAD.sekliller[i].secili then table.remove(CAD.sekliller, i) else i = i + 1 end
                end
                CAD.seciliObjeler = {}
                CAD.aktifSekme().seciliObjeler = {}
                Grid:yenile()
            end
            CAD.komutGirdisi = ""
        elseif CAD.mod == "DIM_CONT" then
            CAD.mod = "SEC"
            CAD.geciciDim = nil
            CAD.sonDimBilgi = nil
            CAD.komutGirdisi = "SERI OLCULENDIRME BITIRILDI"
        elseif CAD.mod == "SCALE_FACTOR" then
            local cmd = CAD.komutGirdisi:lower():gsub("%s+", "")
            if cmd == "r" or cmd == "ref" then
                CAD.mod = "SCALE_REF_1"
                CAD.komutGirdisi = ""
            else
                local val = tonumber(cmd)
                if val and val > 0 and CAD.scaleBase then
                    CAD.olcekUygula(val, CAD.scaleBase.x, CAD.scaleBase.y)
                    CAD.mod = "SEC"
                    CAD.komutGirdisi = string.format("SCALE TAMAMLANDI (%.4fx)", val)
                else
                    CAD.komutGirdisi = "Gecersiz oran! Sayi girin veya 'R' yazin:"
                end
            end
        elseif CAD.mod == "SCALE_REF_1" then
            local val = tonumber(CAD.komutGirdisi)
            if val and val > 0 then
                local carpan = CAD.birimCarpanlari[CAD.aktifBirim] or 1
                CAD.scaleRefLen = val * carpan
                CAD.mod = "SCALE_NEW_LEN"
                CAD.komutGirdisi = ""
            else
                CAD.komutGirdisi = "1. Noktayi fare ile tiklayin veya mevcut boyutu yazin!"
            end
        elseif CAD.mod == "SCALE_NEW_LEN" then
            local val = tonumber(CAD.komutGirdisi)
            if val and val > 0 and CAD.scaleRefLen and CAD.scaleRefLen > 0.00001 and CAD.scaleBase then
                local carpan = CAD.birimCarpanlari[CAD.aktifBirim] or 1
                local hedefLen = val * carpan
                local oran = hedefLen / CAD.scaleRefLen
                CAD.olcekUygula(oran, CAD.scaleBase.x, CAD.scaleBase.y)
                local eskGoster = CAD.scaleRefLen / carpan
                CAD.scaleBase = nil
                CAD.scaleRefP1 = nil
                CAD.scaleRefLen = nil
                CAD.mod = "SEC"
                CAD.komutGirdisi = string.format("SCALE: %.2f %s -> %.2f %s (%.4fx)", eskGoster, CAD.aktifBirim, val, CAD.aktifBirim, oran)
            else
                CAD.komutGirdisi = "Gecersiz hedef boyut! Tekrar girin:"
            end
        elseif CAD.mod == "FONT_SIZE" then
            local val = tonumber(CAD.komutGirdisi)
            if val and val >= 6 then CAD.fontBoyutuAyarla(val) end
            CAD.mod = "SEC"
            CAD.komutGirdisi = "Font Boyutu: " .. CAD.aktifFontBoyutu
        elseif CAD.mod == "ARRAY_RECT_COUNTS" then
            local virg = string.find(CAD.komutGirdisi, ",")
            if virg then
                CAD.arrayRows = tonumber(string.sub(CAD.komutGirdisi, 1, virg - 1)) or 3
                CAD.arrayCols = tonumber(string.sub(CAD.komutGirdisi, virg + 1)) or 3
            else
                CAD.arrayRows = tonumber(CAD.komutGirdisi) or 3
                CAD.arrayCols = 3
            end
            CAD.mod = "ARRAY_RECT_SPACING"
            CAD.komutGirdisi = "50,50"
        elseif CAD.mod == "ARRAY_RECT_SPACING" then
            local virg = string.find(CAD.komutGirdisi, ",")
            local spX, spY = 50, 50
            if virg then
                spX = tonumber(string.sub(CAD.komutGirdisi, 1, virg - 1)) or 50
                spY = tonumber(string.sub(CAD.komutGirdisi, virg + 1)) or 50
            else
                spX = tonumber(CAD.komutGirdisi) or 50
                spY = spX
            end
            local carpan = CAD.birimCarpanlari[CAD.aktifBirim]
            CAD.arrayUygulaRect(CAD.arrayRows, CAD.arrayCols, spX * carpan, spY * carpan)
        elseif CAD.mod == "ARRAY_POLAR_PARAMS" then
            local virg = string.find(CAD.komutGirdisi, ",")
            if virg then
                CAD.polarAdet = tonumber(string.sub(CAD.komutGirdisi, 1, virg - 1)) or 6
                CAD.polarAci = tonumber(string.sub(CAD.komutGirdisi, virg + 1)) or 360
            else
                CAD.polarAdet = tonumber(CAD.komutGirdisi) or 6
                CAD.polarAci = 360
            end
            CAD.mod = "ARRAY_POLAR_CENTER"
            CAD.komutGirdisi = ""
        elseif CAD.mod == "ARRAY_PATH_COUNT" then
            CAD.pathAdet = tonumber(CAD.komutGirdisi) or 5
            CAD.mod = "ARRAY_PATH_SELECT"
            CAD.komutGirdisi = ""
        elseif CAD.mod == "FILLET_RAD" then
            CAD.filletRadius = tonumber(CAD.komutGirdisi) or 0
            CAD.mod = "FILLET"
            CAD.filletSecilenler = {}
            CAD.komutGirdisi = string.format("FILLET (R=%.1f): 1. Cizgiyi/Kenari Secin", CAD.filletRadius)
        elseif CAD.mod == "OFFSET_MESAFE" then
            local val = tonumber(CAD.komutGirdisi)
            if val and val > 0 then
                CAD.offsetMesafesi = val * CAD.birimCarpanlari[CAD.aktifBirim]
                CAD.mod = "OFFSET_SEC"
                CAD.komutGirdisi = "Offset Yapilacak Nesneyi Secin"
            else
                CAD.mod = "SEC"
                CAD.komutGirdisi = ""
            end
        elseif CAD.mod == "TEXT_INPUT" and CAD.geciciText then
            if CAD.komutGirdisi ~= "" then
                local tObj = { tip = "text", tx = CAD.geciciText.tx, ty = CAD.geciciText.ty, metin = CAD.komutGirdisi, punto = CAD.aktifFontBoyutu, renk = rClr }
                table.insert(CAD.sekliller, tObj)
                Grid:ekle(tObj)
            end
            CAD.geciciText = nil
            CAD.mod = "SEC"
            CAD.komutGirdisi = ""
        elseif CAD.mod == "CIZGI" and CAD.geciciCizgi then
            local val = tonumber(CAD.komutGirdisi)
            if val and val > 0 then
                local mm = val * CAD.birimCarpanlari[CAD.aktifBirim]
                local aci = math.atan2(CAD.geciciCizgi.y2 - CAD.geciciCizgi.y1, CAD.geciciCizgi.x2 - CAD.geciciCizgi.x1)
                local nx = CAD.geciciCizgi.x1 + math.cos(aci) * mm
                local ny = CAD.geciciCizgi.y1 + math.sin(aci) * mm
                local cObj = { tip = "cizgi", x1 = CAD.geciciCizgi.x1, y1 = CAD.geciciCizgi.y1, x2 = nx, y2 = ny, renk = rClr, cizgiTuru = lType }
                table.insert(CAD.sekliller, cObj)
                Grid:ekle(cObj)
                CAD.geciciCizgi = { x1 = nx, y1 = ny, x2 = dunyaFareX, y2 = dunyaFareY }
            end
            CAD.komutGirdisi = ""
        elseif CAD.mod == "CEMBER" and CAD.geciciCember then
            local val = tonumber(CAD.komutGirdisi)
            if val and val > 0 then
                local cbObj = { tip = "cember", cx = CAD.geciciCember.cx, cy = CAD.geciciCember.cy, r = val * CAD.birimCarpanlari[CAD.aktifBirim], renk = rClr, cizgiTuru = lType }
                table.insert(CAD.sekliller, cbObj)
                Grid:ekle(cbObj)
                CAD.geciciCember = nil
                CAD.mod = "SEC"
            end
            CAD.komutGirdisi = ""
        elseif CAD.mod == "DIKDORTGEN" and CAD.geciciDikdortgen then
            local virgülPos = string.find(CAD.komutGirdisi, ",")
            if virgülPos then
                local valX = tonumber(string.sub(CAD.komutGirdisi, 1, virgülPos - 1))
                local valY = tonumber(string.sub(CAD.komutGirdisi, virgülPos + 1))
                if valX and valY then
                    local dkObj = {
                        tip = "dikdortgen",
                        x1 = CAD.geciciDikdortgen.x1,
                        y1 = CAD.geciciDikdortgen.y1,
                        x2 = CAD.geciciDikdortgen.x1 + valX * CAD.birimCarpanlari[CAD.aktifBirim],
                        y2 = CAD.geciciDikdortgen.y1 + valY * CAD.birimCarpanlari[CAD.aktifBirim],
                        renk = rClr,
                        cizgiTuru = lType
                    }
                    table.insert(CAD.sekliller, dkObj)
                    Grid:ekle(dkObj)
                    CAD.geciciDikdortgen = nil
                    CAD.mod = "SEC"
                end
            end
            CAD.komutGirdisi = ""
        end
    elseif key == "backspace" then
        CAD.komutGirdisi = string.sub(CAD.komutGirdisi, 1, -2)
    end
end

function love.textinput(text) CAD.komutGirdisi = CAD.komutGirdisi .. text end
function love.wheelmoved(x, y) CAD.zoomYap(y) end

-- =============================================================================
-- FARE (MOUSE) ETKİLEŞİM MOTORU
-- =============================================================================
function love.mousepressed(x, y, button)
    local fx, fy = love.mouse.getPosition()
    
    -- Tıklama anında konumu ve OSNAP'ı anlık olarak hesaplayıp doğrudan kitle
    local hamX, hamY = CAD.ekrandanDunyaya(fx, fy)
    CAD.osnapHesapla(hamX, hamY)
    if CAD.aktifOsnap and CAD.mod ~= "TEXT_INPUT" and CAD.mod ~= "FILLET" then
        dunyaFareX, dunyaFareY = CAD.aktifOsnap.x, CAD.aktifOsnap.y
    else
        dunyaFareX, dunyaFareY = hamX, hamY
    end
    
    -- Fare Sağ Tık (İptal / Seri Ölçü Bitirme)
    if button == 2 then
        if CAD.mod == "DIM_CONT" or CAD.mod == "DIM_1" or CAD.mod == "DIM_2" or CAD.mod == "DIM_3" then
            CAD.mod = "SEC"
            CAD.geciciDim = nil
            CAD.sonDimBilgi = nil
            CAD.komutGirdisi = "OLCULENDIRME TAMAMLANDI"
            return
        elseif CAD.mod ~= "SEC" then
            CAD.mod = "SEC"
            CAD.geciciCizgi, CAD.geciciCember, CAD.geciciDikdortgen, CAD.geciciYay = nil, nil, nil, nil
            CAD.komutGirdisi = ""
            return
        end
    end
    
    -- Üst Panel Butonları
    if fy <= 65 and fx <= 1070 then
        for _, b in ipairs(CAD.butonlar) do
            if fx >= b.x and fx <= b.x + b.w and fy >= b.y + 9 and fy <= b.y + 9 + b.h then
                CAD.aktifBirim = b.id CAD.aktifSekme().aktifBirim = b.id return
            end
        end
        for _, b in ipairs(CAD.renkButonlari) do
            if fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then
                CAD.aktifRenkId = b.id return
            end
        end
        for _, b in ipairs(CAD.cizgiTuruButonlari) do
            if fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then
                CAD.aktifCizgiTuru = b.id return
            end
        end
        for _, b in ipairs(CAD.fontButonlari) do
            if fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then
                if b.id == "font_down" then CAD.fontBoyutuAyarla(CAD.aktifFontBoyutu - 2)
                elseif b.id == "font_up" then CAD.fontBoyutuAyarla(CAD.aktifFontBoyutu + 2)
                elseif b.id == "font_val" then CAD.mod = "FONT_SIZE" CAD.komutGirdisi = tostring(CAD.aktifFontBoyutu) end
                return
            end
        end
        for _, b in ipairs(CAD.aracButonlari) do
            if fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then
                if b.id == "btn_explode" then CAD.explodeUygula()
                elseif b.id == "btn_array" then CAD.arrayBaslat()
                elseif b.id == "btn_fillet" then CAD.mod = "FILLET_RAD" CAD.komutGirdisi = tostring(CAD.filletRadius)
                elseif b.id == "exp_pdf" then CAD.exportPDF() end
                return
            end
        end
        for _, b in ipairs(CAD.dosyaButonlari) do
            if fx >= b.x and fx <= b.x + b.w and fy >= b.y and fy <= b.y + b.h then
                if b.id == "save_json" then CAD.saveProjectJSON()
                elseif b.id == "load_json" then CAD.loadProjectJSON()
                elseif b.id == "exp_dxf" then CAD.exportDXF()
                elseif b.id == "imp_dxf" then CAD.importDXF() end
                return
            end
        end
        return
    end

    -- Çoklu Sekme Butonları
    if fy >= 112 and fy <= 145 and fx <= 1070 then
        local plusX = 15 + (#CAD.sekmeler) * 125
        if plusX <= 1040 and fx >= plusX and fx <= plusX + 28 and fy >= 115 and fy <= 139 then
            CAD.yeniSekme() return
        end
        for i, _ in ipairs(CAD.sekmeler) do
            local tx = 15 + (i - 1) * 125
            local tw, th, ty = 120, 24, 115
            if fx >= tx + tw - 20 and fx <= tx + tw - 4 and fy >= ty + 2 and fy <= ty + 22 then
                CAD.sekmeKapat(i) return
            elseif fx >= tx and fx <= tx + tw and fy >= ty and fy <= ty + th then
                CAD.sekmeDegistir(i) return
            end
        end
        return
    end

    if (fy <= 145 and fx <= 1070) or fy >= love.graphics.getHeight() - 35 then return end

    if button == 3 or (button == 1 and love.keyboard.isDown("lshift")) then
        CAD.kamera.surukleniyor = true
        CAD.kamera.sonFareX, CAD.kamera.sonFareY = x, y
        return
    end

    if button == 1 then
        local rClr = CAD.renkSözlüğü[CAD.aktifRenkId]
        
        if CAD.mod == "SEC" then
            local obj = CAD.objeBul(dunyaFareX, dunyaFareY)
            if obj then
                obj.secili = not obj.secili
                if obj.secili then table.insert(CAD.seciliObjeler, obj)
                else
                    for i, v in ipairs(CAD.seciliObjeler) do
                        if v == obj then table.remove(CAD.seciliObjeler, i) break end
                    end
                end
                CAD.aktifSekme().seciliObjeler = CAD.seciliObjeler
            else
                CAD.secimKutusu = { x1 = dunyaFareX, y1 = dunyaFareY, x2 = dunyaFareX, y2 = dunyaFareY }
            end
        elseif CAD.mod == "SCALE_BASE" then
            CAD.scaleBase = { x = dunyaFareX, y = dunyaFareY }
            CAD.mod = "SCALE_FACTOR"
            CAD.komutGirdisi = ""
        elseif CAD.mod == "SCALE_REF_1" then
            CAD.scaleRefP1 = { x = dunyaFareX, y = dunyaFareY }
            CAD.mod = "SCALE_REF_2"
            CAD.komutGirdisi = ""
        elseif CAD.mod == "SCALE_REF_2" then
            local dist = math.sqrt((dunyaFareX - CAD.scaleRefP1.x)^2 + (dunyaFareY - CAD.scaleRefP1.y)^2)
            CAD.scaleRefLen = dist
            CAD.scaleRefP1 = nil
            CAD.mod = "SCALE_NEW_LEN"
            CAD.komutGirdisi = ""
        elseif CAD.mod == "CIZGI" then
            if not CAD.geciciCizgi then
                CAD.geciciCizgi = { x1 = dunyaFareX, y1 = dunyaFareY, x2 = dunyaFareX, y2 = dunyaFareY }
            else
                local cObj = { tip = "cizgi", x1 = CAD.geciciCizgi.x1, y1 = CAD.geciciCizgi.y1, x2 = CAD.geciciCizgi.x2, y2 = CAD.geciciCizgi.y2, renk = rClr, cizgiTuru = CAD.aktifCizgiTuru }
                table.insert(CAD.sekliller, cObj)
                Grid:ekle(cObj)
                CAD.geciciCizgi = { x1 = CAD.geciciCizgi.x2, y1 = CAD.geciciCizgi.y2, x2 = dunyaFareX, y2 = dunyaFareY }
            end
        elseif CAD.mod == "CEMBER" then
            if not CAD.geciciCember then
                CAD.geciciCember = { cx = dunyaFareX, cy = dunyaFareY, r = 0 }
            else
                local cbObj = { tip = "cember", cx = CAD.geciciCember.cx, cy = CAD.geciciCember.cy, r = CAD.geciciCember.r, renk = rClr, cizgiTuru = CAD.aktifCizgiTuru }
                table.insert(CAD.sekliller, cbObj)
                Grid:ekle(cbObj)
                CAD.geciciCember = nil
                CAD.mod = "SEC"
            end
        elseif CAD.mod == "DIKDORTGEN" then
            if not CAD.geciciDikdortgen then
                CAD.geciciDikdortgen = { x1 = dunyaFareX, y1 = dunyaFareY, x2 = dunyaFareX, y2 = dunyaFareY }
            else
                local dkObj = { tip = "dikdortgen", x1 = CAD.geciciDikdortgen.x1, y1 = CAD.geciciDikdortgen.y1, x2 = dunyaFareX, y2 = dunyaFareY, renk = rClr, cizgiTuru = CAD.aktifCizgiTuru }
                table.insert(CAD.sekliller, dkObj)
                Grid:ekle(dkObj)
                CAD.geciciDikdortgen = nil
                CAD.mod = "SEC"
            end
        elseif CAD.mod == "YAY" then
            if not CAD.geciciYay then
                CAD.geciciYay = { x1 = dunyaFareX, y1 = dunyaFareY }
                CAD.komutGirdisi = "YAY: 2. Noktayi Tiklayin"
            elseif not CAD.geciciYay.x2 then
                CAD.geciciYay.x2, CAD.geciciYay.y2 = dunyaFareX, dunyaFareY
                CAD.komutGirdisi = "YAY: 3. Noktayi Tiklayin"
            else
                local ux, uy, r, a1, a3 = CAD.ucNoktadanCember(CAD.geciciYay.x1, CAD.geciciYay.y1, CAD.geciciYay.x2, CAD.geciciYay.y2, dunyaFareX, dunyaFareY)
                if ux then
                    local yyObj = { tip = "yay", cx = ux, cy = uy, r = r, a1 = a1, a2 = a3, renk = rClr, cizgiTuru = CAD.aktifCizgiTuru }
                    table.insert(CAD.sekliller, yyObj)
                    Grid:ekle(yyObj)
                end
                CAD.geciciYay = nil
                CAD.mod = "SEC"
                CAD.komutGirdisi = "YAY CIZILDI"
            end
        elseif CAD.mod == "DIM_1" then
            CAD.geciciDim = { x1 = dunyaFareX, y1 = dunyaFareY, x2 = dunyaFareX, y2 = dunyaFareY }
            CAD.mod = "DIM_2"
            CAD.komutGirdisi = "DIM: 2. Noktayi Tiklayin (F8: Ortho)"
        elseif CAD.mod == "DIM_2" then
            local p2x, p2y = dunyaFareX, dunyaFareY
            if CAD.orthoModu and CAD.geciciDim and not CAD.aktifOsnap then
                local dx = math.abs(dunyaFareX - CAD.geciciDim.x1)
                local dy = math.abs(dunyaFareY - CAD.geciciDim.y1)
                if dx > dy then p2y = CAD.geciciDim.y1 else p2x = CAD.geciciDim.x1 end
            end
            CAD.geciciDim.x2, CAD.geciciDim.y2 = p2x, p2y
            CAD.mod = "DIM_3"
            CAD.komutGirdisi = "DIM: Olcu Konumunu Tiklayin"
        elseif CAD.mod == "DIM_3" then
            local g = CAD.geciciDim
            local dx, dy = g.x2 - g.x1, g.y2 - g.y1
            local len = math.sqrt(dx * dx + dy * dy)
            local dist = 25
            if len > 0 then
                local nx, ny = -dy / len, dx / len
                local hedefDim = CAD.objeBul(dunyaFareX, dunyaFareY)
                if hedefDim and hedefDim.tip == "dimension" then
                    local hdx, hdy = hedefDim.x2 - hedefDim.x1, hedefDim.y2 - hedefDim.y1
                    local hlen = math.sqrt(hdx*hdx + hdy*hdy)
                    if hlen > 0 then
                        local hnx, hny = -hdy / hlen, hdx / hlen
                        dist = ((hedefDim.x1 + hnx * hedefDim.offset) - g.x1) * nx + ((hedefDim.y1 + hny * hedefDim.offset) - g.y1) * ny
                    end
                else
                    dist = (dunyaFareX - g.x1) * nx + (dunyaFareY - g.y1) * ny
                end
            end
            local carpan = CAD.birimCarpanlari[CAD.aktifBirim]
            local dObj = {
                tip = "dimension", x1 = g.x1, y1 = g.y1, x2 = g.x2, y2 = g.y2,
                offset = dist, metin = string.format("%.2f %s", len / carpan, CAD.aktifBirim),
                punto = CAD.aktifFontBoyutu, renk = rClr, cizgiTuru = "surekli"
            }
            table.insert(CAD.sekliller, dObj)
            Grid:ekle(dObj)
            
            -- SERİ ÖLÇÜLENDİRME (CONTINUOUS DIMENSION) ZİNCİRİ
            CAD.sonDimBilgi = { x1 = g.x1, y1 = g.y1, x2 = g.x2, y2 = g.y2, offset = dist }
            CAD.geciciDim = { x1 = g.x2, y1 = g.y2, x2 = dunyaFareX, y2 = dunyaFareY, offset = dist }
            CAD.mod = "DIM_CONT"
            CAD.komutGirdisi = "SERI OLCU: Sonraki noktayi tiklayin (F8: Ortho | Cikis: ESC / Sag Tik)"
        elseif CAD.mod == "DIM_CONT" and CAD.sonDimBilgi then
            local prevX, prevY = CAD.sonDimBilgi.x2, CAD.sonDimBilgi.y2
            local nextX, nextY = dunyaFareX, dunyaFareY
            if CAD.orthoModu and not CAD.aktifOsnap then
                local dx = math.abs(nextX - prevX)
                local dy = math.abs(nextY - prevY)
                if dx > dy then nextY = prevY else nextX = prevX end
            end
            local dx, dy = nextX - prevX, nextY - prevY
            local len = math.sqrt(dx * dx + dy * dy)
            if len > 0.001 then
                local carpan = CAD.birimCarpanlari[CAD.aktifBirim]
                local dObj = {
                    tip = "dimension",
                    x1 = prevX, y1 = prevY,
                    x2 = nextX, y2 = nextY,
                    offset = CAD.sonDimBilgi.offset,
                    metin = string.format("%.2f %s", len / carpan, CAD.aktifBirim),
                    punto = CAD.aktifFontBoyutu,
                    renk = rClr,
                    cizgiTuru = "surekli"
                }
                table.insert(CAD.sekliller, dObj)
                Grid:ekle(dObj)
                CAD.sonDimBilgi.x2, CAD.sonDimBilgi.y2 = nextX, nextY
                CAD.geciciDim = { x1 = nextX, y1 = nextY, x2 = nextX, y2 = nextX, offset = CAD.sonDimBilgi.offset }
                CAD.komutGirdisi = "SERI OLCU EKLENDI! Sonraki noktayi tiklayin (F8: Ortho | ESC: Bitir)"
            end
        elseif CAD.mod == "TEXT" then
            CAD.geciciText = { tx = dunyaFareX, ty = dunyaFareY }
            CAD.mod = "TEXT_INPUT"
            CAD.komutGirdisi = ""
        elseif CAD.mod == "ARRAY_POLAR_CENTER" then
            CAD.arrayUygulaPolar(CAD.polarAdet, CAD.polarAci, dunyaFareX, dunyaFareY)
        elseif CAD.mod == "ARRAY_PATH_SELECT" then
            local yolObj = CAD.objeBul(dunyaFareX, dunyaFareY)
            if yolObj and (yolObj.tip == "cizgi" or yolObj.tip == "yay") then
                CAD.arrayUygulaPath(CAD.pathAdet, yolObj)
            else
                CAD.komutGirdisi = "PATH ARRAY: Gecerli cizgi/yay secilmedi!"
            end
        elseif CAD.mod == "ROTATE" then
            if not CAD.manipulasyonBase then
                CAD.manipulasyonBase = { x = dunyaFareX, y = dunyaFareY }
                CAD.komutGirdisi = "ROTATE: Donus Yonunu Secin (0, 90, 180, 270 Snap)"
            else
                local bx, by = CAD.manipulasyonBase.x, CAD.manipulasyonBase.y
                local rawAngle = math.atan2(dunyaFareY - by, dunyaFareX - bx)
                local deg = math.deg(rawAngle)
                local snapDeg = (math.floor((deg + 45) / 90) * 90) % 360
                local aci = math.rad(snapDeg)
                for _, s in ipairs(CAD.seciliObjeler) do
                    local nObj = kopyaDondur(s, bx, by, aci)
                    if nObj then
                        if s.tip == "cizgi" or s.tip == "dimension" or s.tip == "dikdortgen" then
                            s.x1, s.y1, s.x2, s.y2 = nObj.x1, nObj.y1, nObj.x2, nObj.y2
                        elseif s.tip == "cember" or s.tip == "yay" then
                            s.cx, s.cy = nObj.cx, nObj.cy
                            if s.tip == "yay" then s.a1, s.a2 = nObj.a1, nObj.a2 end
                        elseif s.tip == "text" then
                            s.tx, s.ty = nObj.tx, nObj.ty
                        end
                    end
                end
                CAD.manipulasyonBase = nil
                CAD.mod = "SEC"
                Grid:yenile()
                CAD.komutGirdisi = string.format("ROTATE: %d° Donduruldu!", snapDeg)
            end
        elseif CAD.mod == "MOVE" or CAD.mod == "COPY" then
            if not CAD.manipulasyonBase then
                CAD.manipulasyonBase = { x = dunyaFareX, y = dunyaFareY }
                CAD.komutGirdisi = CAD.mod .. ": Hedef Noktayi Tiklayin"
            else
                local bx, by = CAD.manipulasyonBase.x, CAD.manipulasyonBase.y
                local dx, dy = dunyaFareX - bx, dunyaFareY - by
                if CAD.mod == "MOVE" then
                    for _, s in ipairs(CAD.seciliObjeler) do
                        if s.tip == "cizgi" or s.tip == "dimension" or s.tip == "dikdortgen" then
                            s.x1, s.y1 = s.x1 + dx, s.y1 + dy
                            s.x2, s.y2 = s.x2 + dx, s.y2 + dy
                        elseif s.tip == "cember" or s.tip == "yay" then
                            s.cx, s.cy = s.cx + dx, s.cy + dy
                        elseif s.tip == "text" then
                            s.tx, s.ty = s.tx + dx, s.ty + dy
                        end
                    end
                elseif CAD.mod == "COPY" then
                    for _, s in ipairs(CAD.seciliObjeler) do
                        local nObj = kopyaKaydir(s, dx, dy)
                        if nObj then table.insert(CAD.sekliller, nObj) Grid:ekle(nObj) end
                    end
                end
                CAD.manipulasyonBase = nil
                CAD.mod = "SEC"
                Grid:yenile()
                CAD.komutGirdisi = "ISLEM TAMAMLANDI"
            end
        elseif CAD.mod == "TRIM" then
            CAD.trimUygula(dunyaFareX, dunyaFareY)
        elseif CAD.mod == "FILLET" then
            CAD.filletUygula(dunyaFareX, dunyaFareY)
        elseif CAD.mod == "MIRROR" then
            CAD.mirrorUygula(dunyaFareX, dunyaFareY)
        elseif CAD.mod == "HATCH" then
            CAD.hatchUygula(dunyaFareX, dunyaFareY)
        elseif CAD.mod == "OFFSET_SEC" then
            local obj = CAD.objeBul(dunyaFareX, dunyaFareY)
            if obj then
                CAD.offsetHedefObje = obj
                obj.secili = true
                CAD.mod = "OFFSET_YON"
                CAD.komutGirdisi = "Offset Yonunu Tiklayin"
            end
        elseif CAD.mod == "OFFSET_YON" and CAD.offsetHedefObje then
            local nObj = CAD.offsetHesapla(CAD.offsetHedefObje, dunyaFareX, dunyaFareY, CAD.offsetMesafesi)
            if nObj then table.insert(CAD.sekliller, nObj) Grid:ekle(nObj) end
            CAD.offsetHedefObje.secili = false
            CAD.offsetHedefObje = nil
            CAD.mod = "SEC"
            CAD.komutGirdisi = "OFFSET TAMAMLANDI"
        end
    end
end

function love.mousereleased(x, y, button)
    if button == 3 or button == 1 then CAD.kamera.surukleniyor = false end
    if button == 1 and CAD.secimKutusu then
        CAD.secimKutusu.x2, CAD.secimKutusu.y2 = dunyaFareX, dunyaFareY
        CAD.secimKutusuUygula()
        CAD.secimKutusu = nil
    end
end

_G.keypressed_handler = love.keypressed
_G.textinput_handler = love.textinput
