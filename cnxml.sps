<?xml version="1.0" encoding="UTF-8"?>
<structure version="2" schemafile="http://cnx.rice.edu/technology/cnxml/schema/xsd/0.5/cnxml.xsd" workingxmlfile="" templatexmlfile="http://cnx.rice.edu/technology/cnxml/misc/xmlspy_template.xml">
	<xmltablesupport standard="CALS">
		<usertags>
			<usertag default="title" username="name"/>
		</usertags>
	</xmltablesupport>
	<nspair prefix="n1" uri="http://cnx.rice.edu/cnxml"/>
	<nspair prefix="bib" uri="http://bibtexml.sf.net/"/>
	<nspair prefix="m" uri="http://www.w3.org/1998/Math/MathML"/>
	<nspair prefix="md" uri="http://cnx.rice.edu/mdml/0.4"/>
	<nspair prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<template>
		<match overwrittenxslmatch="/"/>
		<children>
			<template>
				<match match="n1:document"/>
				<children>
					<table>
						<properties border="1" width="100%"/>
						<children>
							<tablebody>
								<children>
									<tablerow>
										<properties bgcolor="6699cc"/>
										<children>
											<tablecol>
												<properties height="80"/>
												<children>
													<text fixtext=" "/>
													<text fixtext="Title:">
														<styles color="white" font-family="Arial" font-size="large" font-weight="bold"/>
													</text>
													<xpath>
														<styles color="white" font-family="Arial" font-size="large" font-weight="bold"/>
														<match match="n1:name"/>
													</xpath>
													<text fixtext=" ">
														<styles font-weight="bold"/>
													</text>
												</children>
											</tablecol>
										</children>
									</tablerow>
									<tablerow>
										<properties bgcolor="white"/>
										<children>
											<tablecol>
												<properties height="20"/>
												<children>
													<text fixtext="(id:">
														<styles border-style="none"/>
													</text>
													<template>
														<match match="@id"/>
														<children>
															<text fixtext=" ">
																<styles border-style="none"/>
															</text>
															<xpath allchildren="1">
																<styles border-style="none" color="red" font-size="smaller" font-style="italic"/>
															</xpath>
															<text fixtext=" ">
																<styles border-style="none"/>
															</text>
														</children>
													</template>
													<text fixtext=")"/>
												</children>
											</tablecol>
										</children>
									</tablerow>
								</children>
							</tablebody>
						</children>
					</table>
					<template>
						<editorproperties adding="no" autoaddname="1" editable="1" markupmode="hide"/>
						<match match="n1:content"/>
						<children>
							<newline/>
							<xpath allchildren="1"/>
							<newline/>
						</children>
					</template>
					<newline/>
					<template>
						<match match="n1:glossary"/>
						<children>
							<text fixtext=" ">
								<styles border-style="none"/>
							</text>
							<newline/>
							<table>
								<properties border="1" width="100%"/>
								<children>
									<tablebody>
										<children>
											<tablerow>
												<properties bgcolor="6699cc"/>
												<children>
													<tablecol>
														<children>
															<text fixtext="Glossary">
																<styles border-style="none" color="white" font-family="Arial" font-size="large"/>
															</text>
														</children>
													</tablecol>
												</children>
											</tablerow>
											<tablerow>
												<children>
													<tablecol>
														<properties height="80"/>
														<children>
															<xpath allchildren="1">
																<styles border-style="none"/>
															</xpath>
														</children>
													</tablecol>
												</children>
											</tablerow>
										</children>
									</tablebody>
								</children>
							</table>
						</children>
					</template>
					<newline/>
					<template>
						<match match="bib:file"/>
						<children>
							<table>
								<properties border="1" width="100%"/>
								<children>
									<tablebody>
										<children>
											<tablerow>
												<properties bgcolor="6699cc"/>
												<children>
													<tablecol>
														<children>
															<text fixtext="Bibliography">
																<styles border-style="none" color="white" font-family="Arial" font-size="large"/>
															</text>
														</children>
													</tablecol>
												</children>
											</tablerow>
											<tablerow>
												<children>
													<tablecol>
														<properties height="80"/>
														<children>
															<xpath allchildren="1">
																<styles border-style="none"/>
															</xpath>
														</children>
													</tablecol>
												</children>
											</tablerow>
										</children>
									</tablebody>
								</children>
							</table>
						</children>
					</template>
					<newline/>
				</children>
			</template>
		</children>
	</template>
	<template>
		<match match="bib:article"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="5" width="64"/>
										<children>
											<text fixtext="Article">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties height="22" rowspan="2" valign="center" width="46"/>
									</tablecol>
									<tablecol>
										<properties height="22"/>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<properties height="22"/>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<properties height="22"/>
										<children>
											<text fixtext="Journal">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<properties height="22"/>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:journal"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:author"/>
		<children>
			<text fixtext="Author: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:book"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="5" width="64"/>
										<children>
											<text fixtext="Book">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author or Editor">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Publisher">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
											<newline/>
											<template>
												<match match="bib:editor"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:publisher"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:booklet"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="2" width="64"/>
										<children>
											<text fixtext="Booklet">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="26"/>
									</tablecol>
									<tablecol>
										<properties width="454"/>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties width="454"/>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:chapter"/>
		<children>
			<text fixtext="Chapter: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:conference"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="6" width="64"/>
										<children>
											<text fixtext="Conference">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Book Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Other">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:booktitle"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<xpath restofcontents="1"/>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:crossref"/>
		<children>
			<text fixtext="Crossref: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:edition"/>
		<children>
			<text fixtext="Edition: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:editor"/>
		<children>
			<text fixtext="Editor: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:entry"/>
		<children>
			<newline/>
			<text fixtext="(Entry id:"/>
			<template>
				<match match="@id"/>
				<children>
					<xpath allchildren="1">
						<styles color="red" font-style="italic"/>
					</xpath>
				</children>
			</template>
			<text fixtext=")"/>
			<xpath allchildren="1"/>
			<newline/>
		</children>
	</template>
	<template>
		<match match="bib:file"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="bib:howpublished"/>
		<children>
			<text fixtext="How Published: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:inbook"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="6" width="64"/>
										<children>
											<text fixtext="Inbook">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Pages">
												<styles font-weight="bold"/>
											</text>
											<text>
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Publisher">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:pages"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:publisher"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:incollection"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="6" width="64"/>
										<children>
											<text fixtext="Incollection">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
											<text>
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Book Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Publisher">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<properties width="176"/>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:booktitle"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:publisher"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<properties width="176"/>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:inproceedings"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="5" width="64"/>
										<children>
											<text fixtext="Inproceedings">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Book Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:booktitle"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:institution"/>
		<children>
			<text fixtext="Institution: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:journal"/>
		<children>
			<text fixtext="Journal: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:key"/>
		<children>
			<text fixtext="Key: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:manual"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="2" width="64"/>
										<children>
											<text fixtext="Manual">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<properties width="399"/>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties width="399"/>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:mastersthesis"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="5" width="64"/>
										<children>
											<text fixtext="Master&apos;s Thesis">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="School">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Other">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:school"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<xpath restofcontents="1"/>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:misc"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="2" width="64"/>
										<children>
											<text fixtext="Misc.">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Other">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<xpath allchildren="1"/>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:month"/>
		<children>
			<text fixtext="Month: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:note"/>
		<children>
			<text fixtext="Note: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" "/>
		</children>
	</template>
	<template>
		<match match="bib:number"/>
		<children>
			<text fixtext="Number: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:organization"/>
		<children>
			<text fixtext="Organization: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:pages"/>
		<children>
			<text fixtext="Pages: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:phdthesis"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="5" width="64"/>
										<children>
											<text fixtext="Phd&apos;s Thesis">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="School">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:school"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:proceedings"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="3" width="64"/>
										<children>
											<text fixtext="Proceedings">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:publisher"/>
		<children>
			<text fixtext="Publisher: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:school"/>
		<children>
			<text fixtext="School: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:series"/>
		<children>
			<text fixtext="Series: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:techreport"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="5" width="64"/>
										<children>
											<text fixtext="Tech Report">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Institution">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Year">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:institution"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:year"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:title"/>
		<children>
			<text fixtext="Title: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:type"/>
		<children>
			<text fixtext="Type: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:unpublished"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties bgcolor="gray" colspan="4" width="64"/>
										<children>
											<text fixtext="Unpublished">
												<styles color="white" font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties rowspan="2" valign="center" width="64"/>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Author">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Title">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<text fixtext="Note">
												<styles font-weight="bold"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<template>
												<match match="bib:author"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:title"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
									<tablecol>
										<children>
											<template>
												<match match="bib:note"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="bib:volume"/>
		<children>
			<text fixtext="Volume: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="bib:year"/>
		<children>
			<text fixtext="Year: ">
				<styles left="15px" margin-left="15px"/>
			</text>
			<xpath allchildren="1">
				<styles left="15px"/>
			</xpath>
			<text fixtext=" ">
				<styles left="15px"/>
			</text>
		</children>
	</template>
	<template>
		<match match="m:xor"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:caption"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:cite"/>
		<children>
			<xpath allchildren="1">
				<styles font-style="italic"/>
			</xpath>
			<text fixtext=" (optional src:">
				<styles font-size="smaller"/>
			</text>
			<template>
				<match match="@src"/>
				<children>
					<xpath allchildren="1">
						<styles color="blue" font-size="smaller" text-decoration="underline"/>
					</xpath>
				</children>
			</template>
			<text fixtext=")">
				<styles font-size="smaller"/>
			</text>
		</children>
	</template>
	<template>
		<match match="n1:cnxn"/>
		<children>
			<xpath allchildren="1">
				<styles color="olive" text-decoration="underline"/>
			</xpath>
			<text fixtext="(target: ">
				<styles font-size="smaller"/>
			</text>
			<template>
				<match match="@target"/>
				<children>
					<xpath allchildren="1">
						<styles font-size="smaller"/>
					</xpath>
				</children>
			</template>
			<text fixtext=")(optional document:">
				<styles font-size="smaller"/>
			</text>
			<template>
				<match match="@document"/>
				<children>
					<xpath allchildren="1">
						<styles font-size="smaller"/>
					</xpath>
				</children>
			</template>
			<text fixtext=")">
				<styles font-size="smaller"/>
			</text>
		</children>
	</template>
	<template>
		<match match="n1:code"/>
		<children>
			<choice>
				<styles font-family="courier new" font-size="small"/>
				<children>
					<choiceoption>
						<testexpression>
							<xpath value="@type=&apos;block&apos;"/>
						</testexpression>
						<children>
							<paragraph paragraphtag="pre">
								<children>
									<xpath allchildren="1">
										<styles font-family="courier new" font-size="small"/>
									</xpath>
									<template>
										<match match="@type"/>
										<children>
											<select ownvalue="1">
												<styles font-size="small"/>
												<properties size="0"/>
												<selectoption description="inline" value="inline"/>
												<selectoption description="block" value="block"/>
											</select>
										</children>
									</template>
								</children>
							</paragraph>
						</children>
					</choiceoption>
					<choiceoption>
						<children>
							<xpath allchildren="1">
								<styles font-family="courier new" font-size="small"/>
							</xpath>
							<template>
								<match match="@type"/>
								<children>
									<select ownvalue="1">
										<styles font-size="small"/>
										<properties size="0"/>
										<selectoption description="inline" value="inline"/>
										<selectoption description="block" value="block"/>
									</select>
								</children>
							</template>
						</children>
					</choiceoption>
				</children>
			</choice>
		</children>
	</template>
	<template>
		<match match="n1:colspec"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<editorproperties adding="mandatory" autoaddname="1" editable="1" markupmode="hide"/>
		<match match="n1:definition"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<properties bgcolor="#000080"/>
								<children>
									<tablecol>
										<properties colspan="2"/>
										<children>
											<text fixtext="Definition">
												<styles color="white" font-weight="bold"/>
											</text>
											<text fixtext=" ">
												<styles color="white"/>
											</text>
											<text fixtext="(id:">
												<styles color="white" font-size="smaller"/>
											</text>
											<template>
												<editorproperties adding="mandatory" autoaddname="1" editable="1" markupmode="hide"/>
												<match match="@id"/>
												<children>
													<text fixtext=" ">
														<styles color="white" font-size="smaller"/>
													</text>
													<xpath allchildren="1">
														<styles color="white" font-size="smaller" font-style="italic"/>
													</xpath>
													<text fixtext=" ">
														<styles color="white" font-size="smaller"/>
													</text>
												</children>
											</template>
											<text fixtext=")">
												<styles color="white" font-size="smaller"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol/>
									<tablecol>
										<children>
											<text fixtext="Term:">
												<styles font-size="small" font-weight="bold"/>
											</text>
											<text fixtext=" ">
												<styles font-size="smaller" font-weight="bold"/>
											</text>
											<template>
												<editorproperties adding="mandatory" autoaddname="1" editable="1" markupmode="small"/>
												<match match="n1:term"/>
												<children>
													<text fixtext=" "/>
													<xpath allchildren="1">
														<styles color="black" font-size="small" font-style="normal" font-weight="bold"/>
													</xpath>
													<text fixtext=" "/>
												</children>
											</template>
											<newline/>
											<text fixtext="Meaning: ">
												<styles font-size="small" font-weight="bold"/>
											</text>
											<template>
												<editorproperties adding="mandatory" autoaddname="1" editable="1" markupmode="small"/>
												<match match="n1:meaning"/>
												<children>
													<text fixtext=" "/>
													<xpath allchildren="1">
														<styles color="black" font-size="small" font-style="normal"/>
													</xpath>
													<text fixtext=" "/>
												</children>
											</template>
											<newline/>
											<text fixtext="optional:">
												<styles font-size="smaller"/>
											</text>
											<template>
												<match match="n1:seealso"/>
												<children>
													<text fixtext=" "/>
													<newline/>
													<text fixtext="See also:">
														<styles font-size="smaller" font-weight="bold"/>
													</text>
													<text fixtext=" ">
														<styles font-weight="bold"/>
													</text>
													<newline/>
													<text fixtext=" "/>
													<xpath allchildren="1"/>
													<newline/>
												</children>
											</template>
											<newline/>
											<text fixtext="optional:">
												<styles font-size="smaller"/>
											</text>
											<template>
												<match match="n1:example"/>
												<children>
													<newline/>
													<text fixtext="Example:">
														<styles font-size="smaller" font-weight="bold"/>
													</text>
													<text fixtext=" ">
														<styles font-size="smaller"/>
													</text>
													<xpath allchildren="1"/>
													<newline/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:emphasis"/>
		<children>
			<xpath allchildren="1">
				<styles font-style="italic"/>
			</xpath>
		</children>
	</template>
	<template>
		<match match="n1:entry"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:entrytbl"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:equation"/>
		<children>
			<newline/>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties align="left" colspan="2" width="280"/>
										<children>
											<text fixtext="Equation ">
												<styles display="inline" font-weight="bold" margin-top="10em" vertical-align="auto"/>
											</text>
											<text fixtext="(id: ">
												<styles margin-top="10em"/>
											</text>
											<template>
												<match match="@id"/>
												<children>
													<text fixtext=" "/>
													<xpath allchildren="1">
														<styles color="red" font-style="italic" margin-top="10em"/>
													</xpath>
													<text fixtext=" "/>
												</children>
											</template>
											<text fixtext=") ">
												<styles margin-top="10em"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties align="center" colspan="2" width="280"/>
										<children>
											<text fixtext="optional name:">
												<styles display="inline" margin-top="10em" vertical-align="auto"/>
											</text>
											<template>
												<match match="n1:name"/>
												<children>
													<text fixtext=" "/>
													<xpath allchildren="1">
														<styles display="inline" font-weight="bold" margin-top="10em" vertical-align="auto"/>
													</xpath>
													<text fixtext=" "/>
												</children>
											</template>
											<newline/>
											<xpath restofcontents="1">
												<styles margin-top="10em"/>
											</xpath>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
			<paragraph paragraphtag="p">
				<properties align="center"/>
				<children>
					<newline/>
				</children>
			</paragraph>
		</children>
	</template>
	<template>
		<match match="n1:example"/>
		<children>
			<newline/>
			<table>
				<properties border="1" cellspacing="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<text fixtext="Example">
												<styles font-weight="bold"/>
											</text>
											<text fixtext=" (id:"/>
											<template>
												<match match="@id"/>
												<children>
													<xpath allchildren="1">
														<styles color="red" font-style="italic"/>
													</xpath>
													<text fixtext=" "/>
												</children>
											</template>
											<text fixtext=")"/>
											<newline/>
											<text fixtext="optional: name:"/>
											<template>
												<match match="n1:name"/>
												<children>
													<xpath allchildren="1">
														<styles border-color="#000000" border-style="none" border-width="thin" font-weight="bold"/>
													</xpath>
												</children>
											</template>
											<newline/>
											<xpath restofcontents="1"/>
											<newline/>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:exercise"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<properties bgcolor="#000080"/>
								<children>
									<tablecol>
										<properties colspan="2"/>
										<children>
											<text fixtext="Exercise:">
												<styles color="white" font-weight="bold"/>
											</text>
											<text fixtext="(id:">
												<styles color="white" font-weight="normal"/>
											</text>
											<template>
												<match match="@id"/>
												<children>
													<xpath allchildren="1">
														<styles color="white" font-style="italic" font-weight="normal"/>
													</xpath>
												</children>
											</template>
											<text fixtext=")">
												<styles color="white" font-weight="normal"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol/>
									<tablecol>
										<children>
											<template>
												<match match="n1:problem"/>
												<children>
													<text fixtext="Problem:">
														<styles font-size="smaller" font-weight="bold"/>
													</text>
													<xpath allchildren="1"/>
												</children>
											</template>
											<newline/>
											<text fixtext="optional: ">
												<styles font-size="smaller"/>
											</text>
											<template>
												<match match="n1:solution"/>
												<children>
													<newline/>
													<text fixtext="Solution: ">
														<styles font-size="smaller" font-weight="bold"/>
													</text>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:figure"/>
		<children>
			<newline/>
			<newline/>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<properties bgcolor="#4080BF"/>
								<children>
									<tablecol>
										<properties align="left"/>
										<children>
											<text fixtext="Figure">
												<styles color="white" font-weight="bold"/>
											</text>
											<text fixtext=" (id:">
												<styles color="white"/>
											</text>
											<template>
												<match match="@id"/>
												<children>
													<xpath allchildren="1">
														<styles color="white" font-style="italic"/>
													</xpath>
													<text fixtext=" ">
														<styles color="white"/>
													</text>
												</children>
											</template>
											<text fixtext=")">
												<styles color="white"/>
											</text>
											<template>
												<match match="@orient"/>
												<children>
													<select ownvalue="1">
														<properties size="0"/>
														<selectoption description="vertical" value="vertical"/>
														<selectoption description="horizontal" value="horizontal"/>
													</select>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties align="center"/>
										<children>
											<text fixtext="optional figure name:"/>
											<template>
												<match match="n1:name"/>
												<children>
													<xpath allchildren="1">
														<styles font-weight="bold"/>
													</xpath>
												</children>
											</template>
											<newline/>
											<xpath restofcontents="1"/>
											<newline/>
											<text fixtext="optional figure caption: "/>
											<template>
												<match match="n1:caption"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:foreign"/>
		<children>
			<xpath allchildren="1">
				<styles font-style="italic"/>
			</xpath>
		</children>
	</template>
	<template>
		<match match="n1:glossary"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:item"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:link"/>
		<children>
			<link>
				<hyperlink>
					<xpath value="@src"/>
				</hyperlink>
				<children>
					<xpath allchildren="1">
						<styles color="#996600"/>
					</xpath>
				</children>
			</link>
			<text fixtext="(src: ">
				<styles font-size="smaller"/>
			</text>
			<template>
				<match match="@src"/>
				<children>
					<xpath allchildren="1">
						<styles color="blue" font-size="smaller" text-decoration="underline"/>
					</xpath>
				</children>
			</template>
			<text fixtext=")">
				<styles font-size="smaller"/>
			</text>
		</children>
	</template>
	<template>
		<match match="n1:list"/>
		<children>
			<paragraph paragraphtag="p">
				<children>
					<text fixtext="List ">
						<styles font-weight="bold"/>
					</text>
					<text fixtext="(id:"/>
					<template>
						<match match="@id"/>
						<children>
							<xpath allchildren="1">
								<styles color="red" font-size="smaller" font-style="italic"/>
							</xpath>
							<text fixtext=" "/>
						</children>
					</template>
					<text fixtext=")"/>
					<newline/>
					<text fixtext="optional name:">
						<styles font-size="smaller"/>
					</text>
					<text fixtext=" "/>
					<xpath>
						<match match="n1:name"/>
					</xpath>
					<newline/>
					<template>
						<match match="@type"/>
						<children>
							<select ownvalue="1">
								<properties size="0"/>
								<selectoption description="Numbered" value="enumerated"/>
								<selectoption description="Bulleted" value="bulleted"/>
							</select>
						</children>
					</template>
					<newline/>
					<choice>
						<children>
							<choiceoption>
								<testexpression>
									<xpath value="@type  = &apos;enumerated&apos;"/>
								</testexpression>
								<children>
									<template>
										<match match="n1:item"/>
										<children>
											<list dynamic="1" ordered="1">
												<styles margin-bottom="0" margin-top="0"/>
												<properties start="1" type="1"/>
												<children>
													<listrow>
														<children>
															<xpath allchildren="1"/>
														</children>
													</listrow>
												</children>
											</list>
										</children>
									</template>
								</children>
							</choiceoption>
							<choiceoption>
								<children>
									<template>
										<match match="n1:item"/>
										<children>
											<list dynamic="1">
												<styles margin-bottom="0" margin-top="0"/>
												<properties start="1" type="disc"/>
												<children>
													<listrow>
														<children>
															<xpath allchildren="1"/>
														</children>
													</listrow>
												</children>
											</list>
										</children>
									</template>
								</children>
							</choiceoption>
						</children>
					</choice>
				</children>
			</paragraph>
		</children>
	</template>
	<template>
		<match match="n1:media"/>
		<children>
			<text fixtext="Media:"/>
			<text fixtext=" (mime type:">
				<styles font-size="smaller"/>
			</text>
			<template>
				<match match="@type"/>
				<children>
					<xpath allchildren="1">
						<styles color="red" font-size="smaller" font-style="italic"/>
					</xpath>
				</children>
			</template>
			<text fixtext=")(src:">
				<styles font-size="smaller"/>
			</text>
			<template>
				<match match="@src"/>
				<children>
					<text fixtext=" "/>
					<xpath allchildren="1">
						<styles color="blue" font-size="smaller" text-decoration="underline"/>
					</xpath>
					<text fixtext=" "/>
				</children>
			</template>
			<text fixtext=")">
				<styles font-size="smaller"/>
			</text>
			<newline/>
			<image>
				<properties border="0"/>
				<imagesource>
					<xpath value="@src"/>
				</imagesource>
			</image>
		</children>
	</template>
	<template>
		<match match="n1:metadata"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:name"/>
		<children>
			<text fixtext=" "/>
			<xpath allchildren="1"/>
			<text fixtext=" "/>
		</children>
	</template>
	<template>
		<match match="n1:note"/>
		<children>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<properties bgcolor="4080bf"/>
								<children>
									<tablecol>
										<children>
											<text fixtext="Note:">
												<styles color="white" font-weight="bold"/>
											</text>
											<text fixtext=" ">
												<styles color="white" font-weight="normal"/>
											</text>
											<text fixtext="(id:">
												<styles color="white" font-size="smaller" font-weight="normal"/>
											</text>
											<template>
												<styles color="white"/>
												<match match="@id"/>
												<children>
													<xpath allchildren="1">
														<styles font-size="smaller" font-weight="normal"/>
													</xpath>
												</children>
											</template>
											<text fixtext=")">
												<styles color="white" font-size="smaller" font-weight="normal"/>
											</text>
											<text fixtext=" ">
												<styles color="white"/>
											</text>
											<text fixtext="(optional type:">
												<styles color="white" font-size="smaller"/>
											</text>
											<template>
												<match match="@type"/>
												<children>
													<text fixtext=" ">
														<styles font-size="smaller"/>
													</text>
													<xpath allchildren="1">
														<styles color="white" font-size="smaller" font-style="italic"/>
													</xpath>
													<text fixtext=" ">
														<styles font-size="smaller"/>
													</text>
												</children>
											</template>
											<text fixtext=")">
												<styles color="white" font-size="smaller"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<xpath restofcontents="1"/>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:para"/>
		<children>
			<table>
				<properties border="1" border-collapse="collapse" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<text fixtext="Para">
												<styles font-size="smaller" font-weight="bold"/>
											</text>
											<text fixtext=" ">
												<styles font-size="smaller"/>
											</text>
											<text fixtext="(id:">
												<styles font-size="x-small"/>
											</text>
											<template>
												<styles text-align="justify"/>
												<match match="@id"/>
												<children>
													<text fixtext=" ">
														<styles font-size="x-small"/>
													</text>
													<xpath allchildren="1">
														<styles color="red" font-size="x-small" font-style="italic"/>
													</xpath>
													<text fixtext=" ">
														<styles font-size="x-small"/>
													</text>
												</children>
											</template>
											<text fixtext=")">
												<styles font-size="x-small"/>
											</text>
											<newline/>
											<text fixtext="optional name:">
												<styles font-size="x-small"/>
											</text>
											<template>
												<match match="n1:name"/>
												<children>
													<text fixtext=" "/>
													<xpath allchildren="1">
														<styles font-size="x-small" font-weight="bold"/>
													</xpath>
													<text fixtext=" "/>
												</children>
											</template>
											<newline/>
											<paragraph paragraphtag="p">
												<children>
													<xpath restofcontents="1"/>
												</children>
											</paragraph>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:param"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:problem"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:quote"/>
		<children>
			<table>
				<properties border="0" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties align="center"/>
										<children>
											<xpath allchildren="1">
												<styles font-style="italic"/>
											</xpath>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<properties align="right"/>
										<children>
											<text fixtext="(optional src:">
												<styles font-size="smaller"/>
											</text>
											<template>
												<match match="@src"/>
												<children>
													<xpath allchildren="1">
														<styles color="blue" font-size="smaller" text-decoration="underline"/>
													</xpath>
												</children>
											</template>
											<text fixtext=")">
												<styles font-size="smaller"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:row"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:rule"/>
		<children>
			<newline/>
			<table>
				<properties border="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<properties bgcolor="#000080"/>
								<children>
									<tablecol>
										<properties colspan="2"/>
										<children>
											<choice>
												<styles color="black"/>
												<children>
													<choiceoption>
														<testexpression>
															<xpath value="@type!=&apos;&apos;"/>
														</testexpression>
														<children>
															<template>
																<match match="@type"/>
																<children>
																	<xpath allchildren="1">
																		<styles color="white" font-weight="bold"/>
																	</xpath>
																</children>
															</template>
														</children>
													</choiceoption>
													<choiceoption>
														<children>
															<text fixtext="Rule">
																<styles color="white" font-weight="bold"/>
															</text>
														</children>
													</choiceoption>
												</children>
											</choice>
											<text fixtext=" ">
												<styles color="white"/>
											</text>
											<text fixtext="(id:">
												<styles color="white" font-size="smaller"/>
											</text>
											<template>
												<match match="@id"/>
												<children>
													<text fixtext=" ">
														<styles font-size="smaller"/>
													</text>
													<xpath allchildren="1">
														<styles color="white" font-size="smaller" font-style="italic"/>
													</xpath>
													<text fixtext=" ">
														<styles font-size="smaller"/>
													</text>
												</children>
											</template>
											<text fixtext=")">
												<styles color="white" font-size="smaller"/>
											</text>
											<text fixtext=" ">
												<styles color="white"/>
											</text>
											<text fixtext="(type:">
												<styles color="white" font-size="smaller"/>
											</text>
											<template>
												<match match="@type"/>
												<children>
													<text fixtext=" ">
														<styles font-size="smaller"/>
													</text>
													<xpath allchildren="1">
														<styles color="white" font-size="smaller"/>
													</xpath>
													<text fixtext=" ">
														<styles font-size="smaller"/>
													</text>
												</children>
											</template>
											<text fixtext=")">
												<styles color="white" font-size="smaller"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<properties bgcolor="white"/>
								<children>
									<tablecol>
										<properties width="36"/>
									</tablecol>
									<tablecol>
										<properties align="left"/>
										<children>
											<text fixtext="optional: ">
												<styles font-size="small"/>
											</text>
											<template>
												<match match="n1:name"/>
												<children>
													<text fixtext=" ">
														<styles color="white"/>
													</text>
													<xpath allchildren="1">
														<styles font-weight="bold"/>
													</xpath>
													<text fixtext=" ">
														<styles color="white"/>
													</text>
												</children>
											</template>
											<newline/>
											<text fixtext="Statement:">
												<styles font-size="small" font-weight="bold"/>
											</text>
											<template>
												<match match="n1:statement"/>
												<children>
													<text fixtext="(id:">
														<styles font-size="smaller"/>
													</text>
													<template>
														<match match="@id"/>
														<children>
															<text fixtext=" "/>
															<xpath allchildren="1">
																<styles font-size="smaller"/>
															</xpath>
															<text fixtext=" "/>
														</children>
													</template>
													<text fixtext=")">
														<styles font-size="smaller"/>
													</text>
													<xpath allchildren="1"/>
												</children>
											</template>
											<newline/>
											<text fixtext="optional: ">
												<styles font-size="smaller"/>
											</text>
											<template>
												<match match="n1:proof"/>
												<children>
													<newline/>
													<text fixtext="Proof:">
														<styles font-size="small" font-weight="bold"/>
													</text>
													<text fixtext=" (optional name:">
														<styles font-size="small"/>
													</text>
													<template>
														<match match="n1:name"/>
														<children>
															<xpath allchildren="1">
																<styles font-size="small" font-weight="bold"/>
															</xpath>
														</children>
													</template>
													<text fixtext=")"/>
													<newline/>
													<xpath restofcontents="1"/>
													<newline/>
												</children>
											</template>
											<newline/>
											<text fixtext="optional: ">
												<styles font-size="smaller"/>
											</text>
											<template>
												<match match="n1:example"/>
												<children>
													<newline/>
													<text fixtext="Example:">
														<styles font-size="small" font-weight="bold"/>
													</text>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:section"/>
		<children>
			<table>
				<styles font-size="large" font-weight="bold"/>
				<properties border="1" cellspacing="1" width="100%"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<properties bgcolor="6699cc"/>
								<children>
									<tablecol>
										<children>
											<text fixtext="Section: ">
												<styles color="white" font-family="arial" font-weight="normal"/>
											</text>
											<template>
												<editorproperties adding="mandatory" autoaddname="1" editable="1" markupmode="large"/>
												<match match="n1:name"/>
												<children>
													<xpath allchildren="1">
														<styles color="white" font-family="arial" font-weight="normal"/>
													</xpath>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<text fixtext="(id:">
												<styles font-family="arial" font-size="x-small" font-weight="normal"/>
											</text>
											<text fixtext=" ">
												<styles font-family="arial" font-size="x-small" font-weight="normal"/>
											</text>
											<template>
												<editorproperties adding="mandatory" autoaddname="1" editable="1" markupmode="hide"/>
												<match match="@id"/>
												<children>
													<text fixtext=" ">
														<styles font-size="x-small" font-weight="normal"/>
													</text>
													<xpath allchildren="1">
														<styles color="red" font-family="arial" font-size="x-small" font-style="italic" font-weight="normal"/>
													</xpath>
													<text fixtext=" ">
														<styles font-size="x-small" font-weight="normal"/>
													</text>
												</children>
											</template>
											<text fixtext=")">
												<styles font-family="arial" font-size="x-small" font-weight="normal"/>
											</text>
										</children>
									</tablecol>
								</children>
							</tablerow>
							<tablerow>
								<children>
									<tablecol>
										<children>
											<xpath restofcontents="1">
												<styles font-family="arial" font-size="x-small" font-weight="lighter"/>
											</xpath>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:seealso"/>
		<children>
			<text fixtext="See Also:">
				<styles font-weight="bold"/>
			</text>
			<template>
				<styles font-weight="bold"/>
				<match match="n1:term"/>
				<children>
					<xpath allchildren="1">
						<styles font-weight="normal"/>
					</xpath>
				</children>
			</template>
		</children>
	</template>
	<template>
		<match match="n1:solution"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:subfigure"/>
		<children>
			<newline/>
			<table>
				<properties border="1"/>
				<children>
					<tablebody>
						<children>
							<tablerow>
								<children>
									<tablecol>
										<properties align="center"/>
										<children>
											<text fixtext="Sub-Figure">
												<styles font-weight="bold"/>
											</text>
											<text fixtext=" (id:"/>
											<template>
												<match match="@id"/>
												<children>
													<xpath allchildren="1">
														<styles color="red" font-style="italic"/>
													</xpath>
													<text fixtext=" "/>
												</children>
											</template>
											<text fixtext=")"/>
											<newline/>
											<text fixtext="optional subfigure name:"/>
											<template>
												<match match="n1:name"/>
												<children>
													<xpath allchildren="1">
														<styles font-weight="bold"/>
													</xpath>
												</children>
											</template>
											<newline/>
											<xpath restofcontents="1"/>
											<newline/>
											<text fixtext="optional subfigure caption: "/>
											<template>
												<match match="n1:caption"/>
												<children>
													<xpath allchildren="1"/>
												</children>
											</template>
										</children>
									</tablecol>
								</children>
							</tablerow>
						</children>
					</tablebody>
				</children>
			</table>
		</children>
	</template>
	<template>
		<match match="n1:table"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:tbody"/>
		<children>
			<xpath allchildren="1"/>
		</children>
	</template>
	<template>
		<match match="n1:term"/>
		<children>
			<choice>
				<styles font-size="smaller" font-weight="bold" padding-left="0"/>
				<children>
					<choiceoption>
						<testexpression>
							<xpath value="parent::n1:seealso"/>
						</testexpression>
						<children>
							<text fixtext="Term:  ">
								<styles font-size="12" font-weight="bold" padding-left="0"/>
							</text>
							<xpath allchildren="1">
								<styles font-size="small" font-weight="bold" padding-left="0"/>
							</xpath>
							<text fixtext=" (optional src:">
								<styles font-size="small" font-weight="normal" padding-left="0"/>
							</text>
							<template>
								<styles font-size="12" font-weight="bold" padding-left="0"/>
								<match match="@src"/>
								<children>
									<xpath allchildren="1">
										<styles color="blue" font-weight="normal" text-decoration="underline"/>
									</xpath>
								</children>
							</template>
							<text fixtext=")"/>
						</children>
					</choiceoption>
					<choiceoption>
						<children>
							<text fixtext=" ">
								<styles font-weight="bold"/>
							</text>
							<text>
								<styles font-weight="normal"/>
							</text>
							<xpath allchildren="1">
								<styles font-size="small" font-weight="bold"/>
							</xpath>
							<text fixtext=" ">
								<styles font-weight="normal" padding-left="0"/>
							</text>
							<text>
								<styles font-weight="normal" padding-left="0"/>
							</text>
							<text fixtext="(optional src:">
								<styles font-weight="normal" padding-left="0"/>
							</text>
							<template>
								<match match="@src"/>
								<children>
									<xpath allchildren="1">
										<styles color="blue" font-weight="normal" text-decoration="underline"/>
									</xpath>
								</children>
							</template>
							<text fixtext=")">
								<styles font-weight="normal"/>
							</text>
						</children>
					</choiceoption>
				</children>
			</choice>
		</children>
	</template>
	<pagelayout>
		<properties pagemultiplepages="0" pagenumberingformat="1" pagenumberingstartat="1" paperheight="11in" papermarginbottom="0.79in" papermarginleft="0.6in" papermarginright="0.6in" papermargintop="0.79in" paperwidth="8.5in"/>
	</pagelayout>
</structure>
