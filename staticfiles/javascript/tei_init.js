async function displayXML(xsl, xml, id) {
    console.log(xsl);
    console.log(xml);
    console.log(id);

    const parser = new DOMParser();
    const xsltProcessor = new XSLTProcessor();

    // Load the XSLT file
    const xslResponse = await fetch(xsl);
    const xslText = await xslResponse.text();
    const xslStylesheet = parser.parseFromString(xslText, "application/xml");
    xsltProcessor.importStylesheet(xslStylesheet);

    // Load the XML file
    const xmlResponse = await fetch(xml);
    const xmlText = await xmlResponse.text();
    const xmlDoc = parser.parseFromString(xmlText, "application/xml");

    const fragment = xsltProcessor.transformToFragment(xmlDoc, document);

    document.getElementById(id).textContent = "";
    document.getElementById(id).appendChild(fragment);

    // Set leading consonants
    $(document).ready(function(){
      $(".consonant-space").each(function() {
        $(this).html($(this).html().split(/[aeiouAEIOUyYůöǒ].*/));
      });
    });
}