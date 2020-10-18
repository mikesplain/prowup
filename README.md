# prowup

Prowup is a set of scripts to easily bring up a [kind cluster](https://kind.sigs.k8s.io/) in docker and bootstrap with a fully usable version of [prow](https://github.com/kubernetes/test-infra/tree/master/prow).

```
# Make a real copy of the starter s3 and replace the following values:
cp prow-starter-s3.template.yaml prow-starter-s3.yaml
```
* `<<< GITHUB ORG >>>` - your github org (e.g. github.com/<org name here>)
* `<<< GITHUB TOKEN >>>` - your github OAUTH token
* `<<< GENERATE HMAC TOKEN >>>` - hmac token generated with `openssl rand -hex 20`
* `<<< SMEE URL >>>` - goto smee.io and generate a new channel (only use this for testing)

Startup prow by running `./start.sh`

This will:
* Startup a kind cluster in docker
* Install nginx ingress into the kind cluster
* Setup prow and make it accessible at https://prow.127.0.0.1.nip.io/