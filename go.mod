module cluster-info

go 1.15

require (
github.com/aws/aws-sdk-go-v2 v1.3.3
github.com/aws/aws-sdk-go-v2/config v1.1.6
github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.0.6
github.com/aws/aws-sdk-go-v2/service/emr v1.2.2
github.com/bradleyjkemp/cupaloy v2.3.0+incompatible
github.com/golang/mock v1.6.0
github.com/jarcoal/httpmock v1.0.8
github.com/stretchr/testify v1.10.0
)

tool (
github.com/golang/mock/mockgen
github.com/stretchr/testify
)
