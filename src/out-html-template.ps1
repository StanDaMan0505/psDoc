@"
<!DOCTYPE html>
<!--
<auto-generated>
  <synopsis>
    This code was generated by a fool on: $(Get-Date)
  </synopsis>
  <description>
    If you'd like to regenerate the documentation, please open up powershell and run
            
        > .\psDoc.ps1 -moduleName NameOfYourModule
                
    If the documentation is incomplete, or eronious, 
    please edit the comments at the top of the module method within it's respecive .ps1 file.        
  </description>
</auto-generated>
-->
<html lang="en">
	<head>
		<title>$moduleName Documentation</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		
		<link href="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/styles/shCore.min.css" rel="stylesheet" charset="utf-8">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/styles/shCoreDefault.min.css" rel="stylesheet" charset="utf-8">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet" charset="utf-8">
				
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style>
		  .syntaxhighlighter {
		      overflow-y: hidden !important;
		      overflow-x: auto !important;
		  }
		  pre {
		      min-height: 30px;
		  }
		  .navbar-nav {
		      height: 100%;
		      overflow-y: auto;
		  }
		  .form-group {
		      padding-top: 12px;
		      padding-left: 12px;
		      padding-right: 12px;
		  }
		  .sidebar-nav .navbar-header {
		      float: none;
		  }
	      .sidebar-nav .navbar li a {
	          padding-top: 4px;
	          padding-bottom: 4px;
	      }
		  @media (min-width: 768px) {
		      .sidebar-nav .navbar .navbar-collapse {
		          padding: 0;
		          max-height: none;
		      }
		      .sidebar-nav .navbar ul {
		          float: none;
		      }
		      .sidebar-nav .navbar ul:not {
		          display: block;
		      }
		      .sidebar-nav .navbar li {
		          float: none;
		          display: block;
		      }
		  }
		</style>

	</head>
	<body>
    <div class="container-fluid">
		<div class="row-fluid">
        	<div><h1>$moduleName</h1></div>
        </div>    
		<div class="row-fluid">
          <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
            <div class="sidebar-nav">
              <div class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-navbar-collapse">
                    <span class="sr-only">Toggle</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                  </button>
                  <span class="visible-xs navbar-brand">click menu to open</span>
                </div>
                <div class="navbar-collapse collapse sidebar-navbar-collapse">

			      <div class="form-group">
					<input class="form-control" id="searchinput" type="search" placeholder="Funktionsname eingeben..." />
				  </div>

                  <ul class="nav navbar-nav list-group" id="searchList">
"@
$progress = 0
$commandsHelp | ForEach-ObjectorEach-Object  {
	Update-Progress $_.Name 'Navigation'
	$progress++
"					<li class=`"nav-menu list-group-item`"><a href=`"#$($_.Name)`">$($_.Name)</a></li>"
}
@'
                  </ul>
                </div><!--/.nav-collapse -->
              </div>
            </div>
          </div>
          <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12">
