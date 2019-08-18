
socket = {}

socket.constant = "一个常量"
function socket.test()
	local bb = require("badboy")
	bb.loadluasocket()
	local http = bb.http
	local ltn12 = bb.ltn12
	res, code = http.request('http://www.baidu.com')
	if code == 200 then
	  sysLog(res)
	  dialog(res, 0)
	end
end


return socket