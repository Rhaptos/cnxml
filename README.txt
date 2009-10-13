Connexions Packaging of CNXML

   CNXML is a lightweight XML markup language designed for marking up
   educational content
   http://cnx.rice.edu/technology/cnxml/

  - This package includes:

    * DTD, XML Schema, and RelaxNG definitions of CNXML as defined at
      http://cnx.rice.edu/technology/cnxml/0.5/spec/

    * XSL stylesheets to convert to HTML including CALS table support
      from the DocBook XSL Stylesheets

    * Customizations for Altova's XMLSpy and Authentic editors

    * XML and SGML Catalog files

To install:

    * Run the included 'install.sh' command.  You may need to perform
      this as root.

For external developers:

    * For non-debian systems use the Jing files in the correct locations.
    * For debian developers, install the catalog using the debian/ directory.
    
To run the tests:

    * ./test/vtest.sh [schema-file]
      Runs on every file in the xml/ and */xml/ dirs and prints all error messages to stdout
      test/test.out contains the output of the tests using the rng file in SVN
      Example: ./test/vtest.sh ./schema/cnxml-jing.rng > ./test/test.out && svn st ./test/test.out
