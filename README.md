# dirPage
It generates a HTML file using contents in the current directory.  
GitHub: https://github.com/YujiSODE/dirPage  
>Copyright (c) 2017 Yuji SODE \<yuji.sode@gmail.com\>  
>This software is released under the MIT License.  
>See LICENSE or http://opensource.org/licenses/mit-license.php
______
## 1. Synopsis
**Shell**  
`tclsh dirPage.tcl ?css? ?ex0? ?ex ex ...?;`
- `$css`: an optional css file; e.g., `dirPage_css.css`
- `$ex0`: an optional file extension to be displayed with code element
- `$ex`: additional file extensions

**Tcl**  
`::dirPage::run ?css? ?exList?;`
- `$css`: an optional css file; e.g., `dirPage_css.css`
- `$exList`: an optional list of file extensions to be displayed with code element

## 2. Script
It requires Tcl/Tk 8.6+.
- `dirPage.tcl`
- `dirPage_css.css`: an optional css file
