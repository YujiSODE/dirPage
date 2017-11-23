#dirPage
#dirPage.tcl
##===================================================================
#	Copyright (c) 2017 Yuji SODE <yuji.sode@gmail.com>
#
#	This software is released under the MIT License.
#	See LICENSE or http://opensource.org/licenses/mit-license.php
##===================================================================
#It generates a HTML file using contents in the current directory.
#=== Synopsis ===
#** Shell **
#tclsh dirPage.tcl ?css? ?ex0? ?ex ex ...?;
# - $css: an optional css file; e.g., dirPage_css.css
# - $ex0: an optional file extension to be displayed with code element
# - $ex: additional file extensions
#--------------------------------------------------------------------
#** Tcl **
#::dirPage::run ?css? ?exList?;
# - $css: an optional css file; e.g., dirPage_css.css
# - $exList: an optional list of file extensions to be displayed with code element
##===================================================================
set auto_noexec 1;
package require Tcl 8.6;
#=== namespace: dirPage ===
namespace eval ::dirPage {
	#list of filename extensions for available image file
	variable imgEx {jpeg jpg gif png bmp};
	#html code
	variable html0 {<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><meta name="generator" content="dirPage">};
	#main script
	proc run {{css {}} {exList {}}} {
		# - $css: an optional css file; e.g., dirPage_css.css 
		# - $exList: an optional list of file extensions to be displayed with code element
		variable html0;
		variable imgEx;
		set timestamp [clock format [clock seconds] -gmt 1];
		set dirName [file tail [pwd]];
		#+++ to append css data if it is available +++
		if {[llength $css]} {
			set F [read -nonewline [set c [open $css r]]];
			close $c;
			append html0 "\n<style type=\"text/css\">\n$F\n</style>";
			unset F c;
		};
		append html0 "<title>$dirName</title></head><body>\n<h1>$dirName</h1>\n";
		#+++ to append text file data +++
		foreach e [lsort -dictionary [glob -nocomplain *.txt]] {
			set F [read -nonewline [set c [open $e r]]];
			close $c;
			append html0 "<article><h1>$e</h1><p>[string map {\n <br>} $F]</p></article>\n";
			unset F c;
		};
		#+++ to append image file link +++
		if {[llength $imgEx]} {
			foreach x $imgEx {
				foreach img [lsort -dictionary [glob -nocomplain *.$x]] {
					append html0 "<figure><img src=\"$img\" alt=\"$img\"><figcaption>$img</figcaption></figure>\n";
				};
			};
		};
		#+++ to append additional code element +++
		if {[llength $exList]} {
			foreach e $exList {
				foreach code [lsort -dictionary [glob -nocomplain *.$e]] {
					set F [read -nonewline [set c [open $code r]]];
					close $c;
					append html0 "<article><h1>$code</h1><pre><code>[string map {< &lt\; > &gt\; & &amp\; | &#124\;} $F]</code></pre></article>\n";
					unset F c;
				};
			};
		};
		#footer
		append html0 "<footer>$timestamp</footer></body></html>";
		#output as html file
		puts -nonewline [set c [open "${dirName}_page.html" w]] $html0;
		close $c;
		unset c;
		#reset html code
		set html0 {<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><meta name="generator" content="dirPage">};
		return "dirPage: $timestamp";
	};
};
#Shell
if {[regexp {^(?:.+\/)?dirPage.tcl} $argv0]} {
	::dirPage::run [lindex $argv 0] [lrange $argv 1 end];
};
