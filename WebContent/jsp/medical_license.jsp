<%@page import="com.TrialManager.model.Users"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ taglib uri="/Voxce/WebContent/WEB-INF/tld/functions.tld" prefix="tl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>VOXCE :: New Era in Clinical Trial Optimization</title>

<script type="text/javascript" src="JQuery/ddaccordion.js"></script>
<script type="text/javascript" src="JQuery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="JQuery/ui.multiselect.js"></script>
<script type="text/javascript" src="js/trials.js"></script>
<script src="JQuery/jquery.fileupload.js"></script>
<script src="JQuery/jquery.fileupload-ui.js"></script>
<script type="text/javascript" src="js/validation.js"></script>
<script type="text/javascript" src="JQuery/cal/date/jquery.datepick.js"></script>
<script type="text/javascript">
	ddaccordion.init({
		headerclass : "expandable", //Shared CSS class name of headers group that are expandable
		contentclass : "categoryitems", //Shared CSS class name of contents group
		revealtype : "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
		mouseoverdelay : 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
		collapseprev : true, //Collapse previous content (so only one open at any time)? true/false 
		defaultexpanded : [ 7 ], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
		onemustopen : false, //Specify whether at least one header should be open always (so never all headers closed)
		animatedefault : false, //Should contents open by default be animated into view?
		persiststate : true, //persist state of opened contents within browser session?
		toggleclass : [ "", "openheader" ], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
		togglehtml : [ "prefix", "", "" ], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
		animatespeed : "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
		oninit : function(headers, expandedindices) { //custom code to run when headers have initalized
			//do nothing
		},
		onopenclose : function(header, index, state, isuseractivated) { //custom code to run whenever a header is opened or closed
			//do nothing
		}
	});
</script>
<script type="text/javascript">
	$(function() {
		$("#medical_license_date").datepick({
			dateFormat : 'yyyy-mm-dd'
		});
		$("#medical_license_start_date").datepick({
			dateFormat : 'yyyy-mm-dd'
		});
		$("#medical_license_expire_date").datepick({
			dateFormat : 'yyyy-mm-dd'
		});

	});

	$(function() {

		var initFileUpload6 = function(suffix) {

			$('#file_upload_' + suffix)
					.fileUploadUI(
							{

								maxNumberOfFiles : 1,
								namespace : 'file_upload_' + suffix,
								fileInputFilter : '#file_' + suffix,
								dropZone : $('#drop_zone_' + suffix),
								uploadTable : $('#files_' + suffix),
								downloadTable : $('#files_' + suffix),
								buildUploadRow : function(files, index) {
									$("#upload_medical").val(1);
									$("#files_" + suffix).empty();
									return $("<tr style='width:auto;' class='grey_row_view_list'><td>"
											+ files[index].name
											+ '<\/td>'
											+ '<td class="file_upload_progress"><div><\/div><\/td>'
											+ '<td class="file_upload_cancel">'
											+ '<button class="ui-state-default ui-corner-all" title="Cancel">'
											+ '<span class="ui-icon ui-icon-cancel">Cancel<\/span>'
											+ '<\/button><\/td><\/tr>');
								},
								buildDownloadRow : function(file) {
									$("#upload_medical").val(1);
									if (file.name == "Sorry File Size is larger then 9 MB") {
										//file size is very larger...
										$('#MedicalfileUploadError')
												.show()
												.html(
														"Sorry File Size is larger then 9 MB");
										$('#file_upload_' + suffix).attr(
												'disabled', false);
										$("#files_" + suffix).empty();
									} else {
										$("#MedicalfileUploadError").hide();
										return $("<tr style='width:auto;' class='grey_row_view_list'> <td>"
												+ file.name
												+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Size          "
												+ file.size
												+ " Bytes</td></tr>");
									}
								}

							});

		};
		initFileUpload6(4);

	});
</script>

<style type="text/css">
@import "JQuery/cal/date/jquery.datepick.css";
</style>

<link href="css/crumbs.css" rel="stylesheet" type="text/css" />
<link href="css/accordion.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet"
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.10/themes/ui-lightness/jquery-ui.css" />
<link href="css/jquery.fileupload-ui.css" rel="stylesheet"
	type="text/css" />
