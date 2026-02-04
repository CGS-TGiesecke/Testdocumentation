### Sales Arguments

Change these places from "CGS Assist" to "Arc Assist" or back.
the order ist preffered

<ul>
    <li> 1.Change in index.adoc </li>
      <ul>
		<li> line 6 and 10 (title on cover) </li>
		<li> line between 12 and 15 (variablen für author (Firma), revdate (Revision date), revnumber (Revision number)</li>
		<li> line 28 and 29 application (variablen to change places of application name in files)</li>
    </ul>
	<li> 2. Change github action "asciidoc-sales-manual-to-pdf.yml"</li>
      <ul>
		<li> select on run workflow the variable to exclude some chapters 1=include or 0=exclude (default)</li>
		<li> select on run workflow the theme "ARC"  or "CGS" (default)</li>
		<li> input on run workflow the current version (used in file and for filename)</li>
	  </ul>
    </li>
</ul>




