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

### Skip S3 sync

It may be desirable to skip the `aws s3 sync ...` portion of `entrypoint.sh` when building locally.

The default value of `SKIP_S3` causes the skip to NOT skip this command.

```bash
docker buildx bake --set default.tags=kong/jenkins --set default.args.SKIP_S3=true -f docker-bake.hcl
```