<link href="css/ui.multiselect.css" rel="stylesheet" type="text/css" />
<link href="css/common.css" rel="stylesheet" type="text/css" />
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/creategroup.css" rel="stylesheet" type="text/css" />
<link href="css/buttons.css" rel="stylesheet" type="text/css" />
<link href="css/user.css" rel="stylesheet" type="text/css" />
<link href="css/view_list.css" rel="stylesheet" type="text/css" />
<link href="css/patient.css" rel="stylesheet" type="text/css" />
<link href="css/visits.css" rel="stylesheet" type="text/css" />






</head>

<body>
	<%
		Users obj = (Users) session.getAttribute("CurrentUser");
	%>
	<input type="hidden" name="current_medical_form"
		id="current_medical_form" value="${CurrentFormMedical}" />
	<input type="hidden" name="ApprovalStatusMessage"
		id="ApprovalStatusMessage" value="${MessageCode}" />
	<input type="hidden" name="medicalstatus" id="medicalstatus"
		value="${true}" />
	<input type="hidden" name="medicalrowcount" id="medicalrowcount"
		value="0" />
	<input type="hidden" name="edit_4" id="edit_4" value="0" />





	<!-- wrapper starts here -->
	<div class="wrapper">

		<!-- logo_area starts here -->
		<div class="logo_area">
			<!-- logo placeholder here -->
			<div class="logo">
				<a href="#"><img src="images/logo.jpg" border="0" alt="logo" /></a>
			</div>
			<!-- logo placehorder ends here -->

			<!-- logoout and welcome placeholder starts here -->
			<div class="logoout_welcome_area">
				<div class="logout_btn">
					<a href="<c:url value='Logout.htm' />"><img
						src="images/logout_btn.jpg" alt="logout" border="0" /></a>
				</div>
				<div class="welcome_area">
					<div class="welcome_corner"></div>
					<span>Welcome:</span> <strong>
						<%
							out.println(obj.getLogin());
						%>
					</strong>
				</div>
			</div>
			<!-- logoout and welcome placeholder ends here -->

		</div>
		<!-- logo_area ends here -->

		<!-- menu starts here -->
		<div class="menu_bar">
			<div class="top_menu_set">
				<a href="<c:url value='ShowHomeIndex.home' />" class="current_btn"><span>Home</span></a>
				<a href="<c:url value='showUsersindex.users' />" class="top_btn"><span>User
						Management</span></a> <a href="<c:url value='showGroupsindex.groups' />"
					class="top_btn"><span>Group Management</span></a> <a
					href="<c:url value='/drugs/showDrugsIndex.drugs?FormCalled=add_drug_form' />"
					class="top_btn"><span>Library</span></a> <a
					href="<c:url value='ShowSponsorDivIndex.spondiv' />"
					class="top_btn"><span>Sponsor & Division</span></a> <a
					href="<c:url value='ShowSitesIndex.sites' />" class="top_btn"><span>Sites</span></a>
				<a href="<c:url value='ShowVisitsIndex.visits' />" class="top_btn"><span>Visits</span></a>
				<a
					href="<c:url value='ShowCRFIndex.crf?CurrentForm=add_question_form' />"
					class="top_btn"><span>Form</span></a>
			</div>
		</div>
		<!-- menu ends here -->

		<!-- content starts here -->
		<div class="body_content">
			<!-- left navigation starts here -->
			<div class="left_nav" id="MainDiv">
				<div class="left_nav_header">Trial Management</div>
				<div class="nav_body">

					<div class="arrowlistmenu">
						<h3 class="menuheader expandable">Approval Status Type</h3>
						<ul class="categoryitems">
							<c:if
								test="${tl:rightsofView(resourceList,'View Approval Status Type')==1}">
								<li><a
									href="<c:url value='ShowTrials.trial?studyid=${currentstudy.study_id}&app_type_form=1' />"
									name="hrefviewapprovalstatustypediv" id="add_drug"
									onclick="LoadTrialsForm('View_Approval_Status_Type_div')">&bull;
										View Approval Status Type</a></li>
							</c:if>
							<c:if
								test="${tl:rightsofView(resourceList,'Add Approval Status Type')==1}">
								<li><a
									href="<c:url value='ShowTrials.trial?studyid=${currentstudy.study_id}&app_type_form=2' />"
									name="hrefcreateapprovalstatustypediv" id="view_drugs"
									onclick="LoadTrialsForm('Create_Approval_Status_Type_div')">&bull;
										Create Approval Status Type</a></li>
							</c:if>
						</ul>
					</div>

					<div class="arrowlistmenu">

						<h3 class="menuheader expandable">Submission Type</h3>
						<ul class="categoryitems">
							<c:if
								test="${tl:rightsofView(resourceList,'View Submissions')==1}">
								<li><a
									href="<c:url value='ShowSubmissionType.trial?studyid=${currentstudy.study_id}&sub_type_form=1' />"
									name="hrefviewsubmissiontypediv" onclick="">&bull; View
										Submission Type</a></li>
							</c:if>
							<c:if
								test="${tl:rightsofView(resourceList,'Add Submissions')==1}">
								<li><a
									href="<c:url value='ShowSubmissionType.trial?studyid=${currentstudy.study_id}&sub_type_form=2' />"
									name="hrefcreatesubmissiontypediv" onclick="">&bull; Create
										Submission Type</a></li>
							</c:if>
						</ul>
					</div>

					<div class="arrowlistmenu">
						<h3 class="menuheader expandable">Training Type</h3>
						<ul class="categoryitems">
							<c:if
								test="${tl:rightsofView(resourceList,'View Training Type')==1}">
								<li><a
									href="<c:url value='ShowTrainingType.trial?studyid=${currentstudy.study_id}&train_type_form=1' />"
									name="hrefviewtrainingdiv" onclick="">&bull; View Training</a></li>
							</c:if>
							<c:if
								test="${tl:rightsofView(resourceList,'Add Training Type')==1}">
								<li><a
									href="<c:url value='ShowTrainingType.trial?studyid=${currentstudy.study_id}&train_type_form=2' />"
									name="hrefcreatetrainingdiv" onclick="">&bull; Create
										Training</a></li>
							</c:if>
						</ul>
					</div>

					<div class="arrowlistmenu">
						<h3 class="menuheader expandable">User CV</h3>
						<ul class="categoryitems">
							<c:if test="${tl:rightsofView(resourceList,'View User CV')==1}">
								<li><a
									href="<c:url value='ShowUserCV.trial?studyid=${currentstudy.study_id}&user_cv_form=1' />"
									name="hrefviewusercvdiv" onclick="">&bull; View User CV</a></li>
							</c:if>
							<c:if test="${tl:rightsofView(resourceList,'Create User CV')==1}">
								<li><a
									href="<c:url value='ShowUserCV.trial?studyid=${currentstudy.study_id}&user_cv_form=2' />"
									name="hrefcreateusercvdiv" onclick="">&bull; Create User CV</a></li>
							</c:if>
						</ul>
					</div>

					<div class="arrowlistmenu">
						<h3 class="menuheader expandable">User Training</h3>
						<ul class="categoryitems">
							<c:if
								test="${tl:rightsofView(resourceList,'Create User Training')==1}">
								<li><a
									href="<c:url value='ShowTrainingUser.trial?studyid=${currentstudy.study_id}&train_user_form=1' />"
									name="hrefviewtraininguserdiv" onclick="">&bull; View User
										Training</a></li>
							</c:if>
							<c:if
								test="${tl:rightsofView(resourceList,'Create User Training')==1}">
								<li><a
									href="<c:url value='ShowTrainingUser.trial?studyid=${currentstudy.study_id}&train_user_form=2' />"
									name="hrefcreatetraininguserdiv" onclick="">&bull; Create
										User Training</a></li>
							</c:if>
						</ul>
					</div>

					<div class="arrowlistmenu">
						<h3 class="menuheader expandable">Submissions</h3>
						<ul class="categoryitems">
							<c:if
								test="${tl:rightsofView(resourceList,'View Submissions')==1}">
								<li><a
									href="<c:url value='ShowSubmission.trial?studyid=${currentstudy.study_id}&submission_form=1' />"
									name="hrefviewsubmissiondiv" onclick="">&bull; View
										Submissions</a></li>
							</c:if>
							<c:if
								test="${tl:rightsofView(resourceList,'Add Submissions')==1}">
								<li><a
									href="<c:url value='ShowSubmission.trial?studyid=${currentstudy.study_id}&submission_form=2' />"
									name="hrefcreatesubmissiondiv" onclick="">&bull; Create
										Submissions</a></li>
							</c:if>
						</ul>
					</div>

					<div class="arrowlistmenu">
						<h3 class="menuheader expandable">Medical License</h3>
						<ul class="categoryitems">
							<c:if
								test="${tl:rightsofView(resourceList,'View Medical License')==1}">
								<li><a
									href="<c:url value='ShowMedicalLicense.trial?studyid=${currentstudy.study_id}&medical_form=1' />"
									name="hrefviewmedicallicensediv" onclick="">&bull; View
										Medical License</a></li>
							</c:if>
							<c:if
								test="${tl:rightsofView(resourceList,'Create Medical License')==1}">
								<li><a
									href="<c:url value='ShowMedicalLicense.trial?studyid=${currentstudy.study_id}&medical_form=2' />"
									name="hrefcreatemedicallicensediv" onclick="">&bull; Create
										Medical License</a></li>
							</c:if>
						</ul>
					</div>

					<div class="arrowlistmenu">
						<h3 class="menuheader expandable">Financial Disclosure</h3>
						<ul class="categoryitems">
							<c:if
								test="${tl:rightsofView(resourceList,'View Financial Disclosure')==1}">
								<li><a
									href="<c:url value='ShowFinancialDisc.trial?studyid=${currentstudy.study_id}&financial_disc_form=1' />"
									name="hrefviewfinancialdisclosurediv" onclick="">&bull;
										View Financial Disclosure</a></li>
							</c:if>
							<c:if
								test="${tl:rightsofView(resourceList,'Create Financial Disclosure')==1}">
								<li><a
									href="<c:url value='ShowFinancialDisc.trial?studyid=${currentstudy.study_id}&financial_disc_form=2' />"
									name="hrefcreatefinancialdisclosurediv" onclick="">&bull;
										Create Financial Disclosure</a></li>
							</c:if>
						</ul>
					</div>

					<div class="arrowlistmenu">
						<h3 class="menuheader expandable">Contracts</h3>
						<ul class="categoryitems">
							<c:if test="${tl:rightsofView(resourceList,'View Contracts')==1}">
								<li><a
									href="<c:url value='ShowContracts.trial?studyid=${currentstudy.study_id}&contract_form=1' />"
									name="hrefviewcontractdiv" onclick="">&bull; View Contract</a></li>
							</c:if>
							<c:if
								test="${tl:rightsofView(resourceList,'Create Contracts')==1}">
								<li><a
									href="<c:url value='ShowContracts.trial?studyid=${currentstudy.study_id}&contract_form=2' />"
									name="hrefcreatecontractdiv" onclick="">&bull; Create
										Contract</a></li>
							</c:if>
						</ul>
					</div>

					<!-- ==================================================================================================================== -->
				</div>
				<div class="nav_bottom"></div>
				<div class="nav_shade"></div>
			</div>
			<!-- left navigation ends here -->

			<!-- right body content starts here -->
			<div class="right_body_content" id="mainFormsDiv">
				<!--  												Start Medical License View-->
				<!--  												Start Medical License View-->


				<div class="body_inner" id="View_Medical_License_div"
					style="display: none;">
					<div class="body_inner_header">
						<!-- ************************Navigation***************************************** -->
						<div class="crumb_left"></div>
						<div class="crumb_mid">
							<div class="crumbs-user">
								<a href="<c:url value='ShowHomeIndex.home' />">Home</a>
							</div>
							<div class="crumbs-link">
								<a
									href="<c:url value='ViewStudy.study?studyid=${currentstudy.study_id}' />">${currentstudy.study_name}</a>
							</div>
							<div class="crumbs-link">
								<a
									href="<c:url value='ShowTrials.trial?studyid=${currentstudy.study_id}' />">Trial
									Management</a>
							</div>
							<div class="crumbs-link">
								<a href="#">View Medical License</a>
							</div>
						</div>
						<div class="crumb_right"></div>
						<!-- ************************Navigation******************************* -->
					</div>
					<div class="create_group_container">
						<div class="field_label_view_list">Search :</div>
						<div class="field_set">
							<input id="View_Medical_License_bar"
								name="View_Medical_License_bar" type="text" class="input_txt"
								value="Search..." /> <span class="search_btn"><a
								href="#"><img src="images/search.png" alt="search"
									title="search" border="0" /></a></span>
						</div>
						<div class="show_hide_form">

							<span id="Edit_Medical_License_Error" class="error_label_grp"
								style="display: none; width: auto;">${EMLError}</span> <span
								id="Edit_Medical_License_Success" class="chk_avail_yes"
								style="display: none; width: auto;">${EMLSuccess}</span>

							<div class="field_txt_view_list">
								<input name="visit_id1" id="visit_id1" type="text" value="0"
									class="input_txt" style="display: none" />
								<table id="View_user_Table" width="100%" border="0"
									cellspacing="1" cellpadding="0" class="table_border_view_list">
									<tr class="rights_header_view_list">
										<td width="11%" align="left" valign="middle">&nbsp;User</td>
										<td width="11%" align="left" valign="middle">&nbsp;Begining
											Date</td>
										<td width="11%" align="left" valign="middle">&nbsp;Expire
											Date</td>
										<td width="11%" align="left" valign="middle">&nbsp;Description</td>
										<td width="10%" align="center" valign="middle">Download</td>
										<td width="3%" align="center" valign="middle">Edit</td>
									</tr>
									<tbody id="fbody6">
										<c:set var="tempRowStyle" scope="page"
											value="white_row_view_list" />
										<c:forEach items="${medicallist}" var="medical"
											varStatus="status">
											<c:set var="tempRowStyle"
												value="${(status.index)%2 eq 0?'white_row_view_list':'grey_row_view_list'}" />
											<tr class="${tempRowStyle}" id="${medical.medical_lic_id}">
												<td valign="top" align="left" class="set_padding"><c:forEach
														items="${userslist}" var="users" varStatus="status">
														<c:if test="${medical.user_id == users.user_id}">
	           							${users.first_name} ${users.middle_name} ${users.last_name}
	           					</c:if>
													</c:forEach></td>
												<td valign="top" align="left" class="set_padding">${medical.begin_dt}</td>
												<td valign="top" align="left" class="set_padding">${medical.expire_dt}</td>
												<td valign="top" align="left" class="set_padding">${medical.description}</td>
												<td valign="top" align="center" class="set_padding2"><a
													href="<c:url value='DownloadDocumentMedical.trial?docid=${medical.medical_lic_id}'/>"><img
														src="images/download.png" alt="Doc" title="Doc" border="0" /></a></td>
												<td valign="top" align="center" class="set_padding2"><img
													onclick="edit_medical_license_row('${medical.medical_lic_id}','${medical.user_id}','${medical.site_id}','${medical.study_id}','${medical.begin_dt}','${medical.start_dt}','${medical.expire_dt}','${medical.description}','${medical.type_id}','${medical.created_by}','${medical.date_created}','${medical.protocol_id}','${medical.protocol_version}','${medical.filename}','${medical.file_description}')"
													src="images/edit_row_icon.png" alt="Edit" title="Edit"
													border="0" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div id="Edit_User_error_message" class="chk_avail_yes"></div>
				</div>
				<!--  												EndMedical License View-->
				<!--  												End Medical License View-->

				<!-- 												Start Create Medical License-->
				<!-- 												Start Create Medical License-->
				<div class="body_inner" id="Create_Medical_License_div"
					style="display: none;">
					<div class="body_inner_header">
						<!-- ************************Navigation***************************************** -->
						<div class="crumb_left"></div>
						<div class="crumb_mid">
							<div class="crumbs-user">
								<a href="<c:url value='ShowHomeIndex.home' />">Home</a>
							</div>
							<div class="crumbs-link">
								<a
									href="<c:url value='ViewStudy.study?studyid=${currentstudy.study_id}' />">${currentstudy.study_name}</a>
							</div>
							<div class="crumbs-link">
								<a
									href="<c:url value='ShowTrials.trial?studyid=${currentstudy.study_id}' />">Trial
									Management</a>
							</div>
							<div class="crumbs-link">
								<a href="#" id="create_medical_license_title">Medical
									License</a>
							</div>
						</div>
						<div class="crumb_right"></div>
						<!-- ************************Navigation******************************* -->
					</div>
					<div class="create_group_container">
						<div id="" class="myform visit">
							<form id="file_upload_4" name="file_upload_4"
								enctype="multipart/form-data" method="post"
								action="UploadMedicalLicense.trial" class="visit">
								<span id="Create_Medical_License_Error" class="error_label_grp"
									style="display: none;"></span> <span
									id="Create_Medical_License_Success" class="chk_avail_yes"
									style="display: none;"></span> <label>Choose a File to
									upload</label> <input type="file" name="file_4" id="file_4" value=""
									style="width: 400px; margin-left: 20px;" class="input_txt" /><span
									id="MedicalfileUploadError" class="error_label"></span>
								<div style="float: left; clear: both;">
									<table id="files_4" style="width: 596px;" border="0"
										cellspacing="1" cellpadding="0" class="table_border_view_list"></table>
								</div>
							</form>
							<form id="medical_license_form" name="medical_license_form"
								method="post" action="CreateMedicalLicense.trial" class="visit">
								<input name="medical_license_edit_id"
									id="medical_license_edit_id" type="text" value="0"
									class="input_txt" style="display: none" /> <input
									name="medical_license_date_created"
									id="medical_license_date_created" type="text" value="0"
									class="input_txt" style="display: none" /> <input
									name="medical_license_created_by"
									id="medical_license_created_by" type="text" value="0"
									class="input_txt" style="display: none" /> <input
									name="upload_medical" id="upload_medical" type="text" value="0"
									class="input_txt" style="display: none" /> <label>File
									Description :</label>
								<textarea id="medical_license_file_description"
									name="medical_license_file_description" cols="" rows=""
									onkeyup="if (this.value.length > 250)this.value = this.value.substring(0, 250)">
