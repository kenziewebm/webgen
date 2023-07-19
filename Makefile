.PHONY: examples

default: install examples

install:
	cp webgen.sh /usr/bin/webgen
	mkdir -p /usr/share/webgen/styles
	cp styles/*.css /usr/share/webgen/styles/
	

examples:
	cd examples ;\
	bash ../webgen.sh code.wg > code.html ;\
	bash ../webgen.sh image.wg > image.html
	#bash ../webgen.sh example.wg > example.html

batconfig:
	mkdir -p ~/.config/bat/syntaxes/webgen
	cp configs/sublime-text/webgen.sublime-syntax  ~/.config/bat/syntaxes/webgen/
	bat cache --buildOA
	
clean:
	rm examples/*.html examples/*.css

uninstall:
	rm /usr/bin/webgen
	rm -rf /usr/share/webgen

