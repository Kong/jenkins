🚧 This was a repository housing a Dockerfile which was used to create an image Kong's Jenkins instance utilized. With the deprecation/removal of Jenkins KAG-1361, this repo is no longer needed. 🚧

# Jenkins

Dockerfile that add the AWS CLI on to of a jenkins

To update the pinned plugin versions run the following in `/script` of a jenkins instance

```
Jenkins.instance.pluginManager.plugins.each{
  plugin ->
    println ("${plugin.getShortName()}:${plugin.getVersion()}")
}
```

## Local Builds

```bash
docker buildx bake --set default.tags=kong/jenkins -f docker-bake.hcl
```

## Generating a new secrets baseline

Install `detect-secrets` at the version that matches our pre-commit github action:

```bash
pip3 install --upgrade "git+https://github.com/ibm/detect-secrets.git@0.13.1+ibm.50.dss#egg=detect-secrets"
```

Write a new `.secrets.baseline` file:

```bash
detect-secrets scan > .secrets.baseline
```
