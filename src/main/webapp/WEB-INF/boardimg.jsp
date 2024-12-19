<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='contextPath' value='${pageContext.request.contextPath}'></c:set>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Image Upload and Preview</title>
    <style>
        #att_zone {
            width:200px;
            min-height: 200px;
            padding: 10px;
            background-color: #f5f5f5;
            border-radius: 20px;
        }

        #att_zone:empty:before {
            content: attr(data-placeholder);
            color: #4c4a4a;
            font-size: .9em;
        }
    </style>
</head>
<body>
    <div id='image_preview'>
        <h3>이미지 업로드</h3>
        <form id="uploadForm" action="boardimgupload.do" method="post" enctype="multipart/form-data">
            <input type='file' id='btnAtt' name='files' multiple='multiple' />
            <div id='att_zone'
                data-placeholder='파일을 첨부 하려면 업로드 버튼을 클릭하세요'></div>
            <button type="submit">업로드</button>
        </form>
    </div>

    <script>
        (function imageView(att_zone, btn) {
            var attZone = document.getElementById(att_zone);
            var btnAtt = document.getElementById(btn);
            var sel_files = [];

            // 이미지와 체크 박스를 감싸고 있는 div 속성
            var div_style = 'display:inline-block;position:relative;'
                + 'width:150px;height:120px;margin:5px;z-index:1';
            // 미리보기 이미지 속성
            var img_style = 'width:100%;height:100%;z-index:none';
            // 이미지안에 표시되는 체크박스의 속성
            var chk_style = 'width:25px;height:25px;position:absolute;font-size:18px;'
                + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.1);color:black;border-radius: 20px;';

            btnAtt.onchange = function (e) {
                var files = e.target.files;
                var fileArr = Array.prototype.slice.call(files);
                for (var f of fileArr) {
                    imageLoader(f);
                }
            };

            /*첨부된 이미지들을 배열에 넣고 미리보기 */
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

            /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
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
