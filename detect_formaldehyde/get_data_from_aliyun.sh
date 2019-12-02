rm -rf /tmp/test_*_json.json
aliyun  iot InvokeDataAPIService --ApiSrn "acs:iot:*:1867700650266651:serveapi/getdata" --Param.1.ParamName pageNo  --Param.1.ParamValue 0 --Param.2.ParamName pageSize --Param.2.ParamValue 200 > /tmp/test_0_json.json
aliyun  iot InvokeDataAPIService --ApiSrn "acs:iot:*:1867700650266651:serveapi/getdata" --Param.1.ParamName pageNo  --Param.1.ParamValue 200 --Param.2.ParamName pageSize --Param.2.ParamValue 200 > /tmp/test_1_json.json
aliyun  iot InvokeDataAPIService --ApiSrn "acs:iot:*:1867700650266651:serveapi/getdata" --Param.1.ParamName pageNo  --Param.1.ParamValue 400 --Param.2.ParamName pageSize --Param.2.ParamValue 200 > /tmp/test_2_json.json
aliyun  iot InvokeDataAPIService --ApiSrn "acs:iot:*:1867700650266651:serveapi/getdata" --Param.1.ParamName pageNo  --Param.1.ParamValue 600 --Param.2.ParamName pageSize --Param.2.ParamValue 200 > /tmp/test_3_json.json
aliyun  iot InvokeDataAPIService --ApiSrn "acs:iot:*:1867700650266651:serveapi/getdata" --Param.1.ParamName pageNo  --Param.1.ParamValue 800 --Param.2.ParamName pageSize --Param.2.ParamValue 200 > /tmp/test_4_json.json
aliyun  iot InvokeDataAPIService --ApiSrn "acs:iot:*:1867700650266651:serveapi/getdata" --Param.1.ParamName pageNo  --Param.1.ParamValue 1000 --Param.2.ParamName pageSize --Param.2.ParamValue 200 > /tmp/test_5_json.json

...


pushd /root/dns/
/usr/bin/python /root/dns/plot_data.py
popd

catimg ~/get_data_2019-12-01.png
