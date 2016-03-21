#!/usr/bin/python

# Output PostgreSQL statements to create enumerated types for the Top10NL xsd schema

from lxml import etree

doc = etree.parse('TOP10NL_1_1_1.xsd')


for e in doc.findall('{http://www.w3.org/2001/XMLSchema}simpleType'):
    print "CREATE TYPE " + e.get('name').lower() + " AS ENUM ( "

    r = e.find('{http://www.w3.org/2001/XMLSchema}restriction')

    estring = None
    for v in r.findall('{http://www.w3.org/2001/XMLSchema}enumeration'):
        if estring:
            estring += ", '" + v.get('value') + "'"
        else:
            estring  = "  '" + v.get('value') + "'"

    print estring.encode('ascii','ignore') + " );"

