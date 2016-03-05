PATH  := node_modules/.bin:$(PATH)
SHELL := /bin/bash

styles_src = $(shell find src/styles -name "*.css")
styles_target = $(styles_src:%.css=dist/styles/styles.css)

$(styles_target): $(styles_src)
	mkdir -p $(dir $@)
	postcss \
	--local-plugins \
	--no-map.inline \
	--use postcss-partial-import \
	--use postcss-discard-comments \
	--use postcss-discard-empty \
	--use postcss-cssnext \
	--output $@ $<

clean:
		rm -Rf dist
