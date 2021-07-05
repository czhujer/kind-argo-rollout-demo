Describe 'k8s ingress'
  Include spec/lib/ingress.sh

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

  Describe '-- test app --'
    It 'banana app in running (over ingress)'
      When call check_banana_app
      The output should equal 'banana'
      The stderr should equal ''
      The lines of stderr should equal 0
      The status should be success
    End

    It 'apple app in running (over ingress)'
      When call check_apple_app
      The output should equal 'apple'
      The stderr should equal ''
      The lines of stderr should equal 0
      The status should be success
    End

  End

End