'@
$progress = 0
$commandsHelp | ForEach-Object {
	Update-Progress $_.Name 'Documentation'
	$progress++
@"
				<div id=`"$(FixString($_.Name))`" class="toggle_container">
					<div class="page-header">
						<h2> $(FixString($_.Name)) </h2>
"@
	$syn = FixString($_.synopsis)
    if(!($syn).StartsWith($(FixString($_.Name)))){
@"
						<p>$syn</p>
						<p>$(FixString(($_.Description  | out-string).Trim()) $true)</p>
"@
	}
@"
					</div>
"@
	if (!($_.alias.Length -eq 0)) {
@"
                        <div class='panel panel-default'>
                            <div class='panel-heading'>
                                <h3 class='panel-title'> $($_.Name) Aliases </h3>
                            </div>
                            <div class='panel-body'>
                                <ul>
"@
    $_.alias | ForEach-Object {
@"
                                    <li>$($_.Name)</li>
"@
    }
@"
                                </ul>
                            </div>
                        </div>
"@
	}
	if (!($_.syntax | Out-String ).Trim().Contains('syntaxItem')) {
@"
                        <div>
                        <h3> Syntax </h3>
                        </div>
						<div class="panel panel-default">
                            <div class='panel-body'>
<pre class="brush: ps">$(FixString($_.syntax | out-string))</pre>
                            </div>
						</div>
"@
	}
    if($_.parameters){
@"
						<div>
							<h3> Parameters </h3>
							<table class="table table-striped table-bordered table-condensed visible-on">
								<thead>
									<tr>
										<th>Name</th>
                                        <th class="visible-lg visible-md">Alias</th>
										<th>Description</th>
										<th class="visible-lg visible-md">Required?</th>
										<th class="visible-lg">Pipeline Input</th>
										<th class="visible-lg">Default Value</th>
									</tr>
								</thead>
								<tbody>
"@
        $_.parameters.parameter | ForEach-Object {
@"
									<tr>
										<td><nobr>-$(FixString($_.Name))</nobr></td>
                                        <td class="visible-lg visible-md">$(FixString($_.Aliases))</td>
										<td>$(FixString(($_.Description  | out-string).Trim()) $true)</td>
										<td class="visible-lg visible-md">$(FixString($_.Required))</td>
										<td class="visible-lg">$(FixString($_.PipelineInput))</td>
										<td class="visible-lg">$(FixString($_.DefaultValue))</td>
									</tr>
"@
        }
@"
								</tbody>
							</table>
						</div>				
"@
    }
    $inputTypes = $(FixString($_.inputTypes  | out-string))
    if ($inputTypes.Length -gt 0 -and -not $inputTypes.Contains('inputType')) {
@"
						<div>
					        <h3> Inputs </h3>
                            <p>The input type is the type of the objects that you can pipe to the cmdlet.</p>
                            <ul><li>$inputTypes</li></ul>
					    </div>
"@
	}
    $returnValues = $(FixString($_.returnValues  | out-string))
    if ($returnValues.Length -gt 0 -and -not $returnValues.StartsWith("returnValue")) {
@"
						<div>
							<h3> Outputs </h3>
                            <p>The output type is the type of the objects that the cmdlet emits.</p>
							<ul><li>$returnValues</li></ul>
						</div>
"@
	}
    $notes = $(FixString($_.alertSet  | out-string))
    if ($notes.Trim().Length -gt 0) {
@"
						<div class='panel panel-default'>
                            <div class='panel-heading'>
                                <h3 class='panel-title'> Note </h3>
                            </div>
							<div class='panel-body'>$notes</div>
						</div>
"@
	}
	if(($_.examples | Out-String).Trim().Length -gt 0) {
@"
                        <div>
                            <h3> Examples </h3>
                        </div>
						<div class='panel panel-default'>
                            <div class='panel-body'>
"@
		$_.examples.example | ForEach-Object {
@"
							    <strong>$(FixString($_.title.Trim(('-',' '))))</strong>
<pre class="brush: ps">$(FixString($_.code | out-string ).Trim())</pre>
							    <div>$(FixString($_.remarks | out-string ).Trim())</div>
"@
		}
@"
                            </div>
						</div>
                        <p class='pull-right'><a onclick='document.body.scrollTop = document.documentElement.scrollTop = 0;' style='cursor: pointer;'>Top of page</a>
"@
	}
	if(($_.relatedLinks | Out-String).Trim().Length -gt 0) {
@"
						<div>
							<h3> Links </h3>
                            <div>
                                <ul>
"@
		$_.links | ForEach-Object { 
@"
							        <li class='$($_.cssClass)'><a href='$($_.link)' target='$($_.target)'>$($_.name)</a></li>
"@
		}
@"
                                </ul>
                            </div>
						</div>
"@
	}
@"
				</div>
"@
}
@'
		</div>
	</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/js/bootstrap.min.js" charset="utf-8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shCore.min.js" charset="utf-8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SyntaxHighlighter/3.0.83/scripts/shBrushPowerShell.min.js" charset="utf-8"></script>
	<script>
		$(document).ready(function() {
			$(".toggle_container").hide();
			var previousId;
		    if(location.hash) {
		        var id = location.hash.slice(1);    //Get rid of the # mark
		        var elementToShow = $("#" + id);    //Save local reference
		        if(elementToShow.length) {                   //Check if the element exists
		            elementToShow.slideToggle('fast');       //Show the element
		            elementToShow.addClass("check_list_selected");    //Add class to element (the link)
		        }
		        previousId = id;
		    }

			$('.nav-menu a, .psLink a').click(function() {
                $(".sidebar-navbar-collapse").collapse('hide');
				$('.toggle_container').hide();                 // Hide all
				var elem = $(this).prop("hash");
				$(elem).toggle('fast');   						// Show HREF/to/ID one
				history.pushState({}, '', $(this).attr("href"));
				window.scrollTo(0, 0);
				return false;
			});
			SyntaxHighlighter.defaults['toolbar'] = false;
			SyntaxHighlighter.defaults['gutter'] = false;
			SyntaxHighlighter.all();
			
			$('#searchList').btsListFilter('#searchinput', {itemChild: 'a', initial: false, resetOnBlur: true});
            
            $(document).keyup(function( e ) {
                if(!$('#searchinput').is(':focus') && e.which >= 65 && e.which <= 90 ){
                   $('#searchinput').val(String.fromCharCode(e.keyCode));
                   $('#searchinput').focus();
                }
            });
            $(document).click(function() {
                $('#searchinput').blur();
            });
		});
	</script>
    <!-- bootstrap-list-filter.min.js - removed as external resource and added as content -->
    <script>
    /* 
     * bootstrap-list-filter v0.1.7 - 2015-03-30 
     * 
     * Copyright 2015 Stefano Cudini 
     * stefano.cudini@gmail.com 
     * http://labs.easyblog.it/ 
     * 
     * Licensed under the MIT license. 
     * 
     * Demos: 
     * http://labs.easyblog.it/bootstrap-list-filter/ 
     * 
     * Source: 
     * git@github.com:stefanocudini/bootstrap-list-filter.git 
     * 
     */
    !function(a){a.fn.btsListFilter=function(b,c){function d(a,b){return a.replace(/\{ *([\w_]+) *\}/g,function(a,c){return b[c]||""})}function e(a,b){var c;return b=b||300,function(){var d=this,e=arguments;clearTimeout(c),c=setTimeout(function(){a.apply(d,Array.prototype.slice.call(e))},b)}}var f,g=this,h=a(this),i=a(b),j=h;return c=a.extend({delay:300,minLength:1,initial:!0,eventKey:"keyup",resetOnBlur:!0,sourceData:null,sourceTmpl:'<a class="list-group-item" href="#"><span>{title}</span></a>',sourceNode:function(a){return d(c.sourceTmpl,a)},emptyNode:function(){return'<a class="list-group-item well" href="#"><span>No Results</span></a>'},itemEl:".list-group-item",itemChild:null,itemFilter:function(b,d){d=d&&d.replace(new RegExp("[({[^.$*+?\\]})]","g"),"");var e=a(b).text(),f=c.initial?"^":"",g=new RegExp(f+d,"i");return g.test(e)}},c),i.on(c.eventKey,e(function(){var b=a(this).val();c.itemEl&&(j=h.find(c.itemEl)),c.itemChild&&(j=j.find(c.itemChild));var d=j.filter(function(){return c.itemFilter.call(g,this,b)}),e=j.not(d);c.itemChild&&(d=d.parents(c.itemEl),e=e.parents(c.itemEl).hide()),""!==b&&b.length>=c.minLength?(d.show(),e.hide(),"function"===a.type(c.sourceData)?(d.hide(),e.hide(),f&&(a.isFunction(f.abort)?f.abort():a.isFunction(f.stop)&&f.stop()),f=c.sourceData.call(g,b,function(b){if(f=null,d.hide(),e.hide(),h.find(".bts-dynamic-item").remove(),b&&0!==b.length)for(var i in b)a(c.sourceNode.call(g,b[i])).addClass("bts-dynamic-item").appendTo(h);else a(c.emptyNode.call(g)).addClass("bts-dynamic-item").appendTo(h)})):0===d.length&&a(c.emptyNode.call(g)).addClass("bts-dynamic-item").appendTo(h)):(d.show(),e.show(),h.find(".bts-dynamic-item").remove())},c.delay)),c.resetOnBlur&&i.on("blur",function(){a(this).val("").trigger(c.eventKey)}),h}}(jQuery);
</script>
	</body>
</html>
'@
