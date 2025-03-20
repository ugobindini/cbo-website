import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'cbo_website.settings')

import django
django.setup()

import xml.etree.ElementTree as ET

from browse.models import Source


def source_to_tei(source):
    res = ET.Element("msDesc")
    msIdentifier = ET.Element("msIdentifier")
    country = ET.Element("country")
    country.text = source.country
    msIdentifier.append(country)
    settlement = ET.Element("settlement")
    splitted_location = source.location.split(', ', 1)
    if len(splitted_location) >= 2:
        settlement.text = splitted_location[0]
    else:
        settlement.text = "city"
    msIdentifier.append(settlement)
    institution = ET.Element("institution")
    if len(splitted_location) >= 2:
        institution.text = splitted_location[1]
    else:
        institution.text = source.location
    msIdentifier.append(institution)
    idno = ET.Element("idno")
    idno.text = source.bib_id
    msIdentifier.append(idno)
    if len(source.nick_name):
        msName = ET.Element("msName")
        msName.text = source.nick_name
        msIdentifier.append(msName)
    res.append(msIdentifier)
    res.append(ET.Element("head"))
    res.append(ET.Element("msContents"))
    res.append(ET.Element("physDesc"))
    res.append(ET.Element("history"))
    res.append(ET.Element("additional"))
    res.append(ET.Element("msPart"))
    res.append(ET.Element("msFrag"))
    return res


if __name__ == "__main__":
    n = 0
    for source in Source.objects.all():
        if n < 16:
            filename = ''.join(c for c in source.bib_id if c.isalnum())
            out_file = open(f"source_tei/{filename}.tei", "a")
            out_file.write(source.century + "\n")
            out_file.write(source.notation + "\n")
            out_file.write(source.notes + "\n")
            out_file.close()
        n += 1
