<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:qml="http://cnx.rice.edu/qml/1.0">

	
  <xsl:template match="qml:problemset">
    <div class="problemset">
      <div class="problemsetbefore">Problem Set</div>
    <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="qml:item">
    <div id="thisisanitem_{@id}" name='item' class='qmlitem'>
      <span class="itembefore">Problem <xsl:number level="any" count="qml:item"/>:
      </span>
      <!-- The question. 
      <p><xsl:value-of select="qml:question"/></p>-->
      <xsl:apply-templates />

	    <!--  The form.  Different depending on item-type.  -->

	    <!-- single-response form: a radio button for each response
	    option -->
	    <xsl:if test="@type='single-response'">
	      <form id='single-response_{@id}'>
		<xsl:for-each select="qml:answer">		
		  <input type="radio" value="{@id}" >
		  <!-- if there is a key, onclick submit the item
		  id, the response option id, and the key -->
		  <xsl:if test="count(../qml:key) > 0">
		    <xsl:attribute
		    name="onclick">showAnswer('<xsl:value-of
		    select="../@id" />', '<xsl:value-of select="@id" />', '<xsl:value-of select="../qml:key/@answer" />')</xsl:attribute>
		  </xsl:if>
		  <!-- if there is no key, onclick submit the item
		  id, the response option id, and an indicator of
		  the key not being there -->
		  <xsl:if test="count(../qml:key) = 0">
		    <xsl:attribute
				   name="onclick">showAnswer('<xsl:value-of
									    select="../@id" />', '<xsl:value-of select="@id"
														/>', 'no-key-present')</xsl:attribute>
		  </xsl:if>
		    <!-- to display the value of the response option
		  in xml, we need to have the text outside the input
		  tag; to display it in xhtml, we need to have it
		  inside the input tag.  This may be a mozilla bug
		  that will change later. -->
		  <xsl:value-of select="qml:response" />
		  </input>
		  <xsl:value-of select="qml:response" /> 		
		  <br/>
		</xsl:for-each>
	      </form>
	    </xsl:if>
	    
	    <!-- multiple-response form:  a checkbox for each response
	    option and a Check Answer button -->
	    <xsl:if test="@type='multiple-response'">
	      <form id='multiple-response_{@id}'>
		<xsl:for-each select="qml:answer">		
		  <input type="checkbox" value="{@id}" onclick="addMe('{../@id}', this)">
		    <!-- to display the value of the response option
		  in xml, we need to have the text outside the input
		  tag; to display it in xhtml, we need to have it
		  inside the input tag.  This may be a mozilla bug
		  that will change later. -->
		    <xsl:value-of select="qml:response" /> 		
		  </input>	
		    <xsl:value-of select="qml:response" /> 		
		  <br/>
		</xsl:for-each>
		<input type="button" 
		       value="Check answer">
		<!-- if there is a key, onclick submit the item
		id, the response option id, and the key -->
		<xsl:if test="count(qml:key) > 0">
		  <xsl:attribute
		  name="onclick">showAnswer('<xsl:value-of
		  select="@id" />', document.getElementById['multiple-response_<xsl:value-of select="@id"/>'], '<xsl:value-of select="qml:key/@answer" />')</xsl:attribute>
		</xsl:if>
		<!-- if there is no key, onclick submit the item
		id, the response option id, and an indicator of
		the key not being there -->
		<xsl:if test="count(qml:key) = 0">
		  <xsl:attribute name="onclick">showAnswer('<xsl:value-of select="@id" />', document.getElementById['multiple-response_<xsl:value-of select="@id"/>'], 'no-key-present')</xsl:attribute>
		</xsl:if>
		</input>
	      </form>   
	    </xsl:if>

	    <!-- ordered-response form: a checkbox for each response
	    option and a Check Answer button -->  
	    <xsl:if test="@type='ordered-response'">
	      <form id='ordered-response_{@id}'>
		<xsl:for-each select="qml:answer">		
		  <input type="checkbox" value="{@id}"
		     onclick="addMe('{../@id}', this)">
		    <!-- to display the value of the response option
		  in xml, we need to have the text outside the input
		  tag; to display it in xhtml, we need to have it
		  inside the input tag.  This may be a mozilla bug
		  that will change later. -->
		    <xsl:value-of select="qml:response"/> 		
		  </input>	
		    <xsl:value-of select="qml:response"/> 		
		  <br/>
		</xsl:for-each>
		<input type="button" 
		   value="Check answer">

		<!-- if there is a key, onclick submit the item
		id, the response option id, and the key -->
		<xsl:if test="count(qml:key) > 0">
		  <xsl:attribute name="onclick">showAnswer('<xsl:value-of select="@id" />', document.getElementById['ordered-response_<xsl:value-of select="@id"/>'], '<xsl:value-of select="qml:key/@answer" />')</xsl:attribute>
		</xsl:if>
		
		<!-- if there is no key, onclick submit the item
		id, the response option id, and an indicator of
		the key not being there -->
		<xsl:if test="count(qml:key) = 0">
		  <xsl:attribute name="onclick">showAnswer('<xsl:value-of select="@id" />', document.getElementById['ordered-response_<xsl:value-of select="@id"/>'], 'no-key-present')</xsl:attribute>
		</xsl:if>
		</input>
	      </form>
	    </xsl:if>
	    


	    <!-- text-response form:  a text entry area and a Show
	    Answer button -->
      <xsl:if test="@type='text-response'">
	<xsl:if test="qml:answer">
	      <form id='text-response_{@id}'>
		<textarea cols='30' rows='3'/><br/>
		<input type='button' value='Show answer'>
		<!-- if there is a key, onclick submit the item
		id, the response option id, and the key -->
		<xsl:if test="count(qml:key) > 0">
		  <xsl:attribute name="onclick">showAnswer('<xsl:value-of select="@id" />', document.getElementById['text-response_<xsl:value-of select="@id"/>'], '<xsl:value-of select="qml:key" />')</xsl:attribute>
		</xsl:if>
		<!-- if there is no key, onclick submit the item
		id, the response option id, and an indicator of
		the key not being there -->
		<xsl:if test="count(qml:key) = 0">
		  <xsl:attribute name="onclick">showAnswer('<xsl:value-of select="@id" />', document.getElementById['text-response_<xsl:value-of select="@id"/>'], 'no-key-present')</xsl:attribute>
		</xsl:if>
		</input>
		<br/>
	      </form>
	  </xsl:if>
	    </xsl:if>


	    <!-- Feedback starts here in div tags that are hidden till
	    the user takes an action. -->
	    
	    <div class="feedback" id='correct_{@id}'>
	      Correct!
	    </div>
	    
	    <div class="feedback" id='incorrect_{@id}'>
	      Incorrect.
	    </div>
	    

	    <!-- Answer-specific feedback. -->
	    <xsl:for-each select="qml:answer">
	      <!-- for single, multiple, and ordered-response -->
	      <xsl:if test="count(qml:feedback) = 1">
		<div id='feedbaq_{@id}_{../@id}' class="feedback">
		  <xsl:value-of select="qml:feedback" />
		</div>
	      </xsl:if>
	      <!-- for text-response -->
	      <xsl:if test="count(qml:feedback) = 2">
		<xsl:for-each select="qml:feedback">
		  <div id='feedbaq_{@correct}_{../../@id}' class="feedback">
		    <xsl:value-of select="." />
		  </div>
		</xsl:for-each>
	      </xsl:if>
	    </xsl:for-each>
	    

	   

	    <!-- General feedback. -->
	    <xsl:if test="count(qml:feedback) = 1">
	      <div class="feedback" id='general_{@id}'>
		<xsl:value-of select="qml:feedback" />
	      </div>
	    </xsl:if>
	    <br/><br/>
	    
	    <!-- The hint button and the hints.  Hint button is only
	    made for items containing hints.  -->
	    <xsl:if test="count(qml:hint) > 0">
	      <form>
		<input type="button" 
		       value="Hint"
		       onclick="showHint('{@id}')">
		</input>
	    </form>		
	    <xsl:for-each select="qml:hint">
	      <div class="hint" name="hint"> 
		  <xsl:attribute name="id">hint<xsl:number level="single" 
							   count="hint" 
							   format="0"/>_<xsl:value-of select="../@id" />
		  </xsl:attribute>
		    
		    <xsl:value-of select="."/>
		</div>
	      </xsl:for-each>
	  </xsl:if>
	  
	  </div>
    
  </xsl:template>

  <xsl:template match="qml:question">

    <xsl:apply-templates />
  </xsl:template>


</xsl:stylesheet>













