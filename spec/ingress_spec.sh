Describe 'k8s ingress'
  Include spec/lib/common.sh

  It 'ingress deploy is OK'
    When call check_ingress_deploy
    The output should equal '1/1 1 1'
    The lines of stderr should equal 0
    The status should be success
  End

  It 'HTTPS on 443 in running'
    When call check_https_port
    The line 1 of stderr should include 'HTTP/1.1 404 Not Found'
    The lines of output should equal 0
    The status should be failure
  End

  It 'HTTP on 80 in running'
    When call check_http_port
    The line 1 of stderr should include 'HTTP/1.1 404 Not Found'
    The lines of output should equal 0
    The status should be failure
  End

End
