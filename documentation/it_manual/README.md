### IT Handbook

Change these places from "CGS Assist" to "Arc Assist" or back

<ul>
    <li> Change in index.adoc </li>
      <ul>
		<li> line 6 and 10 (title on cover) </li>
		<li> line between 12 and 15 (variablen für author (Firma), revdate (Revision date), revnumber (Revision number)</li>
		<li> line 28 and 29 application (variablen to change places of application name in files)</li>
    </ul>
	<li> change github action "asciidoc-it-handbook-de.yml"</li>
      <ul>
		<li> line 24 change env:  REVISION: to current version (used in file and for filename)</li>
		  <li> line 25 change env:  BIG_OUTPUT: only-for-concret-customer (variable to exclude some chapters 0=exclude, 1=include)</li>
		<li> line 51 change theme "pdf-theme=ARC"  to "pdf-theme=CGS" </li>
	  </ul>
    </li>
</ul>





