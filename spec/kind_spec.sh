Describe 'kind'
  Include spec/lib/common.sh

  It 'kind containers exists'
    When call list_containers
    The output should equal '3'
    The status should be success
  End

  It 'kind k8s version has specific version'
    When call check_kubectl_version
    The line 2 of output should equal 'Server Version: v1.20.7'
    The lines of stdout should equal 2
    The lines of stderr should equal 0
    The status should be success
  End

End
