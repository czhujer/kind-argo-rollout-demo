Describe 'kind.sh'
  Include spec/lib/common.sh
  It 'kind cluster exists'
    When call list_containers
    The output should equal '3'
    The status should be success
  End

  It 'kind k8s version has specific version'
    When call run_kubectl_version
    The line 2 of output should equal 'Server Version: v1.20.7'
    The status should be success
  End
End