</textarea>
								<span id="medical_license_file_description_error"
									class="error_label_grp"></span> <label>Protocol :</label> <select
									name="medical_protocol" id="medical_protocol" class="drop_txt">
									<c:forEach items="${versionlist}" var="versions"
										varStatus="status">
										<option id="${versions.protocol_version_id}"
											value="${versions.protocol_id}-${versions.version}"
											onclick="">${versions.protocol_id} -
											${versions.version}</option>
									</c:forEach>
								</select> <span id="medical_protocol_error" class="error_label"></span> <label>Site
									:</label> <select name="medical_license_site" id="medical_license_site"
									class="drop_txt">
									<c:forEach items="${siteslist}" var="site" varStatus="status">
										<option id="${site.site_id}" value="${site.site_id}"
											onclick="">${site.site_name}</option>
									</c:forEach>
								</select> <span id="medical_license_site_error" class="error_label_grp"></span>
								<label>User :</label> <select name="medical_license_user"
									id="medical_license_user" class="drop_txt">
									<c:forEach items="${userslist}" var="users" varStatus="status">
										<option id="${users.user_id}" value="${users.user_id}"
											onclick="">${users.first_name} ${users.middle_name}
											${users.last_name}</option>
									</c:forEach>
								</select> <span id="medical_license_user_error" class="error_label_grp"></span>
								<label>Begining Date :</label> <input readonly="readonly"
									id="medical_license_date" name="medical_license_date"
									type="text" value="" class="input_txt" style="width: 100px;" /><img
									src="images/calender.png" alt="" border="0"
									style="float: left; margin: 0;" /><span
									id="medical_license_date_error" class="error_label"></span> <label>Start
									Date :</label> <input readonly="readonly"
									id="medical_license_start_date"
									name="medical_license_start_date" type="text" value=""
									class="input_txt" style="width: 100px;" /><img
									src="images/calender.png" alt="" border="0"
									style="float: left; margin: 0;" /><span
									id="medical_license_start_date_error" class="error_label"></span>

								<label>Expire Date :</label> <input readonly="readonly"
									id="medical_license_expire_date"
									name="medical_license_expire_date" type="text" value=""
									class="input_txt" style="width: 100px;" /><img
									src="images/calender.png" alt="" border="0"
									style="float: left; margin: 0;" /><span
									id="medical_license_expire_date_error" class="error_label"></span>

								<label>Approval Type :</label> <select
									name="medical_license_type_id" id="medical_license_type_id"
									class="drop_txt">
									<c:forEach items="${approvalstatustypelist}" var="approval"
										varStatus="status">
										<option id="${approval.approval_status_type_id}"
											value="${approval.approval_status_type_id}" onclick="">${approval.name}</option>
									</c:forEach>
								</select> <span id="medical_license_type_id_error"
									class="error_label_grp"></span> <label>Description :</label>
								<textarea id="medical_license_description"
									name="medical_license_description" cols="" rows=""
									onkeyup="if (this.value.length > 1000)this.value = this.value.substring(0, 1000)">
</textarea>
								<span id="medical_license_description_error"
									class="error_label_grp"></span>
								<div class="spacer"></div>
								<div style="clear: both; margin-top: 10px; padding-left: 170px;">
									<button class="blue-pill" type="submit">Save</button>
									<button class="grey-pill" type="reset"
										onclick="LoadTrialsForm('View_Medical_License_div')">Cancel</button>
								</div>
							</form>
						</div>
					</div>

				</div>

				<!--  												End Create Medical License-->
				<!--  												End Create Medical License-->

			</div>
			<!-- right body content ends here -->

		</div>
		<!-- content ends here -->

		<!-- footer starts here -->
		<%@include file="footer.jsp"%>
		<!-- footer ends here -->

	</div>
	<!-- wrapper ends here -->
</body>
</html>
