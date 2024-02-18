module github.com/bobril/emporia_exporter

go 1.22.0

// https://github.com/cnovak/emporia/pull/2
replace github.com/cnovak/emporia => github.com/bobrik/emporia v0.0.0-20240218232141-0fd87e9f5fbe

require (
	github.com/cnovak/emporia v0.0.0-20230101205639-dce9692193a1
	github.com/prometheus/client_golang v1.18.0
	golang.org/x/exp v0.0.0-20240213143201-ec583247a57a
)

require (
	github.com/alexrudd/cognito-srp/v4 v4.1.0 // indirect
	github.com/aws/aws-sdk-go-v2 v1.17.1 // indirect
	github.com/aws/aws-sdk-go-v2/config v1.18.3 // indirect
	github.com/aws/aws-sdk-go-v2/credentials v1.13.3 // indirect
	github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.12.19 // indirect
	github.com/aws/aws-sdk-go-v2/internal/configsources v1.1.25 // indirect
	github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.4.19 // indirect
	github.com/aws/aws-sdk-go-v2/internal/ini v1.3.26 // indirect
	github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider v1.21.1 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.9.19 // indirect
	github.com/aws/aws-sdk-go-v2/service/sso v1.11.25 // indirect
	github.com/aws/aws-sdk-go-v2/service/ssooidc v1.13.8 // indirect
	github.com/aws/aws-sdk-go-v2/service/sts v1.17.5 // indirect
	github.com/aws/smithy-go v1.13.4 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/cespare/xxhash/v2 v2.2.0 // indirect
	github.com/matttproud/golang_protobuf_extensions/v2 v2.0.0 // indirect
	github.com/prometheus/client_model v0.5.0 // indirect
	github.com/prometheus/common v0.45.0 // indirect
	github.com/prometheus/procfs v0.12.0 // indirect
	golang.org/x/sys v0.15.0 // indirect
	google.golang.org/protobuf v1.31.0 // indirect
)
