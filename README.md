# README

This Rails project reproduces the `Zlib::GzipFile::Error` error that response body from Google API is already unzipped, but the header is still saying that it's 'gzip' encoding.
Which causes `httplog` to raise exception, because it tries to unzip the already unzipped body.

To see the error, just run the Rspec tests.


Running that test generates for me the following output:
```log
D, [2018-04-26T13:01:13.345001 #22250] DEBUG -- : [httplog] Connecting: www.googleapis.com:443
D, [2018-04-26T13:01:13.453060 #22250] DEBUG -- : [httplog] Sending: POST http://www.googleapis.com:443/oauth2/v3/token
D, [2018-04-26T13:01:13.453139 #22250] DEBUG -- : [httplog] Data: grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJ0ZXN0LTI3MUBleGNlbGlmeS1pby5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL29hdXRoMi92My90b2tlbiIsImV4cCI6MTUyNDczNjkzMywiaWF0IjoxNTI0NzM2ODEzLCJzY29wZSI6Imh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL2F1dGgvZHJpdmUifQ.v_WtUSf3e4CmF-JVCBqYsDNbcLxl7TcWsMD7CnAIMIciuYv0nn4vi4DXP4M-il8sK0KGaDcRz4DnEfC0BUdAnsBgJvCMc8bXVhusvK85Cp1XXeccoh6YVG7iPpFZKkzDXiRuAQmoihNhjcQV7G3pfpQ3DIGX0NIikHICwmePnaCRbJW-P5Ifh2iL17hE_kKgKFr9U-FGpiIbZlkkzVou6AFoVQJmbFAG0uqTzqUZg61S5bdnaqmykIaDiYP__KQhCYSspRQmI1WghvbZJzN8ZqowU3OgzCAsz7W7Rb-7s0deDPP5per8-BRD_Mk-_s-k5qFhXxEZCPpxVz1mcFsMMQ
D, [2018-04-26T13:01:13.522001 #22250] DEBUG -- : [httplog] Status: 200
D, [2018-04-26T13:01:13.522070 #22250] DEBUG -- : [httplog] Benchmark: 0.068816 seconds
D, [2018-04-26T13:01:13.522119 #22250] DEBUG -- : [httplog] Response:
{
 "access_token": "ya29.c.ElmpBZ_49J8E1NuYFaqHTBzRYcTWppzD8UTVg3pXMakzcI7-u01FMoQG1mlRcUxut5yQOilPL5gj__kWjn9CRJ8j8uQNzTgBVmOS-AF3pv2oMylVuNHDocJiGw",
 "token_type": "Bearer",
 "expires_in": 3600
}

D, [2018-04-26T13:01:13.522500 #22250] DEBUG -- : [httplog] Sending: GET https://www.googleapis.com/drive/v2/files?fields=nextPageToken%2C%20items%28%2A%29&spaces=drive
D, [2018-04-26T13:01:13.522536 #22250] DEBUG -- : [httplog] Data: 
D, [2018-04-26T13:01:13.522714 #22250] DEBUG -- : [httplog] Connecting: www.googleapis.com:443
D, [2018-04-26T13:01:13.950919 #22250] DEBUG -- : [httplog] Status: 200
D, [2018-04-26T13:01:13.950965 #22250] DEBUG -- : [httplog] Benchmark: 0.428332 seconds

expected no Exception, got #<Zlib::GzipFile::Error: not in gzip format, input="{\n \"items\": [\n  {\n   \"kind\": \"drive#file\...ttps://www.googleapis.com/drive/v2/files/0Bz7JwK5AH8-qc3RhcnRlcl9maWxl/permissions/me\",\n    \"ro"> with backtrace:
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httplog-1.0.2/lib/httplog/http_log.rb:85:in `initialize'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httplog-1.0.2/lib/httplog/http_log.rb:85:in `new'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httplog-1.0.2/lib/httplog/http_log.rb:85:in `log_body'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httplog-1.0.2/lib/httplog/adapters/httpclient.rb:31:in `do_get_block'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httpclient-2.8.3/lib/httpclient.rb:1019:in `block in do_request'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httpclient-2.8.3/lib/httpclient.rb:1133:in `protect_keep_alive_disconnected'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httpclient-2.8.3/lib/httpclient.rb:1014:in `do_request'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httpclient-2.8.3/lib/httpclient.rb:1104:in `follow_redirect'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/httpclient-2.8.3/lib/httpclient.rb:854:in `request'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/http_command.rb:291:in `execute_once'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/http_command.rb:104:in `block (2 levels) in execute'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/retriable-3.1.1/lib/retriable.rb:61:in `block in retriable'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/retriable-3.1.1/lib/retriable.rb:57:in `times'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/retriable-3.1.1/lib/retriable.rb:57:in `retriable'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/http_command.rb:101:in `block in execute'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/retriable-3.1.1/lib/retriable.rb:61:in `block in retriable'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/retriable-3.1.1/lib/retriable.rb:57:in `times'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/retriable-3.1.1/lib/retriable.rb:57:in `retriable'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/http_command.rb:93:in `execute'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/base_service.rb:360:in `execute_or_queue_command'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/generated/google/apis/drive_v2/service.rb:1290:in `list_files'
  # ./app/lib/google_drive.rb:17:in `block in do_something'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/base_service.rb:51:in `block in initialize'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/base_service.rb:53:in `block in initialize'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/base_service.rb:64:in `block in each'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/base_service.rb:63:in `loop'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/google-api-client-0.20.1/lib/google/apis/core/base_service.rb:63:in `each'
  # ./app/lib/google_drive.rb:23:in `do_something'
  # ./spec/lib/google_drive_spec.rb:6:in `block (3 levels) in <top (required)>'
  # ./spec/lib/google_drive_spec.rb:6:in `block (2 levels) in <top (required)>'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/ruby-debug-ide-0.7.0.beta3/lib/ruby-debug-ide.rb:99:in `debug_load'
  # /Users/maris/.rvm/gems/ruby-2.4.1/gems/ruby-debug-ide-0.7.0.beta3/lib/ruby-debug-ide.rb:99:in `debug_program'
  # -e:1:in `load'
  # -e:1:in `<main>'
./spec/lib/google_drive_spec.rb:6:in `block (2 levels) in <top (required)>'
/Users/maris/.rvm/gems/ruby-2.4.1/gems/ruby-debug-ide-0.7.0.beta3/lib/ruby-debug-ide.rb:99:in `debug_load'
/Users/maris/.rvm/gems/ruby-2.4.1/gems/ruby-debug-ide-0.7.0.beta3/lib/ruby-debug-ide.rb:99:in `debug_program'
-e:1:in `load'
-e:1:in `<main>'

1 example, 1 failure, 0 passed

Finished in 0.659449 seconds
```