# prowup

Prowup is a set of scripts to easily bring up a [kind cluster](https://kind.sigs.k8s.io/) in docker and bootstrap with a fully usable version of [prow](https://github.com/kubernetes/test-infra/tree/master/prow).  Once setup, your cluster is setup with a [smee.io](https://smee.io/) container to deliver webhooks to a development Prow cluster.

## Requirements
* [kind](https://kind.sigs.k8s.io/)
* Docker host with 2-4 CPU &  2-4 GB

## Getting started
```
# Make a real copy of the starter s3 and replace the following values:
cp prow-starter-s3.template.yaml prow-starter-s3.yaml
```
* `<<< GITHUB ORG >>>` - your github org (e.g. github.com/\<org name here>)
* `<<< GITHUB TOKEN >>>` - your github OAUTH token
* `<<< GENERATE HMAC TOKEN >>>` - hmac token generated with `openssl rand -hex 20`
* `<<< SMEE URL >>>` - goto smee.io and generate a new channel (only use this for testing)

Startup prow by running `./start.sh`

This will:
* Startup a kind cluster in docker
* Install nginx ingress into the kind cluster
* Setup prow and make it accessible at https://prow.127.0.0.1.nip.io/

Once complete, you can modify config and containers in the yaml file.

To setup a repo to send webhooks to prow:
* Goto your token section for a given repo (e.g. github.com/yourname/yourproject/settings/hooks)
* Add webhook:
  * Payload url - Add the smee.io url you used above (`<<< SMEE URL >>>`)
  * Content Type - application/json
  * Secret - HMAC Token generated above (`<<< GENERATE HMAC TOKEN >>>`)
  * Which events would you like to trigger this webhook? - Send me everything

## Add more jobs
Here are some options for testing jobs in your test prow cluster:
* Start adding jobs in your [config file](prow-starter-s3.template.yaml#L146-L153)
* Enable [inrepoconfig](https://github.com/kubernetes/test-infra/blob/master/prow/inrepoconfig.md)