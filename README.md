# Jenkins

Dockerfile that add the AWS CLI on to of a jenkins

To update the pinned plugin versions run the following in `/script` of a jenkins instance

```
Jenkins.instance.pluginManager.plugins.each{
  plugin ->
    println ("${plugin.getShortName()}:${plugin.getVersion()}")
}
```
