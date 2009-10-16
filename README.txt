Connexions Packaging of CNXML

   CNXML is a lightweight XML markup language designed for marking up
   educational content
   http://cnx.rice.edu/technology/cnxml/

  - This package includes:

    * RelaxNG definition of CNXML 0.7

    * XSLT stylesheets to convert CNXML 0.5 to 0.6, and CNXML 0.6 to 0.7

    * XSL stylesheets to convert to HTML including CALS table support
      from the DocBook XSL Stylesheets

    * XML and SGML Catalog files

For external developers:

    * Developers on systems other than Debian derivates should use 
      the cnxml-jing.rng schema files, which point to component 
      schema files with relative paths on the local filesystem
    * Debian developers can build .deb packages of CNXML with 
      dpkg-buildpackage – installing the .debs will update the XML
      catalog with schema file locations.
    
To run the tests:

    * ./test/vtest.sh [schema-file]
      Runs on every file whose name ends with the '.xml' extension in sub- and sub-subdirectories of the working directory, and prints all error messages to stdout
      test/test.out contains the output of the tests using the rng file in SVN
      Example: ./test/vtest.sh ./schema/cnxml-jing.rng > ./test/test.out && svn st ./test/test.out
