	
		<link href="<@spring.url '/resources/theme/vendor/plugins/magnific/magnific-popup.css' />" rel="stylesheet" type="text/css" >
        <script src="<@spring.url '/resources/theme/vendor/plugins/magnific/jquery.magnific-popup.js' />"></script>
        <script type="text/javascript" src="<@spring.url '/resources/scripts/ajaxfileupload.js' />"></script>
        
        <!-- Admin Form Popup --> 
        <div id="modal-form" class="popup-basic admin-form mfp-with-anim mfp-hide">
            <div class="panel">
                <div class="panel-heading" style="padding:0px;padding-left:10px;">
                    <span class="panel-title"><i class="fa fa-upload"></i>앱실행 파일 업로드</span>
                </div>
                <form name="uploadform" method="post" enctype="multipart/form-data" class="form-horizontal admin-form" role="form">
                <div class="panel-body p25">
                    <div class="section row">
                        <div class="col-xs-12">
                            <label class="field prepend-icon file">
                                <span class="button">파일 선택</span>
                                <input type="file" class="gui-file" name="uploadfile" id="uploadfile" onChange="document.getElementById('uploadfile_t').value = this.value;">
                                <input type="text" class="gui-input" id="uploadfile_t" placeholder="업로드 할 파일을 선택하세요">
                                <label class="field-icon"><i class="fa fa-upload"></i></label>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="panel-footer text-center">
                    <a href="javascript:ajaxFileUpload()" class="button btn-primary">업로드</a>
                </div>
                </form>
            </div>
        </div>
        <script type="text/javascript">
        function FileUploadComplete( data )
        {   
            //doument.location.reload();
            alert( data );
        }   
        function ajaxFileUpload()
        {   
            $.ajaxFileUpload({ 
                url : '<@spring.url '/api/appfileupload' />',
                fileElementId : 'uploadfile',
                dataType : 'json',
                xhrFields: {withCredentials: true },
                success: function (data, status)
                {
                	alert( 'success:'+data );
                    if(typeof(data.error) != 'undefined')
                    {
                        if(data.error != '') { alert(data.error); return; }
                        else {
                            $.magnificPopup.close();
                            FileUploadComplete( data );
                            $("#uploadfile_t").val("");
                        }
                    }
                },
                error: function (data, status, e){ alert('error:'+e); }
            });
        }
        function openFileForm()
        {
            $.magnificPopup.open({
                removalDelay: 500,
                items: { src: '#modal-form' },
                callbacks: { beforeOpen: function(e) { var Animation = 'mfp-sign'; this.st.mainClass = Animation; } },
                midClick: true
            });
        }
        </script>
        