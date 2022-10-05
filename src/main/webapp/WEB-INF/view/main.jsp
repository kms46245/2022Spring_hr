<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>

<head>
<title></title>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js'></script>
<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>
<link rel='stylesheet' href='http://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'/>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.6.3/css/all.css'/>
<script>

function isVal(field) {
    let isGood = false
    let errMsg

    if(!field.length) errMsg = ' 노동자를 선택하세요.'
    else {
        if(!field.val()) errMsg = field.attr('placeholder') + ' 을(를) 입력하세요.'
        else isGood = true        
    }

    if(!isGood) {
        $('#modalMsg').text(errMsg).css('color', 'red')
        $('#modalBtn').hide()
        $('#modal').modal()
    }

    return isGood
}

function listLaborers() {
    $('input').not(':radio').val('')
    $('#laborers').empty()

    $.ajax({
    	url: 'laborer/list',
    	success: laborerList => {  		
    		if(laborerList.length) {
    			const laborers = []
    		    laborerList.forEach(laborer => {
    				laborers.unshift(`<tr><td><input type='radio' name='laborerId' id='laborerId'
    						                   value='\${laborer.laborerId}'/></td>
    									<td>\${laborer.laborerId}</td>
    									<td>\${laborer.name}</td>
    									<td>\${laborer.hireDate}</td></tr>`)
    				})    		           		       
    		       $('#laborers').append(laborers.join(''))
    		}
    		else $('#laborers').append(
    			'<tr><td colspan=4 class=text-center>노동자가 없습니다.</td></tr>')
    		    
    	}
    })
}

function init() {
	// 노동자 목록
	listLaborers()
	
    // 노동자 추가
    $('#addLaborerBtn').click(() => {
        if(isVal($('#laborerName')) && isVal($('#hireDate'))) {
        	let laborer = {
                    name: $('#laborerName').val(),
                    hireDate: $('#hireDate').val()
            }
        	
        	
            $.ajax({
            	url: 'laborer/add',
    			method: 'post',
    			contentType: 'application/json',
    			data: JSON.stringify({
    				name: $('#laborerName').val(),
    				hireDate: $('#hireDate').val()
    			}),
    			success: listLaborers
            })
        }
    })

    // 노동자 수정

    $('#fixLaborerBtn').click(() => {
        if(isVal($('#laborerId:checked')) &&
            isVal($('#laborerName')) && isVal($('#hireDate'))) {
            let laborer = {
	            laborerId: $('#laborerId:checked').val(),
	            name: $('#laborerName').val(),
	            hireDate: $('#hireDate').val()
	        }
            
            $.ajax({
            	url: 'laborer/fix',
            	method: 'put',
    			contentType: 'application/json',
            	data: JSON.stringify({
    				laborerId: $('#laborerId:checked').val(),
    				name: $('#laborerName').val(),
    				hireDate: $('#hireDate').val()
    				}),
            	success: listLaborers
            })
        }
    })

    // 노동자 삭제
    $('#delLaborerBtn').click(() => {
        if(isVal($('#laborerId:checked'))){
            $('#modalMsg').text('노동자를 삭제하시겠습니까?')
            $('#modalBtn').show()
            $('#modal').modal()
        }
    })

    $('#delLaborerOkBtn').click(() => {
        $.ajax({
        	url: 'laborer/del/' + $('#laborerId:checked').val(),
			method: 'delete',
        	success: listLaborers
        })
        
        $('#modal').modal('hide')
    })

    $('#laborers').on({
        change() {
            $('#laborerName').val($(this).parent().siblings().eq(1).text())
            $('#hireDate').val($(this).parent().siblings().eq(2).text())
        }
    }, '#laborerId')
}

$(init)
</script>
<style>
#hireDate::before {
    content: attr(placeholder);
    width: 100%;
}

#hireDate:focus::before, #hireDate:valid::before{
    display: none;
}
</style>

</head>

<body>
<div class='container'>
    <div class='row'>
        <div class='col'>
            <header class='jumbotron p-2'>
                <h1 class='text-center'>HR</h1>
            </header>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <form>
                <div class='row mb-3'>
                    <div class='col-2'>
                        <input type='text' class='form-control' placeholder='노동자명' id='laborerName'/>
                    </div>
                    <div class='col-4'>
                        <input type='date' class='form-control' placeholder='입사일' id='hireDate' required/>
                    </div>
                    <div class='col'>
                        <nav class='d-flex'>
                            <button type='button' class='btn btn-success flex-fill mr-1' id='addLaborerBtn'>
                                <i class='fas fa-plus'></i><span class='label d-none d-sm-inline'>추가</span>
                            </button>
                            <button type='button' class='btn btn-info flex-fill mr-1' id='fixLaborerBtn'>
                                <i class='fas fa-edit'></i><span class='label d-none d-sm-inline'>수정</span>
                            </button>
                            <button type='button' class='btn btn-warning flex-fill' id='delLaborerBtn'>
                                <i class='fas fa-trash-alt'></i><span class='label d-none d-sm-inline'>삭제</span>
                            </button>
                        </nav>
                    </div>
                </div>
                <div class='row'>
                    <div class='col'>
                        <table class='table'>
                            <thead><tr><th></th><th>ID</th><th>이름</th><th>입사일</th></tr></thead>
                            <tbody id='laborers'>
                                  
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class='modal fade' tabindex='-1' id='modal'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='close' data-dismiss='modal'>
                    <span>&times;</span>
                </button>
            </div>
            <div class='modal-body'>
                <p id='modalMsg'></p>
            </div>
            <div class='modal-footer' id='modalBtn'>
                <button type='button' class='btn btn-secondary' data-dismiss='modal'>아니오</button>
                <button type='button' class='btn btn-primary' id='delLaborerOkBtn'>예</button>
            </div>
        </div>
    </div>
</div>
<body>