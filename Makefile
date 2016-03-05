PATH  := node_modules/.bin:$(PATH)
SHELL := /bin/bash

# CSS Rules
styles_src = $(shell find src/styles -name "*.css")
styles_target = $(styles_src:%.css=dist/css/brains.css)

# HTML
html_src = src/index.html
html_target = dist/index.html

.PHONY: clean copy serve

# Build our CSS files
# TODO: Check how we should deploy them under HTTP/2
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

$(html_target): $(html_src)
	mkdir -p $(dir $@)
	cp $(html_src) $(html_target)


copy: $(html_target)

client: clean $(styles_target) $(html_target) serve

clean:
		rm -Rf dist
