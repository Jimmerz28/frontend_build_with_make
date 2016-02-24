PATH  := node_modules/.bin:$(PATH)
SHELL := /bin/bash

styles_src = $(shell find src/styles -name "*.css")
styles_target = $(styles_src:%.css=dist/%.css)

$(styles_target): $(styles_src)
	mkdir -p $(dir $@)
	postcss \
	--use postcss-cssnext \
	--output $@ $<
