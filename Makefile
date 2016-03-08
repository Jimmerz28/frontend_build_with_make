PATH  := node_modules/.bin:$(PATH)
SHELL := /bin/bash

# CSS Rules
styles_src := src/styles/brains.css
styles_target := dist/css/brains.css

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
	--use postcss-cssnext \
	--use postcss-discard-comments \
	--use postcss-discard-empty \
	--output $@ $<

$(html_target): $(html_src)
	mkdir -p $(dir $@)
	cp $(html_src) $(html_target)

styles: $(styles_target)

copy: $(html_target)

clean:
	rm -Rf dist

serve:
	http-server ./dist
