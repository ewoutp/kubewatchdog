module github.com/ewoutp/kubewatchdog

go 1.14

replace code.googlesource.com/google-api-go-client => code.googlesource.com/google-api-go-client v0.3.2

replace github.com/golang/lint => golang.org/x/lint v0.0.0-20181026193005-c67002cb31c3

replace github.com/hashicorp/vault/api => github.com/hashicorp/vault/api v1.0.2-0.20190424005855-e25a8a1c7480

replace github.com/hashicorp/vault/sdk => github.com/hashicorp/vault/sdk v0.1.10-0.20190506194144-8fc8af3199a1

replace github.com/hashicorp/vault => github.com/hashicorp/vault v1.1.2

replace github.com/kamilsk/retry => github.com/kamilsk/retry/v3 v3.4.2

replace github.com/nats-io/go-nats-streaming => github.com/nats-io/go-nats-streaming v0.4.4

replace github.com/nats-io/go-nats => github.com/nats-io/go-nats v1.7.2

replace github.com/testcontainers/testcontainer-go => github.com/testcontainers/testcontainers-go v0.0.0-20190108154635-47c0da630f72

replace github.com/ugorji/go => github.com/ugorji/go v0.0.0-20181204163529-d75b2dcb6bc8

replace google.golang.org/api => google.golang.org/api v0.7.0

replace google.golang.org/grpc => google.golang.org/grpc v1.29.1

replace k8s.io/api => k8s.io/api v0.16.9

replace k8s.io/apiextensions-apiserver => k8s.io/apiextensions-apiserver v0.16.9

replace k8s.io/apimachinery => k8s.io/apimachinery v0.16.9

replace k8s.io/apiserver => k8s.io/apiserver v0.16.9

replace k8s.io/client-go => k8s.io/client-go v0.16.9

replace k8s.io/cloud-provider => k8s.io/cloud-provider v0.16.9

replace k8s.io/cluster-bootstrap => k8s.io/cluster-bootstrap v0.16.9

replace k8s.io/code-generator => k8s.io/code-generator v0.16.9

replace k8s.io/component-base => k8s.io/component-base v0.16.9

replace k8s.io/kubernetes => k8s.io/kubernetes v1.16.9

replace k8s.io/metrics => k8s.io/metrics v0.16.9

replace sigs.k8s.io/controller-runtime => sigs.k8s.io/controller-runtime v0.4.0

replace sourcegraph.com/sourcegraph/go-diff => github.com/sourcegraph/go-diff v0.5.0

require (
	github.com/go-logr/zapr v0.1.1 // indirect
	github.com/gogo/protobuf v1.3.1 // indirect
	github.com/golang/protobuf v1.4.1 // indirect
	github.com/google/gofuzz v1.1.0 // indirect
	github.com/imdario/mergo v0.3.9 // indirect
	github.com/json-iterator/go v1.1.8 // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e // indirect
	github.com/onsi/ginkgo v1.11.0 // indirect
	github.com/onsi/gomega v1.8.1 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/rs/zerolog v1.19.0
	github.com/spf13/cobra v1.0.0
	github.com/stretchr/testify v1.6.1 // indirect
	go.uber.org/multierr v1.2.0 // indirect
	golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073 // indirect
	golang.org/x/net v0.0.0-20200301022130-244492dfa37a // indirect
	golang.org/x/oauth2 v0.0.0-20200107190931-bf48bf16ab8d // indirect
	golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527 // indirect
	golang.org/x/time v0.0.0-20191024005414-555d28b269f0 // indirect
	google.golang.org/appengine v1.6.5 // indirect
	gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f // indirect
	k8s.io/api v0.18.2
	k8s.io/apiextensions-apiserver v0.18.2 // indirect
	k8s.io/apimachinery v0.18.2 // indirect
	k8s.io/client-go v12.0.0+incompatible
	k8s.io/utils v0.0.0-20200324210504-a9aa75ae1b89 // indirect
	sigs.k8s.io/controller-runtime v0.5.1-0.20200416234307-5377effd4043
	sigs.k8s.io/yaml v1.2.0 // indirect
)

replace github.com/coreos/prometheus-operator => github.com/coreos/prometheus-operator v0.31.1

replace github.com/coreos/go-systemd => github.com/coreos/go-systemd v0.0.0-20190620071333-e64a0ec8b42a

replace github.com/Azure/go-autorest => github.com/Azure/go-autorest v14.0.1+incompatible

replace golang.org/x/sys => golang.org/x/sys v0.0.0-20191204072324-ce4227a45e2e

replace github.com/cilium/cilium => github.com/cilium/cilium v1.7.2

replace github.com/optiopay/kafka => github.com/optiopay/kafka v2.0.4+incompatible

replace k8s.io/cli-runtime => k8s.io/cli-runtime v0.16.9

replace k8s.io/cri-api => k8s.io/cri-api v0.16.9

replace k8s.io/csi-translation-lib => k8s.io/csi-translation-lib v0.16.9

replace k8s.io/kube-aggregator => k8s.io/kube-aggregator v0.16.9

replace k8s.io/kube-controller-manager => k8s.io/kube-controller-manager v0.16.9

replace k8s.io/kube-proxy => k8s.io/kube-proxy v0.16.9

replace k8s.io/kube-scheduler => k8s.io/kube-scheduler v0.16.9

replace k8s.io/kubelet => k8s.io/kubelet v0.16.9

replace k8s.io/legacy-cloud-providers => k8s.io/legacy-cloud-providers v0.16.9

replace k8s.io/sample-apiserver => k8s.io/sample-apiserver v0.16.9

replace google.golang.org/genproto => google.golang.org/genproto v0.0.0-20191206224255-0243a4be9c8f

replace k8s.io/kubectl => k8s.io/kubectl v0.16.9
