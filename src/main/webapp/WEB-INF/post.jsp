<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글 작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"> 

<script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
<style>
/* 스타일 유지 */
#att_zone {
   min-height: 300px;
   padding: 10px;
}

#image_preview {
   width: 400px;
   height: 450px;
   border-radius: 10px;
   background-color:#eeeef2; 
}

#att_zone:empty:before {
   content: attr(data-placeholder);
   color: #4c4a4a;
   font-size: .9em;
}

#cke_postContent {
   width: 600px;
}

#uploadForm {
   padding-top: 50px;
}

#cke_1_top {
   background-color: inherit;
}

#cke_1_bottom {
   background-color: inherit;
   color: black;
}

#postTitle {
   height: 40px;
   width: 600px;
   border-radius: 5px;
   border: rgb(186, 186, 186) 1px solid;
   font-weight: lighter !important;
   padding: 10px;
}

#postTitle:focus {
   border: rgb(186, 186, 186) 1px solid !important;
   outline: none;
}


/* 헤더 스타일 */

#btnAtt {
   margin: 0 auto;
   display: block;
   text-align: center;
   
}

#att_zone {
   text-align: center;
   padding: 30px;
}

#uploadForm {
   display: flex;
   margin-top: 50px;
   text-align: center;
   justify-content: center;
}

.post4 {
   margin: 0 auto;
   display: block !important;
   width: 150px;
   height: 50px;
   border-radius: 5px;
   margin-top: 20px;
   outline: none;
   border: none ;
   background-color: black;
   color:white;
   cursor: pointer;
   font-size: 16px;
}

.post4:active{
   background-color: rgb(253, 78, 2);
   color: white;
}
.post4:hover{
   background-color: rgb(253, 78, 2);
}

.image_upload {
   padding-left: 20px;
}

.post {
   margin-left: 30px;
}

#postWriter {
   outline:none ;
   width:600px;
   height:40px;
   border: 1px solid rgb(186, 186, 186) ;
   font-weight: lighter !important;
   padding: 10px;
   border-radius: 5px;
}
.home {
	color: black !important;
}


.comm{
color: rgb(253, 78, 2) !important;
	font-weight: bold !important;
}
.post2{
max-width: 1590px;
height: 70vh;
margin:0 auto;

}
</style>

</head>
<body>
<div class="body">
   <div class="bodyheader">

         <%@include file="/Includes/headermenu.jsp" %>
         <%@include file="/Includes/middlemenu.jsp" %>
         
   </div>
   <div class="body">

      <div class="post2">

         <form id="uploadForm" action="postupload.do" method="post"
            enctype="multipart/form-data">

            <div class="image_upload">
               <div id='image_preview'>
                  <div id='att_zone' data-placeholder='파일을 첨부 하려면 파일선택 버튼을 클릭하세요'></div>
                  <input type='file' id='btnAtt' name='files'
                     multiple='multipart/form-data' />
               </div>
            </div>
            
            <div class="post">
               <!-- 세션에서 회원번호(mem_no) 가져오기 -->
               <c:if test="${not empty sessionScope.loginUser}">
                  <input type="hidden" name="mem_no" value="${sessionScope.loginUser.mem_no}">
               </c:if>
               
               <label for="postTitle"></label> 
               <input type="text" id="postTitle" placeholder="제목을 입력하세요.!" name="title" requirgb(253, 78, 2)><br>
               
               <label for="postContent"></label>
               <textarea id="postContent" name="content" ></textarea>
               <button type="submit" class="post4">글작성</button>
            </div>

         </form>
      </div>
   </div>
      <%@include file="/Includes/footer.jsp" %>
</div>
   <script>
        CKEDITOR.replace("postContent");
    </script>

   <script>
        (function imageView(att_zone, btn) {
            var attZone = document.getElementById(att_zone);
            var btnAtt = document.getElementById(btn);
            var sel_files = [];

            var div_style = 'display:inline-block;position:relative;'
                + 'width:150px;height:120px;margin:5px;z-index:1';
            var img_style = 'width:100%;height:100%;z-index:none';
            var chk_style = 'width:25px;height:45px;position:absolute;font-size:25px;'
                + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.1);color:rgb(253, 78, 2);border-radius: 20px; outlilne:none;border:none;';

            btnAtt.onchange = function (e) {
                var files = e.target.files;
                var fileArr = Array.prototype.slice.call(files);
                for (var f of fileArr) {
                    imageLoader(f);
                }
            };

            function imageLoader(file) {
                sel_files.push(file);
                var reader = new FileReader();
                reader.onload = function (ee) {
                    let img = document.createElement('img');
                    img.setAttribute('style', img_style);
                    img.src = ee.target.result;
                    attZone.appendChild(makeDiv(img, file));
                };

                reader.readAsDataURL(file);
            };

            function makeDiv(img, file) {
                var div = document.createElement('div');
                div.setAttribute('style', div_style);

                var btn = document.createElement('input');
                btn.setAttribute('type', 'button');
                btn.setAttribute('value', 'x');
                btn.setAttribute('delFile', file.name);
                btn.setAttribute('style', chk_style);
                btn.onclick = function (ev) {
                    var ele = ev.srcElement;
                    var delFile = ele.getAttribute('delFile');
                    for (var i = 0; i < sel_files.length; i++) {
                        if (delFile === sel_files[i].name) {
                            sel_files.splice(i, 1);
                        }
                    }

                    var dt = new DataTransfer();
                    for (var f of sel_files) {
                        dt.items.add(f);
                    }
                    btnAtt.files = dt.files;
                    var p = ele.parentNode;
                    attZone.removeChild(p);
                };

                div.appendChild(img);
                div.appendChild(btn);
                return div;
            };
        })('att_zone', 'btnAtt');
    </script>
</body>
</html>
