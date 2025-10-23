#!/usr/bin/env python3

# Rendering the .tei files as html, with basic formatting (italics, bold) and no musical information

import os


def to_paragraph(p):
	# parsing this element as paragraph (no more tags needed)
	res = ""
	for el in p.xpath(".//w|.//pc[@resp='#editor']"):
		if el.xpath("./ancestor::rdg") or el.xpath("./ancestor::note"):
			# exclude words in app-readings or app-notes
			pass
		else:
			syllables = el.xpath("./seg[@type='syll']|./app[@type='neume']/lem/seg[@type='syll']")
			if not len(syllables):
				res += el.text
			else:
				res += "".join([syllable.text for syllable in syllables])
		res += " "
	for pc in [',', ';', ':', '.', '!', '?', '»']:
		for i in range(3):
			res = res.replace(f" {pc}", pc)
	for pc in ['«']:
		for i in range(3):
			res = res.replace(f"{pc} ", pc)
	return res


def to_html(tei_file):
	res = "<html>\n<body>\n"
	from lxml import etree
	xml = etree.parse('tei/' + tei_file)
	for el in xml.xpath(".//stage|.//p|.//lg|.//head"):
		print(el)
		if el.tag == 'stage':
			res += "<p><i>"
			res += to_paragraph(el)
			res += "</i></p>\n"
		elif el.tag == 'p':
			res += "<p>"
			res += to_paragraph(el)
			res += "</p>\n"
		elif el.tag == 'lg':
			if 'n' in el.attrib.keys():
				res += "<p><b>" + el.attrib['n'] + "</b></p>\n"
			for line in el.findall('l'):
				res += "<p>"
				res += to_paragraph(line)
				res += "</p>\n"
		elif el.tag == 'head':
			res += "<p><b>" + el.text + "</b></p>\n"
	res += "</html>\n</body>\n"
	return res


if __name__ == "__main__":
	for file in os.listdir('tei'):
		if file.endswith('.tei'):
			html_file = open('html/' + file[:-3] + "html", 'w')
			html_file.write(to_html(file))
			html_file.close()
