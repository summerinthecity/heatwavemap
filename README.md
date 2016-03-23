summerinthecity
===============

See [here](http://jiskattema.github.io/summerinthecity/) for an interactive heatwave map for the Netherlands.

This repository contains a set of postgres functions I used for creating a high resolution urban map of the Netherlands.
The following data is used:

 * OHN: Object Hoogten Nederland, de hoogte van alles wat boven het maaiveld uitsteekt, Henk Kramer, Jan Clement, en Sander Mücher, Geo-Info 2014-3, pag 18-21, based on the [Actueel Hoogtebestand Nederland, version 2](http://www.ahn.nl)
 * [Grondsoortenkaart van Nederland](http://www.wageningenur.nl/nl/show/Grondsoortenkaart.htm), WUR-Alterra 2006
 * [Wijk- en buurtkaart 2012 versie 3](http://www.cbs.nl/nl-NL/menu/themas/dossiers/nederland-regionaal/publicaties/geografische-data/archief/2013/2013-2012-b68-pub.htm),Kadaster / Centraal Bureau voor de Statistiek, 2014
 * [Digitale Kleuren Luchtfoto Nederland 2008 (DKLN2008)](http://www.bestel3d.nl/nl/en/data/dkln-imagery),Copyright Eurosense B.V.,2008

The input data is assumed to be available in a postgres database with postgis extensions installed.

This work can be cites as:

Summer in the City: Forecasting and Mapping Human Thermal Comfort in Urban Areas Attema, J.J. and Heusinkveld, B.G. and Ronda, R.J. and Steeneveld, G.J. and Holtslag, A.A.M.  IEEE 11th International Conference on e-Science (2015)(http://dx.doi.org/10.1109/eScience.2015.21)

Note that these scripts are mostly provided for reference, and are not necessarily the best or most efficient way to do things.  If I were to repeat this excercise, I would try to work with rasterized data as much as possible.
