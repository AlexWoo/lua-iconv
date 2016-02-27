local ffi = require("ffi")
if jit.os == "OSX" then
    ffi.load("iconv", true)
end

ffi.cdef[[
typedef void* iconv_t;
iconv_t iconv_open(const char *tocode, const char *fromcode);
size_t iconv(iconv_t cd,
    char **inbuf, size_t *inbytesleft,
    char **outbuf, size_t *outbytesleft);
int iconv_close(iconv_t cd);
]]

local _M = {
    _VERSION = '0.01',
}

local mt = { __index = _M }

function _M.new(tocode, fromcode)
    local to = ffi.new("const char *", tocode)
    local from = ffi.new("const char *", fromcode)
    local ctx = ffi.C.iconv_open(tocode, fromcode)
    if ffi.cast("int", ctx) == -1 then
        return nil, ffi.errno()
    end
    ctx = ffi.gc(ctx, ffi.C.iconv_close)

    return setmetatable({ _ctx = ctx }, mt), nil
end

function _M.iconv(self, str)
    if str == nil or #str == 0 then
        return "", nil
    end

    local ret = -1
    local BUFSIZE = 1024
    local out = {}

    while true do
        local inbuf = ffi.new("char[?]", #str)
        ffi.copy(inbuf, str, #str)
        local inbytesleft = ffi.new("size_t[1]", { #str })
        local inbuf_p = ffi.new("char*[1]", { inbuf })

        local outbuf = ffi.new("char[?]", BUFSIZE)
        local outbytesleft = ffi.new("size_t[1]", { BUFSIZE })
        local outbuf_p = ffi.new("char*[1]", { outbuf })

        ret = ffi.C.iconv(self._ctx, inbuf_p, inbytesleft, outbuf_p, outbytesleft)
        if ret == -1 then
            if ffi.errno() == 7 then --E2BIG
                BUFSIZE = BUFSIZE * 2
            else
                return table.concat(out), ffi.errno()
            end
        else
            table.insert(out, ffi.string(outbuf, BUFSIZE - outbytesleft[0]))
            if inbytesleft[0] == 0 then
                break
            end
        end
    end

    return table.concat(out), nil
end

return _M
