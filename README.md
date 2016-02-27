# lua-iconv
---
## Instructions

Convert the encoding of characters from one codeset to another using iconv in C Lib

This module based on luajit, must run with luajit

It can be used in Mac and Linux

## API

Usually, It can be used as below:

	local iconv = require("iconv")
	local cd = iconv.new("utf8", "gb2312")
	str = cd:iconv(text)

- iconv.new(tocode, fromcode)

	Create a iconv object converting the encoding of characters in file from fromcode codeset to tocode codeset

	If successd return iconv object and nil errno; if failed return nil iconv object and errno of C-Lang

- iconv:iconv(text)

	Covert text following as iconv.new set.

	If successd, return string after covertion and nil errno; if failed, return nil string and errno of C-Lang

## Test

The test.lua is copied and modify from [https://github.com/ittner/lua-iconv](https://github.com/ittner/lua-iconv)
