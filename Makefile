all: pdf ps dvi html-split html-single css plain nroff

pdf: release/send_file.pdf
ps: release/send_file.ps
dvi: release/send_file.dvi
html-split: release/0.html
html-single: release/send_file.html
css: release/main.css
plain: release/send_file.txt
nroff: release/send_file.nrf

src/m_docid.ud: src/m_docid.sh
	(cd src && ./m_docid.sh > m_docid.ud.tmp && mv m_docid.ud.tmp m_docid.ud)

src/m_supp.ud: src/m_supp.sh
	(cd src && ./m_supp.sh m_supp.txt > m_supp.ud.tmp && mv m_supp.ud.tmp m_supp.ud)

src/t-send_file_exp.ud: src/t-send_file_exp.sh
	(cd src && ./t-send_file_exp.sh > t-send_file_exp.ud.tmp && mv t-send_file_exp.ud.tmp t-send_file_exp.ud)

build/0.tex: src/main.ud src/m_docid.ud src/m_supp.ud src/t-send_file_exp.ud
	(cd src && udoc-render -s 1 -r context main.ud ../build)

build/send_file.dvi: build/0.tex src/m_docid.ud src/m_supp.ud src/t-send_file_exp.ud
	(cd build && texexec --batch 0.tex && mv 0.dvi send_file.dvi)
release/send_file.dvi: build/send_file.dvi
	cp build/send_file.dvi release/send_file.dvi

build/send_file.pdf: build/0.tex
	(cd build && texexec --batch --pdf 0.tex && mv 0.pdf send_file.pdf)
release/send_file.pdf: build/send_file.pdf
	cp build/send_file.pdf release/send_file.pdf

build/send_file.ps: build/send_file.pdf
	(cd build && pdf2ps send_file.pdf send_file.ps)
release/send_file.ps: build/send_file.ps
	cp build/send_file.ps release/send_file.ps

release/send_file.html: src/main.ud src/m_docid.ud src/m_supp.ud src/t-send_file_exp.ud css
	(cd src && udoc-render -s 0 -r xhtml main.ud ../build)
	cp build/0.html release/send_file.html

release/0.html: src/main.ud src/m_docid.ud src/m_supp.ud src/t-send_file_exp.ud css
	(cd src && udoc-render -s 2 -r xhtml main.ud ../build)
	cp build/*.html release

release/main.css: src/main.css
	cp src/main.css build
	cp build/main.css release

release/send_file.txt: src/main.ud src/m_docid.ud src/m_supp.ud src/t-send_file_exp.ud
	(cd src && udoc-render -r plain main.ud ../build)
	cp build/0.txt release/send_file.txt

release/send_file.nrf: src/main.ud src/m_docid.ud src/m_supp.ud src/t-send_file_exp.ud
	(cd src && udoc-render -r nroff main.ud ../build)
	cp build/0.nrf release/send_file.nrf

clean:
	rm -f src/m_docid.ud src/m_supp.ud src/t-send_file_exp.ud
	rm -f build/*
	rm -f release/*

clean-all: clean
